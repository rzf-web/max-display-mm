import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppDataNotFound extends StatelessWidget {
  const AppDataNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            MdiIcons.tableSearch,
            color: const Color(0xFF98a6ad),
            size: 80,
          ),
          const SizedBox(height: 10),
          const Text("Data Tidak Ditemukan")
        ],
      ),
    );
  }
}
