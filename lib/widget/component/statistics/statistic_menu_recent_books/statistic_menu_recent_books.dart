import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/statistic_menu_recent_book_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/view/book_with_period.dart';
import 'package:simple_book_log/util/datetime_util.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu/statistic_menu_card.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_recent_books/statistic_menu_recent_book_item.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_recent_books/statistic_menu_recent_book_not_found.dart';

class StatisticMenuRecentBook extends StatelessWidget {
  StatisticMenuRecentBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatisticMenuRecentBookCubit _cubit = context.read<StatisticMenuRecentBookCubit>();

    return StatisticMenuCard(
      title: "直近読んだ本",
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 10, maxHeight: 400),
        child: SingleChildScrollView(
          child: BlocBuilder<StatisticMenuRecentBookCubit, List<BookWithPeriod>>(
            bloc: _cubit,
            builder: (context, bookWithPeriods) {
              if (bookWithPeriods.isEmpty) {
                return StatisticMenuRecentBookNotFound();
              }

              return Column(
                children: bookWithPeriods
                    .map(
                      (bookWithPeriod) => StatisticMenuRecentBookItem(
                        title: bookWithPeriod.bookRow.title,
                        start: bookWithPeriod.startDate,
                        end: bookWithPeriod.endDate,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
