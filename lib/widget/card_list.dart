import 'package:flutter/material.dart';
import 'package:max_display_app/helper/theme.dart';
import 'package:max_display_app/helper/utils.dart';

class CardList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;
  final Function() onTap;
  const CardList({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: getWidth(),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: Color(0xFFD9D9D9))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(title),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFABABAB),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFABABAB),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
