// pdf_viewer_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/generated/l10n.dart'; // Asegúrate de que esta ruta es la correcta

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

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
      backgroundColor: HelperFunctions.getBlackContainerThemeColor(),
      appBar: AppBar(
        backgroundColor: HelperFunctions.getBlackContainerThemeColor(),
        iconTheme: const IconThemeData(color: Colors.white, size: 40),
        centerTitle: true,
        title: Text(
          S.of(context).traffic_regulations,
          style: GoogleFonts.poppins(
            color: HelperFunctions.getTextThemeColor(),
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: HelperFunctions.getIconThemeColor(),
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
        decoration: BoxDecoration(
          color: HelperFunctions.getContainerThemeColor(),
          borderRadius: const BorderRadius.only(
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
