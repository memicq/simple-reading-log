import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/widget/component/common/is_bottom_space.dart';
import 'package:simple_book_log/widget/component/common/modal_bottom_sheet.dart';

class BookshelfItemDetailMemoInputModal extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  String initialText;
  void Function(String) onPressed;

  BookshelfItemDetailMemoInputModal({
    Key? key,
    required this.initialText,
    required this.onPressed,
  }) : super(key: key) {
    _controller.text = initialText;
  }

  static void open(
    BuildContext context,
    String initialText,
    void Function(String) onPressed,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => BookshelfItemDetailMemoInputModal(
        initialText: initialText,
        onPressed: onPressed,
      ),
      constraints: const BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheet(
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderConstant.defaultBorderSide,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sticky_note_2_outlined,
                    color: ColorConstants.accentColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "メモを編集",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Scrollbar(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: 100,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: InputBorder.none,
                      hintText: "メモを入力",
                    ),
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: TextButton(
                child: const Text("保存する"),
                onPressed: () => onPressed(_controller.value.text),
              ),
            ),
            const IosBottomSpace(),
          ],
        ),
      ),
    );
  }
}
