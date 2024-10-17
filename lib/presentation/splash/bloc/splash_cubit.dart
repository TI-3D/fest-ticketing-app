import 'package:fest_ticketing/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(Authenticated());
  }
}