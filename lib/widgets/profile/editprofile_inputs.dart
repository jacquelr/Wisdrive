import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';

class EdditProfileInputs extends StatefulWidget {
  const EdditProfileInputs({super.key});

  @override
  State<EdditProfileInputs> createState() => _EdditProfileInputsState();
}

class _EdditProfileInputsState extends State<EdditProfileInputs> {

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final Color textLabelColor = themeController.isDarkMode.value ? Colors.white70 : AppTheme.darkPurple;
    final TextEditingController usernameController = TextEditingController();
    final List<String> genderOptions = [ // List of options for dropdown gender list
      S.of(context).male,
      S.of(context).female,
      S.of(context).other
    ];
    String? selectedGender;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextField( // Text field to input updated username
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
          DropdownButtonFormField<String>( // Dropdown gender menu
            value: selectedGender,
            items: genderOptions.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender,
                    style: GoogleFonts.play(color: HelperFunctions.getTextThemeColor(), fontSize: 16)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
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
          Row( // Cancel or Apply buttons container
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton( // Cancel button
                onPressed: () => Navigator.pop(context),
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
              ElevatedButton( // Apply button
                onPressed: () {
                  // Apply update changes to user into supabase
                },
                style: ElevatedButton.styleFrom(backgroundColor: white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    S.of(context).apply,
                    style: GoogleFonts.play(color: AppTheme.darkPurple, fontSize: 30),
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
