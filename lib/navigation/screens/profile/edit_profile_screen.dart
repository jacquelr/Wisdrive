import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/navigation/screens/profile/update_password_screen.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/service/supabase_service.dart';
import 'package:wisdrive/widgets/profile/avatar_picker_modal.dart';
import 'package:wisdrive/widgets/profile/editprofile_inputs.dart';
import 'package:wisdrive/widgets/profile/profile_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final authService = AuthService();
  final supabaseService = SupabaseService();

  int? selectedAvatar;

  @override
  void initState() {
    super.initState();
    loadUserAvatar();
  }

  Future<void> loadUserAvatar() async {
    final avatarIndex = await supabaseService.getUserAvatar();
    setState(() {
      selectedAvatar = avatarIndex;
    });
  }

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();

    void showAvatarPicker(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AvatarPickerModal(
          onSelected: (int avatarKey) {
            if (authService.isFirstTimeLogged()) {
              setState(() {
                selectedAvatar = avatarKey;
              });
            } else {
              supabaseService.setUserAvatar(avatarKey);
              setState(() {
                selectedAvatar = avatarKey;
              });
            }
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: themeController.isDarkMode.value
          ? AppTheme.darkPurple
          : AppTheme.lightBackground,
      appBar: ProfileAppbar(appbarTitle: S.of(context).edit_profile),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
            ),
            Stack(
              // Choose profile image container
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Container(
                    // Image View container
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: FutureBuilder<String>(
                      future:
                          supabaseService.getAvatarImagePath(selectedAvatar),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey,
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return const CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage(RImages.profilePickImage),
                          );
                        }

                        return CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage(snapshot.data!),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  // Set this widget on bottom-right of Choose profile image container
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => showAvatarPicker(context),
                    child: Container(
                      // Edit image button container
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppTheme.lightSecondary),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () => showAvatarPicker(context),
              child: Text(
                S.of(context).change_picture,
                style: GoogleFonts.play(
                    color: AppTheme.lightSecondary, fontSize: 24),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Center(
                child: EditProfileInputs(
                  screenContext: context,
                  selectedAvatar: selectedAvatar,
                ), // Form to update user info
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                // Change password text button
                onPressed: authService.isFirstTimeLogged()
                    ? null
                    : () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UpdatePasswordScreen(),
                        ));
                      },
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.lightPurple,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text(S.of(context).change_password,
                    style: GoogleFonts.play(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
