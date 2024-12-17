part of 'event_creation_bloc.dart';

abstract class EventCreationState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventCreationInitial extends EventCreationState {}

class EventCreationLoading extends EventCreationState {}

class EventCreationSuccess extends EventCreationState {
  final Map<String, dynamic> response;

  EventCreationSuccess(this.response);
}

class EventCreationFailure extends EventCreationState {
  final String message;

  EventCreationFailure(this.message);
}
