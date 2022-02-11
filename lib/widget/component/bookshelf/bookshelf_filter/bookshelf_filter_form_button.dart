import 'package:flutter/material.dart';
import 'package:simple_book_log/const/shadows.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_filter/bookshelf_filter_form.dart';

class BookshelfFilterFormButton extends StatefulWidget {
  Color accentColor;

  BookshelfFilterFormButton({
    Key? key,
    required this.accentColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BookshelfFilterFormButtonState();
}

class BookshelfFilterFormButtonState extends State<BookshelfFilterFormButton> {
  bool _isFormOpened = false;

  void toggleFormOpen() {
    setState(() {
      _isFormOpened = !_isFormOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _maxWidth = MediaQuery.of(context).size.width - 49;

    Widget _child = _isFormOpened
        ? BookshelfFilterForm(
            accentColor: widget.accentColor,
          )
        : Center(child: Icon(Icons.filter_list));

    BorderRadius _borderRadius =
        _isFormOpened ? BorderRadius.circular(10) : BorderRadius.circular(55 / 2);

    return AnimatedContainer(
      margin: EdgeInsets.all(4.5),
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 300),
      height: _isFormOpened ? 300 : 55,
      width: _isFormOpened ? _maxWidth : 55,
      decoration: BoxDecoration(
        color: _isFormOpened ? Colors.white : Colors.grey.shade100,
        borderRadius: _borderRadius,
        boxShadow: [Shadows.mainShadowBottom],
      ),
      child: InkWell(
        onTap: toggleFormOpen,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            reverseDuration: Duration(milliseconds: 0),
            switchInCurve: Curves.easeInCubic,
            child: _child,
          ),
        ),
      ),
    );
  }
}
