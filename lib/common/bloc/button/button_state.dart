abstract class ButtonState {}

class ButtonInitialState extends ButtonState {}

class ButtonLoadingState extends ButtonState {}

class ButtonSuccessState extends ButtonState {
  final String message;
  ButtonSuccessState({required this.message});
}

class ButtonFailureState extends ButtonState {
  final String message;
  ButtonFailureState({required this.message});
}
