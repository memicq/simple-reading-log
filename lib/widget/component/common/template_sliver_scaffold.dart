import 'package:flutter/material.dart';
import 'package:simple_book_log/const/sizes.dart';
import 'package:simple_book_log/widget/component/common/template_app_bar.dart';

class TemplateSliverScaffold extends StatefulWidget {
  final String title;
  final Widget floatingActionButton;
  final List<Widget> children;
  final Widget header;

  const TemplateSliverScaffold({
    Key? key,
    required this.title,
    required this.header,
    required this.children,
    required this.floatingActionButton,
  }) : super(key: key);

  @override
  _TemplateSliverScaffoldState createState() => _TemplateSliverScaffoldState();
}

class _TemplateSliverScaffoldState extends State<TemplateSliverScaffold> {
  final ScrollController _controller = ScrollController();

  double _parentAppBarElevation = 0.0;
  double _childAppBarElevation = 1.5;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset > 55.0 && _parentAppBarElevation == 0.0) {
      setState(() {
        _parentAppBarElevation = 1.5;
        _childAppBarElevation = 0.0;
      });
    } else if (_controller.offset < 55.0 && _parentAppBarElevation == 1.5) {
      setState(() {
        _parentAppBarElevation = 0.0;
        _childAppBarElevation = 1.5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TemplateAppBar(
        title: widget.title,
        appBarElevation: _parentAppBarElevation,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _controller,
            slivers: [
              SliverAppBar(
                title: widget.header,
                elevation: _childAppBarElevation,
                forceElevated: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(widget.children),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: widget.floatingActionButton,
          ),
        ],
      ),
    );
  }
}
