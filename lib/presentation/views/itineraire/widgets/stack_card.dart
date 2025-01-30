import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class CardStack extends StatelessWidget {
  const CardStack({
    super.key,
    required this.destinationName,
    required this.distance,
    required this.estimateTime,
  });
  final double distance;
  final String destinationName, estimateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: context.width / 2.3,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: mwhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  style: AppTheme().stylish1(16, AppTheme.primaryColor),
                  controller:
                      TextEditingController(text: "Ma position actuelle"),
                  decoration: const InputDecoration(
                    prefixIcon: HeroIcon(
                      HeroIcons.mapPin,
                      color: AppTheme.primaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppTheme.primaryColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const CustomDivider(),
                TextFormField(
                  readOnly: true,
                  style: AppTheme().stylish1(16, AppTheme.red),
                  controller: TextEditingController(text: destinationName),
                  decoration: const InputDecoration(
                    prefixIcon: HeroIcon(
                      HeroIcons.mapPin,
                      color: AppTheme.red,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const CustomDivider(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.linear_scale),
                    const SizedBox(width: 5),
                    Text(
                      "${distance.toStringAsFixed(2)} km",
                      style: AppTheme().stylish1(14, mblack),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("⏳"),
                    const SizedBox(width: 5),
                    Text(estimateTime, style: AppTheme().stylish1(14, mblack)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
