import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_book_log/bloc/event/tab_controller_event.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/tab_controller_bloc.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/const/shadows.dart';
import 'package:simple_book_log/resource/model/state/session_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/widget/app_builder.dart';
import 'package:simple_book_log/widget/component/common/admob_large_banner.dart';
import 'package:simple_book_log/widget/component/common/bottom_tab_item.dart';
import 'package:simple_book_log/widget/component/common/is_bottom_space.dart';
import 'package:simple_book_log/widget/component/common/tab_page.dart';
import 'package:simple_book_log/widget/component/loading/loading_template.dart';
import 'package:simple_book_log/widget/screen/bookshelf_screen.dart';
import 'package:simple_book_log/widget/screen/login_or_register_screen.dart';
import 'package:simple_book_log/widget/screen/statistics_screen.dart';
import 'package:simple_book_log/widget/screen/setting_screen.dart';

class ApplicationLayout extends StatelessWidget {
  const ApplicationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TabControllerBloc(),
        ),
      ],
      child: ApplicationLayoutInner(),
    );
  }
}

class ApplicationLayoutInner extends StatelessWidget {
  ApplicationLayoutInner({Key? key}) : super(key: key);

  List<TabPage> defaultPages = [
    TabPage(
      openEvent: TabControllerEvent.bookshelf,
      menuItem: BottomTabItem(
        isActive: false,
        iconData: Icons.book_outlined,
        filledIconData: Icons.book_rounded,
        menuTitle: "本棚",
        onPressed: () {},
      ),
      content: BookshelfScreen(),
    ),
    TabPage(
      openEvent: TabControllerEvent.statistics,
      menuItem: BottomTabItem(
        isActive: false,
        iconData: Icons.bar_chart_outlined,
        filledIconData: Icons.bar_chart_rounded,
        menuTitle: "記録",
        onPressed: () {},
      ),
      content: StatisticsScreen(),
    ),
    TabPage(
      openEvent: TabControllerEvent.setting,
      menuItem: BottomTabItem(
        isActive: false,
        iconData: Icons.settings_outlined,
        filledIconData: Icons.settings_rounded,
        menuTitle: "設定",
        onPressed: () {},
      ),
      content: SettingScreen(),
    ),
  ];

  late TabControllerEvent activeTabEvent = TabControllerEvent.bookshelf;
  late List<TabPage> pages;

  List<TabPage> updatePages(TabControllerBloc bloc) {
    return defaultPages.map((page) {
      bool isActive = (page.openEvent == activeTabEvent);
      return page.update(isActive, () => bloc.changePage(page.openEvent));
    }).toList();
  }

  Widget buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.mainBgColor,
        boxShadow: [Shadows.mainShadow],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: pages.map((page) => page.menuItem).toList(),
            ),
          ),
          const IosBottomSpace(),
        ],
      ),
    );
  }

  void _checkLoginStateAfterBuild(
    BuildContext context,
    SessionCubitState sessionState,
  ) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (sessionState.shouldShowSignInScreen()) {
        LoginOrRegisterScreen.open(
          context,
          fullscreenDialog: true,
          callback: () {
            AppBuilder.of(context)?.rebuild();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TabControllerBloc _bloc = context.read<TabControllerBloc>();
    SessionCubit _sessionCubit = context.read<SessionCubit>();

    pages = updatePages(_bloc);

    return BlocBuilder<SessionCubit, SessionCubitState>(
      bloc: _sessionCubit,
      builder: (context, sessionState) {
        _checkLoginStateAfterBuild(context, sessionState);

        if (sessionState.isFirstFetching || sessionState.currentUser == null) {
          return LoadingTemplate();
        }

        return BlocBuilder<TabControllerBloc, TabControllerEvent>(
          bloc: _bloc,
          builder: (context, event) {
            // NOTE(memicq): 値が存在しないケースは考慮しない
            StatelessWidget content = pages.firstWhere((page) => page.openEvent == event).content;

            activeTabEvent = event;
            pages = updatePages(_bloc);

            return Material(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(child: content),
                    if (sessionState.currentUser!.isAdvertisementEnabled) AdmobLargeBanner(),
                    buildTabBar(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
