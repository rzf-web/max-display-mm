import 'package:flutter/material.dart';
import 'package:max_display_app/helper/theme.dart';

///
///[TemplateButton] is costumize button.
///
class TemplateButton extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color? color;
  final bool isLoading;
  final Function()? onTap;
  const TemplateButton({
    super.key,
    required this.child,
    required this.onTap,
    this.color,
    this.borderRadius = 8.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? primaryColor,
      ),
      child: isLoading ? btnLoading() : btnChild(),
    );
  }

  Stack btnChild() {
    return Stack(
      children: [
        Center(child: child),
        Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: isLoading ? null : onTap,
          ),
        ),
      ],
    );
  }

  Widget btnLoading() {
    return const _LoadingBtn();
  }
}

class _LoadingBtn extends StatelessWidget {
  const _LoadingBtn();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: Color(0xFFFFFFFF),
                strokeWidth: 2,
              ),
            ),
          ),
          Text(
            "Loading...",
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ],
      ),
    );
  }
}
