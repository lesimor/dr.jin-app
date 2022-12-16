// Flutter imports:
import 'package:flutter/material.dart';

class TabBadge extends StatelessWidget {
  final int count;

  TabBadge({
    Key? key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${count}"),
    );
  }
}
