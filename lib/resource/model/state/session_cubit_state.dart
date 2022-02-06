import 'package:simple_book_log/resource/model/table/user_row.dart';

class SessionCubitState {
  final bool isFirstFetching;
  final UserRow? currentUser;

  SessionCubitState({
    required this.isFirstFetching,
    required this.currentUser,
  });

  static SessionCubitState initialState = SessionCubitState(
    isFirstFetching: true,
    currentUser: null,
  );

  SessionCubitState copyWith({
    bool? isFirstFetching,
    required UserRow? currentUser,
  }) {
    return SessionCubitState(
      isFirstFetching: isFirstFetching ?? this.isFirstFetching,
      currentUser: currentUser,
    );
  }

  bool shouldShowSignInScreen() {
    return !isFirstFetching && currentUser == null;
  }
}
