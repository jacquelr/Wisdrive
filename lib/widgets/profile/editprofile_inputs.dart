import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/service/supabase_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';

class EdditProfileInputs extends StatefulWidget {
  const EdditProfileInputs(
      {super.key, required this.screnContext, required this.selectedAvatar});

  final int? selectedAvatar;
  final BuildContext screnContext;

  @override
  State<EdditProfileInputs> createState() => _EdditProfileInputsState();
}

class _EdditProfileInputsState extends State<EdditProfileInputs> {
  final authService = AuthService();
  final supabaseService = SupabaseService();
  final usernameController = TextEditingController();
  String? selectedGender;

  String? mapGenderToEnum(String? gender, BuildContext context) {
    if (gender == S.of(context).male) return 'male';
    if (gender == S.of(context).female) return 'female';
    if (gender == S.of(context).other) return 'other';
    return null;
  }

  String? mapGenderToEnumInverse(String gender) {
    if (gender == 'male') return S.of(context).male;
    if (gender == 'female') return S.of(context).female;
    if (gender == 'other') return S.of(context).other;
    return null;
  }

  Future<void> loadCurrentUserData() async {
  final user = await supabaseService.getUserProfile();

  if (user != null) {
    setState(() {
      usernameController.text = user['username'] ?? '';
      selectedGender = user['gender'] != null
          ? mapGenderToEnumInverse(user['gender'])
          : null;
    });
  } else {
    print('No se encontró el perfil del usuario.');
  }
}


  @override
  void initState() {
    super.initState();
    loadCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final Color textLabelColor =
        themeController.isDarkMode.value ? Colors.white70 : AppTheme.darkPurple;
    final List<String> genderOptions = [
      // List of options for dropdown gender list
      S.of(context).male,
      S.of(context).female,
      S.of(context).other
    ];

    void firstTimeLogged() {
      final username = usernameController.text;
      final mappedGender = mapGenderToEnum(selectedGender, context);

      if (widget.selectedAvatar != null &&
          username.isNotEmpty &&
          mappedGender != null) {
        try {
          supabaseService.createUserProfile(username, widget.selectedAvatar, mappedGender);
          //final box = GetStorage();
          //box.write("isFirstTimeLogged", false);
          Navigator.pop(context); // Return to HomeScreen
        } catch (e) {
          ResponseSnackbar.show(context, true, e.toString());
        }
      } else {
        ResponseSnackbar.show(context, true, S.of(context).fill_all_fields);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextField(
            // Text field to input updated username
            controller: usernameController,
            decoration: InputDecoration(
              labelText: S.of(context).edit_username,
              labelStyle: GoogleFonts.play(color: textLabelColor, fontSize: 24),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: textLabelColor),
              ),
            ),
            style: TextStyle(color: HelperFunctions.getTextThemeColor()),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            // Dropdown gender menu
            value: selectedGender,
            items: genderOptions.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender,
                    style: GoogleFonts.play(
                        color: HelperFunctions.getTextThemeColor(),
                        fontSize: 24)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                setState(() {
                  selectedGender = newValue;
                });
              });
            },
            decoration: InputDecoration(
              labelText: S.of(context).edit_gender,
              labelStyle: GoogleFonts.play(color: textLabelColor, fontSize: 24),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: textLabelColor),
              ),
            ),
            dropdownColor: HelperFunctions.getDropdownMenuThemeColor(),
            style: GoogleFonts.play(color: HelperFunctions.getTextThemeColor()),
            alignment: Alignment.center,
          ),
          const SizedBox(height: 20),
          Row(
            // Cancel or Apply buttons container
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                // Cancel button
                onPressed: authService.isFirstTimeLogged()
                    ? () => HelperFunctions.showAlert(
                        S.of(context).user_profile,
                        S.of(context).fill_all_fields)
                    : () {
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.isDarkMode.value
                        ? Colors.transparent
                        : AppTheme.lightPurple,
                    foregroundColor: white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    S.of(context).cancel,
                    style: GoogleFonts.play(color: white, fontSize: 30),
                  ),
                ),
              ),
              ElevatedButton(
                // Apply button
                onPressed: authService.isFirstTimeLogged()
                    ? () => firstTimeLogged()
                    : () async {
                        final username = usernameController.text.trim();
                        final genderEnum = mapGenderToEnum(selectedGender, context);
                        final avatar = widget.selectedAvatar;

                        try {
                          await supabaseService.updateUserProfile(
                            username: username.isNotEmpty ? username : null,
                            avatar: avatar,
                            gender: genderEnum,
                          );
                          ResponseSnackbar.show(context, false,"Perfil actualizado correctamente");
                          Navigator.pop(widget.screnContext); // Go back to profile screen
                        } catch (e) {
                          ResponseSnackbar.show(context, true, e.toString());
                        }
                      },
                style: ElevatedButton.styleFrom(backgroundColor: white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    S.of(context).apply,
                    style: GoogleFonts.play(
                        color: AppTheme.darkPurple, fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
