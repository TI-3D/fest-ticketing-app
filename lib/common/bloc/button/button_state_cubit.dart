import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/common/bloc/button/button_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoadingState());

    try {
      final result = await usecase.call(params: params);
      result.fold(
        (l) => emit(ButtonFailureState(
          message: l,
        )),
        (r) => emit(ButtonSuccessState(
          message: r,
        )),
      );
    } catch (e) {
      emit(ButtonFailureState(
        message: e.toString(),
      ));
    }
  }
}
