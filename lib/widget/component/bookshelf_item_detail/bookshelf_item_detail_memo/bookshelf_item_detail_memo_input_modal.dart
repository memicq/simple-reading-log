import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/widget/component/common/is_bottom_space.dart';
import 'package:simple_book_log/widget/component/common/modal_bottom_sheet.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';

class BookshelfItemDetailMemoInputTemplate extends StatefulWidget {
  String initialText;
  void Function(String) onPressed;

  BookshelfItemDetailMemoInputTemplate({
    Key? key,
    required this.initialText,
    required this.onPressed,
  }) : super(key: key);

  static void open(
    BuildContext context,
    String initialText,
    void Function(String) onPressed,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => BookshelfItemDetailMemoInputTemplate(
          initialText: initialText,
          onPressed: onPressed,
        ),
      ),
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  State<StatefulWidget> createState() => BookshelfItemDetailMemoInputTemplateState();
}

class BookshelfItemDetailMemoInputTemplateState
    extends State<BookshelfItemDetailMemoInputTemplate> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool _needBottomSpace = true;

  void _onChangeFocusNode() {
    bool hasFocus = _focusNode.hasFocus;
    setState(() {
      _needBottomSpace = !hasFocus;
    });
  }

  @override
  void initState() {
    _controller.text = widget.initialText;
    _focusNode.addListener(_onChangeFocusNode);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      title: "メモを編集",
      body: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                // padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Scrollbar(
                  child: TextField(
                    focusNode: _focusNode,
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
                    onEditingComplete: () {
                      _focusNode.unfocus();
                    },
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border(top: BorderConstant.defaultBorderSide)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  foregroundColor: MaterialStateProperty.all(ColorConstants.accentColor),
                ),
                child: const Text("保存する"),
                onPressed: () => widget.onPressed(_controller.value.text),
              ),
            ),
            if (_needBottomSpace) Container(color: Colors.white, child: IosBottomSpace()),
          ],
        ),
      ),
    );
  }
}
