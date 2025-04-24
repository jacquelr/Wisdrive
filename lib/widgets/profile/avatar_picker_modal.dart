import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/generated/l10n.dart';

class AvatarPickerModal extends StatelessWidget {
  final void Function(int selectedAvatar) onSelected;

  const AvatarPickerModal({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: HelperFunctions.getContainerThemeColor(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).pick_avatar,
              style: GoogleFonts.play(color: HelperFunctions.getWhiteBgTextThemeColor(),fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              itemCount: RAvatars.avatarMap.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final entry = RAvatars.avatarMap.entries.elementAt(index);
                final avatarKey = entry.key;
                final avatarPath = entry.value;

                return GestureDetector(
                  onTap: () {
                    onSelected(avatarKey);
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(avatarPath),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
