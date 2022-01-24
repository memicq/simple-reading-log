import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/resource/repository/user_repository.dart';

class SessionCubit extends Cubit<UserRow?> {
  SessionCubit() : super(null);

  UserRow? _userRow;

  final UserRepository _userRepository = UserRepository();

  Future<void> checkInitialLoginState() async {
    User? _user = FirebaseAuth.instance.currentUser;

    if (_user != null && _user.email != null) {
      _userRow = await _userRepository.findBy(_user.email!);
    }

    emit(_userRow);
  }

  String getCurrentUserId() {
    if (_userRow?.userId != null) {
      return _userRow!.userId;
    } else {
      throw Error();
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _userRow = null;
    emit(_userRow);
  }

  /// NOTE(memicq): ログインの流れ
  ///   1. FirebaseAuthで認証
  ///   2. Firestoreの'users'コレクションにユーザーの登録があるかをemailをキーに検索し、該当があれば取得
  ///   3. 上記で該当がなければ、'users'コレクションにデータを追加する
  ///   4. SessionCubitの変数に取得したユーザーのデータ(UserRow)をセットし、emitする
  Future<void> login(LoginAuthenticationType authenticationType) async {
    // TODO(memicq): ログイン失敗したケースを返して画面で扱えるようにする
    User? _user = await _loginBy(authenticationType);
    if (_user == null) return;
    _userRow = await _userRepository.findBy(_user.email!);
    if (_userRow == null) {
      _userRow = UserRow.createNewUser(
        _user.displayName!,
        _user.email!,
        LoginAuthenticationType.google,
      );
      await _userRepository.create(_userRow!);
    }
    emit(_userRow);
  }

  Future<User?> _loginBy(LoginAuthenticationType authenticationType) async {
    switch (authenticationType) {
      case LoginAuthenticationType.google:
        return await _loginByGoogle();
      case LoginAuthenticationType.apple:
        return await _loginByApple();
      default:
        throw UnimplementedError();
    }
  }

  Future<User?> _loginByGoogle() async {
    GoogleSignIn _signIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    FirebaseAuth _auth = FirebaseAuth.instance;

    GoogleSignInAccount? _googleCurrentUser = _signIn.currentUser;
    try {
      _googleCurrentUser ??= await _signIn.signInSilently();
      _googleCurrentUser ??= await _signIn.signIn();
      if (_googleCurrentUser == null) {
        return null;
      }

      GoogleSignInAuthentication _googleAuth = await _googleCurrentUser.authentication;
      AuthCredential _credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );

      User? _user = (await _auth.signInWithCredential(_credential)).user;

      return _user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User?> _loginByApple() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final _rawNonce = generateNonce();
    final _nonce = sha256ofString(_rawNonce);

    final _credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: _nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: _credential.identityToken,
      rawNonce: _rawNonce,
    );
    User? _user = (await FirebaseAuth.instance.signInWithCredential(oauthCredential)).user;

    return _user;
  }
}
