import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/generated/l10n.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final TextEditingController _messageController = TextEditingController();

  final String _email = 'wisdrive.jal@gmail.com';
  late String selectedSubject;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedSubject = S.current.report_a_bug;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> sendEmail() async {
      final String subject = Uri.encodeComponent(selectedSubject);
      final String body = Uri.encodeComponent(_messageController.text);

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: _email,
        query: 'subject=$subject&body=$body',
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No se pudo abrir el cliente de correo.')),
        );
      }
    }

    final List<String> subjects = [
      S.of(context).report_a_bug,
      S.of(context).send_complaint,
      S.of(context).request_assistance,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          S.of(context).contact,
          style: GoogleFonts.play(
            color: HelperFunctions.getTextThemeColor(),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: HelperFunctions.getIconThemeColor(),
          size: 40,
        ),
      ),
      backgroundColor: HelperFunctions.getBlackContainerThemeColor(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: S.of(context).subject,
                labelStyle: GoogleFonts.play(
                  color: HelperFunctions.getTextThemeColor(),
                  fontSize: 24,
                ),
              ),
              value: selectedSubject,
              items: subjects
                  .map((subject) => DropdownMenuItem(
                        value: subject,
                        child: Text(
                          subject,
                          style: GoogleFonts.play(
                              color: HelperFunctions.getTextThemeColor()),
                        ),
                      ))
                  .toList(),
              dropdownColor: HelperFunctions.getDropdownMenuThemeColor(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedSubject = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: S.of(context).message,
                labelStyle: GoogleFonts.play(
                  color: HelperFunctions.getTextThemeColor(),
                ),
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              style:
                  GoogleFonts.play(color: HelperFunctions.getTextThemeColor()),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  icon: Icon(
                    Icons.cancel,
                    color: HelperFunctions.getIconThemeColor(),
                  ),
                  label: Text(
                    S.of(context).cancel,
                    style: GoogleFonts.play(
                      color: HelperFunctions.getTextThemeColor(),
                      fontSize: 25,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HelperFunctions.getContainerThemeColor(),
                      iconAlignment: IconAlignment.end),
                  icon: Icon(
                    Icons.send,
                    color: HelperFunctions.getInvertedIconThemeColor(),
                  ),
                  label: Text(
                    S.of(context).send,
                    style: GoogleFonts.play(
                      color: HelperFunctions.getWhiteBgTextThemeColor(),
                      fontSize: 25,
                    ),
                  ),
                  onPressed: sendEmail,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
