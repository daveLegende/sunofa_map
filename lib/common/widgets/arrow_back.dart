import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    super.key,
    this.routeNamed = "/",
    this.color = AppTheme.primaryColor,
  });
  final String? routeNamed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: HeroIcon(
        HeroIcons.arrowLeftCircle,
        color: color!,
        size: 40,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
