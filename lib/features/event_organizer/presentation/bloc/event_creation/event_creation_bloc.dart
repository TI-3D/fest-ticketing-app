import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event.dart';

part 'event_creation_event.dart';
part 'event_creation_state.dart';

class EventCreationBloc extends Bloc<EventCreationEvent, EventCreationState> {
  final CreateEventUseCase _createEventUseCase;

  EventCreationBloc({required CreateEventUseCase createEventUseCase})
      : _createEventUseCase = createEventUseCase,
        super(EventCreationInitial()) {
    on<EventCreationSubmit>(_onEventCreationSubmit);
  }

  void _onEventCreationSubmit(EventCreationSubmit event, Emitter<EventCreationState> emit) async {
    emit(EventCreationLoading());
    final res = await _createEventUseCase(event.params);

    res.fold(
      (failure) => emit(EventCreationFailure(failure.message)),
      (response) => emit(EventCreationSuccess(response)),
    );
  }
}