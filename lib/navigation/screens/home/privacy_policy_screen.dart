import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/generated/l10n.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).privacy_politics,
          style: GoogleFonts.play(fontWeight: FontWeight.w600, color: HelperFunctions.getTextThemeColor()),
        ),
        backgroundColor: HelperFunctions.getBlackContainerThemeColor(),
        centerTitle: true,
        iconTheme: IconThemeData(color: HelperFunctions.getIconThemeColor(), size: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _sectionTitle('Última actualización: mayo de 2025'),
            _sectionText(
              'En WisDrive, valoramos y protegemos tu privacidad. Esta Política de Privacidad explica qué información recopilamos, cómo la utilizamos y cuáles son tus derechos en relación con tus datos personales.',
            ),
            _sectionTitle('1. Información que recopilamos'),
            _sectionText(
              'Al usar la aplicación, podemos recopilar y almacenar la siguiente información:\n\n'
              '- Datos personales: Tu dirección de correo electrónico, nombre de usuario, género y avatar cuando te registras.\n'
              '- Progreso y uso de la app: Información sobre los quizzes completados y módulos visitados.\n'
              '- Mensajes de contacto: Si utilizas la función de contacto para soporte, se enviará tu mensaje a nuestro correo de soporte.',
            ),
            _sectionTitle('2. Uso de la información'),
            _sectionText(
              'La información recopilada se utiliza para:\n\n'
              '- Crear y personalizar tu perfil.\n'
              '- Mostrar tu progreso dentro de los módulos.\n'
              '- Mejorar la experiencia del usuario.\n'
              '- Proporcionarte asistencia técnica cuando lo solicites.',
            ),
            _sectionTitle('3. Almacenamiento y seguridad'),
            _sectionText(
              'Tu información es almacenada y gestionada de forma segura mediante Supabase, una plataforma confiable que cumple con estándares modernos de seguridad.',
            ),
            _sectionTitle('4. Compartición de datos'),
            _sectionText(
              'No compartimos tu información personal con terceros, excepto cuando sea requerido por ley o para proporcionar funcionalidades esenciales del servicio (por ejemplo, autenticación de usuarios).',
            ),
            _sectionTitle('5. Tus derechos'),
            _sectionText(
              'Puedes acceder, modificar o eliminar tu información personal desde la pantalla de perfil. Si necesitas ayuda adicional, puedes contactar a nuestro equipo de soporte en:\n\n📧 wisdrive.jal@gmail.com',
            ),
            _sectionTitle('6. Cambios a esta política'),
            _sectionText(
              'Podemos actualizar esta Política de Privacidad ocasionalmente. Te notificaremos cualquier cambio significativo dentro de la aplicación.',
            ),
            const SizedBox(height: 30),
            CupertinoButton.filled(
              child: Text(S.of(context).accept, style: GoogleFonts.play(fontWeight: FontWeight.bold),),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: AutoSizeText(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey[900],
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _sectionText(String text) {
    return AutoSizeText(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.blueGrey[800],
      ),
      maxLines: 15,
      minFontSize: 14,
    );
  }
}
