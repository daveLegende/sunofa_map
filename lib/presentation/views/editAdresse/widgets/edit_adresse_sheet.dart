import 'package:flutter/material.dart';
import 'package:sunofa_map/core/utils/constant.dart';

class EditAdresseSheet extends StatelessWidget {
  const EditAdresseSheet({
    super.key,
    required this.button,
  });
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      color: mwhite,
      child: SizedBox(
        height: 60,
        child: button,
      ),
    );
  }
}
