import 'package:flutter/material.dart';

const facebookPath = '../../assets/images/facebook-logo.png';
const googlePath = '../../assets/images/google-logo.png';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          facebookPath,
          Colors.white,
          () {
            // Lógica de autenticación con Facebook
          },
        ),
        const SizedBox(width: 20),
        _buildSocialButton(
          googlePath,
          Colors.white,
          () {
            // Lógica de autenticación con Google
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      String imagePath, Color bgColor, VoidCallback onPressed) {
    return SizedBox(
      //width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 5),
        ),
        child: Image.asset(imagePath, width: 50, height: 50),
      ),
    );
  }
}
