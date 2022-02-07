import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_detail_timeline_cubit.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_timeline/bookshelf_item_detail_timeline_item.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/common/bookshelf_item_detail_card.dart';
import 'package:timelines/timelines.dart';

class BookshelfItemDetailTimeline extends StatelessWidget {
  final String bookId;
  final Color mainColor;

  const BookshelfItemDetailTimeline({
    Key? key,
    required this.bookId,
    required this.mainColor,
  }) : super(key: key);

  Widget _buildTimelineItem(List<BookTimelineItemRow> items, int index) {
    BookTimelineItemRow timelineItem = items[index];
    return BookshelfItemDetailTimelineItem(
      dateTime: timelineItem.createdAt,
      text: timelineItem.createTimelineString(),
    );
  }

  Widget? _buildStartConnector(List<BookTimelineItemRow> items, int index) {
    return (index == 0)
        ? DashedLineConnector(color: mainColor)
        : SolidLineConnector(color: mainColor);
  }

  Widget? _buildEndConnector(List<BookTimelineItemRow> items, int index) {
    return (index == items.length - 1) ? null : SolidLineConnector(color: mainColor);
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    BookshelfDetailTimelineCubit _bookshelfDetailTimelineCubit =
        context.read<BookshelfDetailTimelineCubit>();
    _bookshelfDetailTimelineCubit.listAll(_sessionCubit.getCurrentUserId(), bookId);

    return BookshelfItemDetailCard(
      iconData: Icons.timeline,
      title: "タイムライン",
      child: BlocBuilder<BookshelfDetailTimelineCubit, List<BookTimelineItemRow>>(
        bloc: _bookshelfDetailTimelineCubit,
        builder: (context, timelineItems) {
          return Container(
            constraints: const BoxConstraints(minHeight: 20, maxHeight: 300),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Timeline.tileBuilder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  theme: TimelineTheme.of(context).copyWith(nodePosition: 0.1),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  builder: TimelineTileBuilder(
                    contentsAlign: ContentsAlign.basic,
                    indicatorBuilder: (context, index) => OutlinedDotIndicator(
                      color: mainColor,
                    ),
                    startConnectorBuilder: (context, index) =>
                        _buildStartConnector(timelineItems, index),
                    endConnectorBuilder: (context, index) =>
                        _buildEndConnector(timelineItems, index),
                    contentsBuilder: (context, index) => _buildTimelineItem(timelineItems, index),
                    itemCount: timelineItems.length,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
