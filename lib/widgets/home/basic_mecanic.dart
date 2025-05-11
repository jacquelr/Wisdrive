import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/widgets/home/video_mecanic.dart';

class BasicMecanic extends StatelessWidget {
  const BasicMecanic({super.key});

  // Display a map of videos in the db like modules
  Future<List<Map<String, dynamic>>> fetchVideos() async {
    final supabase = Supabase.instance.client;
    return await supabase.from('mechanical_resources').select();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final videos = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // columns
              crossAxisSpacing: 10, // y gap
              mainAxisSpacing: 10, //x gap
            ),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoMecanic(url: video['url_path'], name: video['name'],),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.getInvertedGradient(
                        themeController.isDarkMode.value),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Video',
                            style: GoogleFonts.play(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            video['name'] ?? S.of(context).unnamed,
                            style: GoogleFonts.play(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Icon(
                          Icons.ondemand_video_sharp,
                          size: 75,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
