import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/const/constants.dart';
import 'package:simple_book_log/const/themes.dart';
import 'package:simple_book_log/widget/app_builder.dart';
import 'package:simple_book_log/widget/application_layout.dart';

class RootApplication extends StatelessWidget {
  const RootApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NOTE(memicq): Navigator.pushの先のページでもセッション情報を取得したいので、ここにSessionCubitのProviderを配置
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionCubit>(
          create: (_) => SessionCubit()..checkInitialLoginState(),
        ),
      ],
      child: AppBuilder(
        builder: (context) {
          return KeyboardDismissOnTap(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Constants.applicationTitle,
              key: key,
              theme: ThemeData(
                scaffoldBackgroundColor: ColorConstants.subBgColor,
                appBarTheme: Themes.appBarTheme,
              ),
              home: const ApplicationLayout(),
            ),
          );
        },
      ),
    );
  }
}
