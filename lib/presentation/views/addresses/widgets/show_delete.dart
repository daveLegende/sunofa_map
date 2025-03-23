import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class DeleteAdresseWidget extends StatelessWidget {
  const DeleteAdresseWidget({
    super.key,
    required this.size,
    required this.onDel,
    required this.onCancel,
    this.delOrLogoutText = "Supprimer",
    this.text = "Voulez-vous supprimer l'élément selectionné ?",
  });

  final Size size;
  final String? text, delOrLogoutText;
  final VoidCallback onCancel, onDel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * .3,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: mwhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text!,
            style: AppTheme().stylish1(15, mblack),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          const CustomDivider(),
          Row(
            children: [
              Expanded(
                child: DeleteOrCancel(
                  color: mred,
                  text: "address.cancel".tr(),
                  onTap: onCancel,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: AppTheme.lightPrimary,
              ),
              Expanded(
                child: DeleteOrCancel(
                  color: AppTheme.mintGreen,
                  text: delOrLogoutText!,
                  onTap: onDel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeleteOrCancel extends StatelessWidget {
  const DeleteOrCancel({
    super.key,
    required this.color,
    required this.text,
    this.onTap,
  });
  final Color color;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            text,
            style: AppTheme().stylish1(15, color),
          ),
        ),
      ),
    );
  }
}
