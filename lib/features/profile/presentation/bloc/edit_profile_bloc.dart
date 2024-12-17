import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fest_ticketing/common/bloc/app_user/app_user_cubit.dart';
import 'package:fest_ticketing/common/enitites/user.dart';
import 'package:fest_ticketing/features/profile/domain/usecase/update_user_profile.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final AppUserCubit appUserCubit;

  EditProfileBloc({
    required this.updateProfileUseCase,
    required this.appUserCubit,
  }) : super(EditProfileInitial()) {
    on<UpdateProfileEvent>(_onEditProfile);
  }

  void _onEditProfile(
    UpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    final result = await updateProfileUseCase.call(event.params);
    emit(result.fold(
      (failure) {
        print('Update failed: ${failure.message}');
        return EditProfileFailure(failure.message);
      },
      (success) {
        if (success is UserEntity) {
          print('Profile updated successfully: ${success.fullName}');
          appUserCubit.updateUser(success);
        }
        return EditProfileSuccess();
      },
    ));
  }
}
