import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class NotFoundText extends StatelessWidget {
  const NotFoundText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTheme().stylish1(15, mgrey),
    );
  }
}
