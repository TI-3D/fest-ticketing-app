part of 'event_cubit.dart';

abstract class EventState extends Equatable {
  const EventState();
  
  @override
  List<Object?> get props => [];
}

class EventInitial extends EventState {}
class EventLoading extends EventState {}
class EventLoaded extends EventState {
  final List<EventEntity> events;
  final List<EventEntity> popularEvents;
  final List<EventEntity> newestEvents;

  const EventLoaded(this.events, this.popularEvents, this.newestEvents);

  @override
  List<Object?> get props => [events];
}
class EventFailure extends EventState {
  final String message;

  const EventFailure(this.message);

  @override
  List<Object?> get props => [message];
}
