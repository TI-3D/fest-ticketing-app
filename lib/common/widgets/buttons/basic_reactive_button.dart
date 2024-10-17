import 'package:fest_ticketing/common/bloc/button/button_state.dart';
import 'package:fest_ticketing/common/bloc/button/button_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicReactiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final Widget? child;
  const BasicReactiveButton({
    super.key,
    required this.onPressed,
    this.title = '',
    this.height = 50,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
        builder: (context, state) {
      if (state is ButtonLoadingState) {
        return _loadingButton(context);
      }
      return _initialButton(context);
    });
  }

  Widget _loadingButton(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(),
        child: Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator()));
  }

  Widget _initialButton(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 50),
      ),
      child: child ??
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
          ),
    );
  }
}
