part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends EditProfileEvent {
  final UpdateProfileRequestParams params;

  UpdateProfileEvent(this.params);

  @override
  List<Object> get props => [params];
}