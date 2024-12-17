part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;

  EditProfileSuccess({this.message = 'Profile updated successfully'});
}

class EditProfileFailure extends EditProfileState {
  final String message;

  EditProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}