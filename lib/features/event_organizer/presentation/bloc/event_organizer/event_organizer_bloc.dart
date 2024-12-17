import 'package:equatable/equatable.dart';
import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/features/event_organizer/data/models/event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/get_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/update_event_organizer.dart';
import 'package:fest_ticketing/features/home/data/models/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/common/enitites/event_organizer.dart';

part 'event_organizer_event.dart';
part 'event_organizer_state.dart';

class EventOrganizerBloc
    extends Bloc<EventOrganizerEvent, EventOrganizerState> {
  final CreateEventOrganizerUseCase _createEventOrganizerUseCase;
  final GetEventOrganizerUseCase _getEventOrganizerUseCase;
  final UpdateEventOrganizerUseCase _updateEventOrganizerUseCase;

  EventOrganizerBloc({
    required CreateEventOrganizerUseCase createEventOrganizerUseCase,
    required GetEventOrganizerUseCase getEventOrganizerUseCase,
    required UpdateEventOrganizerUseCase updateEventOrganizerUseCase,
  })  : _createEventOrganizerUseCase = createEventOrganizerUseCase,
        _getEventOrganizerUseCase = getEventOrganizerUseCase,
        _updateEventOrganizerUseCase = updateEventOrganizerUseCase,
        super(EventOrganizerInitial()) {
    on<EventOrganizerCreate>(_onCreateEventOrganizer);
    on<EventOrganizerGet>(_onGetEventOrganizer);
    on<EventOrganizerUpdate>(_onUpdateEventOrganizer);
  }

  void _onCreateEventOrganizer(
    EventOrganizerCreate event,
    Emitter<EventOrganizerState> emit,
  ) async {
    emit(EventOrganizerLoading());
    final res = await _createEventOrganizerUseCase(event.params);

    res.fold((l) => emit(EventOrganizerFailure(l.message)), (r) {
      final EventOrganizerEntity eventOrganizer =
          EventOrganizer.fromMap(r['organizer']).toEntity();
      if (r['events'] == null) {
        emit(EventOrganizerSuccess(eventOrganizer, []));
        return;
      }
      final List<EventEntity> events = (r['events'] as List)
          .map((e) => Event.fromMap(e).toEntity())
          .toList();

      emit(EventOrganizerSuccess(eventOrganizer, events));
    });
  }

  void _onGetEventOrganizer(
    EventOrganizerGet event,
    Emitter<EventOrganizerState> emit,
  ) async {
    emit(EventOrganizerLoading());
      final res = await _getEventOrganizerUseCase();

      res.fold((l) => emit(EventOrganizerFailure(l.message)), (r) {
        final EventOrganizerEntity eventOrganizer =
            EventOrganizer.fromMap(r['organizer']).toEntity();
        if (r['events'] == null) {
          emit(EventOrganizerSuccess(eventOrganizer, []));
          return;
        }
        final List<EventEntity> events = (r['events'] as List)
            .map((e) => Event.fromMap(e).toEntity())
            .toList();

        emit(EventOrganizerSuccess(eventOrganizer, events));
      });
  }

  void _onUpdateEventOrganizer(
    EventOrganizerUpdate event,
    Emitter<EventOrganizerState> emit,
  ) async {
    emit(EventOrganizerLoading());
    final res = await _updateEventOrganizerUseCase(event.params);

    res.fold((l) => emit(EventOrganizerFailure(l.message)), (r) {
      final EventOrganizerEntity eventOrganizer =
          EventOrganizer.fromMap(r['organizer']).toEntity();
      if (r['events'] == null) {
        emit(EventOrganizerSuccess(eventOrganizer, []));
        return;
      }
      final List<EventEntity> events = (r['events'] as List)
          .map((e) => Event.fromMap(e).toEntity())
          .toList();

      emit(EventOrganizerSuccess(eventOrganizer, events, message: r['message']));
    });
  }
}
