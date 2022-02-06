import 'package:simple_book_log/resource/model/enum/application_theme.dart';

class ApplicationThemeCubitState {
  final ApplicationTheme theme;

  ApplicationThemeCubitState({
    required this.theme,
  });

  static ApplicationThemeCubitState initialState = ApplicationThemeCubitState(
    theme: ApplicationTheme.defaultGray,
  );

  ApplicationThemeCubitState copyWith({
    ApplicationTheme? theme,
  }) {
    return ApplicationThemeCubitState(
      theme: theme ?? this.theme,
    );
  }
}
