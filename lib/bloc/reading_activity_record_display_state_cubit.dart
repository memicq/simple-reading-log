import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

class ReadingActivityRecordDisplayStateCubit extends Cubit<Tuple2<bool, bool>> {
  ReadingActivityRecordDisplayStateCubit() : super(Tuple2<bool, bool>(true, false));

  bool isDateFormClosed = true;
  bool isBooksFormClosed = false;

  void toggleDateFormClosed() {
    if (!isDateFormClosed) {
      // (false, *)
      isDateFormClosed = true;
    } else if (isBooksFormClosed) {
      // (true, true)
      isDateFormClosed = false;
    } else {
      // (true, false)
      isDateFormClosed = false;
      isBooksFormClosed = true;
    }

    emit(Tuple2(isDateFormClosed, isBooksFormClosed));
  }

  void toggleBooksFormClosed() {
    if (!isBooksFormClosed) {
      // (*, false)
      isBooksFormClosed = true;
    } else if (isDateFormClosed) {
      // (true, true)
      isBooksFormClosed = false;
    } else {
      // (false, true)
      isBooksFormClosed = false;
      isDateFormClosed = true;
    }

    emit(Tuple2(isDateFormClosed, isBooksFormClosed));
  }
}
