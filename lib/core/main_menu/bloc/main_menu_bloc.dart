import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc() : super(const MainMenuInitial(0)) {
    on<MainMenuEvent>((event, emit) {
      if (event is ChangeTabEvent) {
        emit(MainMenuInitial(event.tabIndex));
      }
    });
  }
}
