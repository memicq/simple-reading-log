import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/state/application_theme_cubit_state.dart';

class ApplicationThemeCubit extends Cubit<ApplicationThemeCubitState> {
  ApplicationThemeCubit() : super(ApplicationThemeCubitState.initialState);

  ApplicationThemeCubitState state = ApplicationThemeCubitState.initialState;
}
