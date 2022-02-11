import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';

class RoundedPrimaryButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onPressed;
  Color? backgroundColor;

  RoundedPrimaryButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        height: 55,
        child: Icon(
          iconData,
          size: 25,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor ?? _sessionCubit.getAccentColor(),
        onPrimary: Colors.white,
        shape: const CircleBorder(),
      ),
    );
  }
}
