import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  final Widget child;

  const ModalBottomSheet({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 64),
      constraints: const BoxConstraints(minHeight: 70),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
            child: Icon(
              Icons.horizontal_rule,
              color: Colors.grey,
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
