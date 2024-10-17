part of 'main_menu_bloc.dart';

sealed class MainMenuEvent extends Equatable {
  const MainMenuEvent(this.tabIndex);

  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];
}

final class ChangeTabEvent extends MainMenuEvent {
  const ChangeTabEvent(super.tabIndex);
}