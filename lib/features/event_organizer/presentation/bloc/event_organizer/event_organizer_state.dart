part of 'event_organizer_bloc.dart';

abstract class EventOrganizerState extends Equatable {

  @override
  List<Object> get props => [];
}

class EventOrganizerInitial extends EventOrganizerState {}

class EventOrganizerLoading extends EventOrganizerState {}

class EventOrganizerSuccess extends EventOrganizerState {
  final EventOrganizerEntity eventOrganizer;
  final List<EventEntity> events;
  final String? message;

  EventOrganizerSuccess(this.eventOrganizer, this.events, {this.message});
}

class EventOrganizerFailure extends EventOrganizerState {
  final String message;

  EventOrganizerFailure(this.message);
}