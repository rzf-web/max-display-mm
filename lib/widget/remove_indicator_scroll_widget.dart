import 'package:flutter/material.dart';

class RemoveScrollIndicator extends StatelessWidget {
  final Widget child;
  const RemoveScrollIndicator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}
