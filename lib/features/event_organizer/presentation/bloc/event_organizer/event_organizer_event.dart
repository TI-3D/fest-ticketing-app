part of 'event_organizer_bloc.dart';

abstract class EventOrganizerEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class EventOrganizerCreate extends EventOrganizerEvent {
  final CreateEventOrganizerRequestParams params;

  EventOrganizerCreate(this.params);
}

class EventOrganizerGet extends EventOrganizerEvent {}

class EventOrganizerUpdate extends EventOrganizerEvent {
  final UpdateEventOrganizerRequestParams params;

  EventOrganizerUpdate(this.params);
}