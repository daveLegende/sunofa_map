import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';

class ItineraireScreen extends StatelessWidget {
  const ItineraireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage("assets/itineraire.jpeg"),
            ),
          ),
          const SafeArea(
            child: BackArrow(
              routeNamed: Routes.infoAdresseScreen,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Card(
              elevation: 10,
              child: Container(
                height: context.width / 2.5,
                decoration: BoxDecoration(
                  color: mwhite,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
