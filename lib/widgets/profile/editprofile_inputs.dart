import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
    final Color textColor = themeController.isDarkMode.value ? Colors.white : AppTheme.darkPurple;
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final List<String> genderOptions = [
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
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: S.of(context).edit_username,
              labelStyle: GoogleFonts.play(color: textLabelColor, fontSize: 24),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: textLabelColor),
              ),
            ),
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            minLines: 1,
            maxLines: 5,
            maxLength: 250,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: S.of(context).edit_description,
              labelStyle: GoogleFonts.play(color: textLabelColor, fontSize: 24),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: textLabelColor),
              ),
            ),
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedGender,
            items: genderOptions.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender,
                    style: GoogleFonts.play(color: textColor, fontSize: 16)),
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
            dropdownColor:
                themeController.isDarkMode.value 
                ? AppTheme.lightAccent
                : AppTheme.lightBackground, // Color del fondo del menú desplegable
            style: GoogleFonts.play(color: textColor),
            alignment: Alignment.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.isDarkMode.value
                        ? Colors.transparent
                        : AppTheme.lightPurple,
                    foregroundColor: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    S.of(context).cancel,
                    style: GoogleFonts.play(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Apply update changes to user into supabase
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
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
