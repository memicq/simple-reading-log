import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';

class SettingMenuItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final void Function()? onPressed;

  const SettingMenuItem({
    Key? key,
    required this.iconData,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderConstant.defaultBorderSide,
                bottom: BorderConstant.defaultBorderSide,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    iconData,
                    color: _sessionCubit.getAccentColor(),
                  ),
                ),
                Expanded(
                  child: Text(title),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
