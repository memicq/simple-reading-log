import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/resource/model/state/session_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/resource/repository/user_repository.dart';

class SessionCubit extends Cubit<SessionCubitState> {
  SessionCubit() : super(SessionCubitState.initialState);

  SessionCubitState _state = SessionCubitState.initialState;
  final UserRepository _userRepository = UserRepository();

  Future<void> checkInitialLoginState() async {
    User? _user = FirebaseAuth.instance.currentUser;
    UserRow? _userRow;
    if (_user != null) _userRow = await _userRepository.findByUid(_user.uid);

    _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
    emit(_state);
  }

  String getCurrentUserId() {
    if (_state.currentUser?.userId != null) {
      return _state.currentUser!.userId;
    } else {
      throw Error();
    }
  }

  Future<void> logout() async {
    if (_state.currentUser?.authenticationType == LoginAuthenticationType.anonymous) {
      await _userRepository.delete(_state.currentUser!.userId);
      await FirebaseAuth.instance.currentUser!.delete();
    } else {
      await FirebaseAuth.instance.signOut();
    }

    _state = _state.copyWith(isFirstFetching: false, currentUser: null);
    emit(_state);
  }

  Future<void> loginBy(
    LoginAuthenticationType authenticationType, {
    String? email,
    String? password,
  }) async {
    switch (authenticationType) {
      case LoginAuthenticationType.google:
        return await _loginByGoogle();
      case LoginAuthenticationType.apple:
        return await _loginByApple();
      case LoginAuthenticationType.email:
        return await _loginByEmail(email!, password!);
      case LoginAuthenticationType.anonymous:
        return await _loginAnonymously();
      default:
        throw UnimplementedError();
    }
  }

  Future<void> linkWith(
    LoginAuthenticationType authenticationType, {
    String? email,
    String? password,
  }) async {
    switch (authenticationType) {
      case LoginAuthenticationType.google:
        return await _linkWithGoogle();
      case LoginAuthenticationType.apple:
        return await _linkWithApple();
      case LoginAuthenticationType.email:
        return await _linkWithEmail(email!, password!);
      default:
        throw UnimplementedError();
    }
  }

  Future<void> _loginByGoogle() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      AuthCredential? _credential = await _getCredentialByGoogle();
      User? _user = (await _auth.signInWithCredential(_credential!)).user;
      UserRow _userRow = await _getOrCreateUserRow(LoginAuthenticationType.google, _user!);

      _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
      emit(_state);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _linkWithGoogle() async {
    try {
      User _oldUser = FirebaseAuth.instance.currentUser!;
      AuthCredential? _credential = await _getCredentialByGoogle();
      User? _user =
          (await FirebaseAuth.instance.currentUser!.linkWithCredential(_credential!)).user;
      UserRow _userRow = await _updateUserRow(LoginAuthenticationType.google, _oldUser, _user!);
      await _oldUser.delete();

      _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
      emit(_state);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loginByApple() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      AuthCredential? _credential = await _getCredentialByApple();
      User? _user = (await _auth.signInWithCredential(_credential!)).user;
      UserRow _userRow = await _getOrCreateUserRow(LoginAuthenticationType.apple, _user!);

      _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
      emit(_state);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _linkWithApple() async {
    try {
      User _oldUser = FirebaseAuth.instance.currentUser!;
      AuthCredential? _credential = await _getCredentialByApple();
      User? _user =
          (await FirebaseAuth.instance.currentUser!.linkWithCredential(_credential!)).user;
      UserRow _userRow = await _updateUserRow(LoginAuthenticationType.apple, _oldUser, _user!);
      await _oldUser.delete();

      _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
      emit(_state);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loginByEmail(String email, String password) async {
    try {
      UserCredential? _credential = await _getCredentialByEmail(email, password);
      User? _user = _credential?.user;
      UserRow _userRow = await _getOrCreateUserRow(LoginAuthenticationType.email, _user!);

      _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
      emit(_state);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _linkWithEmail(String email, String password) async {
    try {
      User _oldUser = FirebaseAuth.instance.currentUser!;
      UserCredential? _credential = await _getCredentialByEmail(email, password);
      User? _user = _credential?.user;
      UserRow _userRow = await _updateUserRow(LoginAuthenticationType.email, _oldUser, _user!);
      await _oldUser.delete();

      _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
      emit(_state);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loginAnonymously() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      User? _user = (await _auth.signInAnonymously()).user;
      UserRow _userRow = await _getOrCreateUserRow(LoginAuthenticationType.anonymous, _user!);

      _state = _state.copyWith(isFirstFetching: false, currentUser: _userRow);
      emit(_state);
    } catch (e) {
      print(e);
    }
  }

  Future<AuthCredential?> _getCredentialByGoogle() async {
    GoogleSignIn _signIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
    );
    GoogleSignInAccount? _googleCurrentUser = _signIn.currentUser;

    // _googleCurrentUser ??= await _signIn.signInSilently();
    _googleCurrentUser ??= await _signIn.signIn();
    if (_googleCurrentUser == null) return null;

    GoogleSignInAuthentication _googleAuth = await _googleCurrentUser.authentication;
    return GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );
  }

  Future<AuthCredential?> _getCredentialByApple() async {
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    final _rawNonce = generateNonce();
    final _nonce = sha256ofString(_rawNonce);

    final _credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: _nonce,
    );

    return OAuthProvider("apple.com").credential(
      idToken: _credential.identityToken,
      rawNonce: _rawNonce,
    );
  }

  Future<UserCredential?> _getCredentialByEmail(String email, String password) async {
    UserRow? _userRow = await _userRepository.findBy(email);

    if (_userRow == null) {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } else {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    }
  }

  Future<UserRow> _getOrCreateUserRow(LoginAuthenticationType authenticationType, User user) async {
    UserRow? _userRow = await _userRepository.findByUid(user.uid);

    if (_userRow == null) {
      _userRow = UserRow.createNewUser(
        uid: user.uid,
        authenticationType: authenticationType,
        email: user.email,
        displayName: user.displayName,
      );
      await _userRepository.create(_userRow);
    }

    return _userRow;
  }

  Future<UserRow> _updateUserRow(
    LoginAuthenticationType authenticationType,
    User oldUser,
    User newUser,
  ) async {
    UserRow _userRow = (await _userRepository.findByUid(oldUser.uid))!;

    if (_userRow.authenticationType == LoginAuthenticationType.anonymous) {
      _userRow = _userRow.copyWith(
        uid: newUser.uid,
        displayName: newUser.displayName,
        email: newUser.email,
        authenticationType: authenticationType,
      );
      await _userRepository.update(_userRow);
    }

    return _userRow;
  }
}
