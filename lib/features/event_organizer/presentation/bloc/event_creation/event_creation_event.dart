part of 'event_creation_bloc.dart';

abstract class EventCreationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventCreationSubmit extends EventCreationEvent {
  final CreateEventRequestParams params;

  EventCreationSubmit(this.params);
}