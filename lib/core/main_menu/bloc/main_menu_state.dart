part of 'main_menu_bloc.dart';

sealed class MainMenuState extends Equatable {
  const MainMenuState(this.tabIndex);

  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];
}

final class MainMenuInitial extends MainMenuState {
  const MainMenuInitial(super.tabIndex);
}