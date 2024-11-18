
import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class VocalAdresse extends StatelessWidget {
  const VocalAdresse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        // vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.play_arrow,
            size: 30,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Slider(
              activeColor: AppTheme.primaryColor,
              inactiveColor: Colors.grey[600],
              value: 0,
              onChanged: (value) {},
              min: 0.0,
              max: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}

class AdresseImage extends StatelessWidget {
  const AdresseImage({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image(
        height: 100,
        fit: BoxFit.cover,
        image: AssetImage(image),
      ),
    );
  }
}
