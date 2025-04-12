import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/blocs/notifications/sendPin/send_pin_cubit.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ConfirmModalSheet extends StatelessWidget {
  const ConfirmModalSheet({
    super.key,
    required this.address,
    required this.requestedBy,
    required this.id,
  });

  final Map<String, dynamic> address;
  final Map<String, dynamic> requestedBy;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.width / 2,
      margin: const EdgeInsets.only(
        bottom: 50,
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: mwhite,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Confirmation",
            style: AppTheme().stylish1(
              18,
              mblack,
              isBold: true,
            ),
          ),
          Text(
            "En effectuant cette action, vous envoyez le code PIN de l'adresse: ${address["adressName"]} à l'utilisateur: ${requestedBy["name"]}.",
            style: AppTheme().stylish1(
              15,
              mblack,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              Expanded(
                child: SubmitButton(
                  color: AppTheme.complementaryColor,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: "Annuler",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: SubmitButton(
                  onTap: () async {
                    Navigator.pop(context);
                    // Afficher un indicateur de progression
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const LoadingCircle(),
                    );

                    try {
                      // Exécuter la suppression
                      await context
                          .read<SendPinCubit>()
                          .sendPin(
                            IdParms(
                              id: address["id"],
                            ),
                          )
                          .then((_) async {
                        print("---------_-_____$id-_-__-_-_-_-_-_-");
                        await PreferenceServices().deleteNotification(id);
                        await PreferenceServices().getSavedNotifications();
                      });
                    } finally {
                      Navigator.pop(context);
                    }
                  },
                  text: "Envoyer",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
