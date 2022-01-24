import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/event/tab_controller_event.dart';

class TabControllerBloc extends Bloc<TabControllerEvent, TabControllerEvent> {
  TabControllerBloc() : super(TabControllerEvent.bookshelf);

  void changePage(TabControllerEvent event) {
    emit(event);
  }
}
