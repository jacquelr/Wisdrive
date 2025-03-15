// pdf_viewer_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:quiz_app/data/app_theme.dart'; // Asegúrate de que esta ruta es la correcta

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  // Llave para controlar el visor de PDF y acceder a funciones como abrir marcadores.
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  // URL del PDF a cargar.
  final String pdfUrl =
      'https://transparencia.info.jalisco.gob.mx/sites/default/files/Reglamento_%28Ley_de_los_Serv_de_Via_Tran_Transp_del_Edojal%29.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple, // Color de fondo principal de tu tema.
      appBar: AppBar(
        backgroundColor: purple,
        title: Text(
          'Lector de PDF',
          style: GoogleFonts.poppins(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: white,
            ),
            onPressed: () {
              // Abre la vista de marcadores del PDF.
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        // Contenedor con fondo blanco y bordes redondeados en la parte superior, siguiendo el estilo de tu app.
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(50, 30),
            topRight: Radius.elliptical(50, 30),
          ),
        ),
        child: SfPdfViewer.network(
          pdfUrl,
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}
