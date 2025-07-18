import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/navigation/screens/profile/edit_profile_screen.dart';
import 'package:wisdrive/widgets/profile/sidebar_profile.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ThemeController themeController = Get.find();
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = true;

  // Initializing user's profile information
  String username = '';
  String email = '';
  int? avatarIndex;
  List<dynamic> achievements = [];

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  // Load and fetch user's profile info into the screen
  Future<void> fetchUserProfile() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response = await supabase
        .from('users')
        .select('username, email, avatar, achievements')
        .eq('uuid', userId)
        .single();

    setState(() {
      username = response['username'] ?? 'Invitado';
      email = response['email'];
      avatarIndex = response['avatar'];
      achievements = response['achievements'] ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          S.of(context).profile,
          style: GoogleFonts.play(
              color: themeController.isDarkMode.value
                  ? AppTheme.darkPurple
                  : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: themeController.isDarkMode.value
            ? const IconThemeData(color: AppTheme.darkPurple, size: 40)
            : const IconThemeData(color: AppTheme.lightBackground, size: 40),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp,
              color: themeController.isDarkMode.value
                  ? AppTheme.darkPurple
                  : AppTheme.lightBackground),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: const SidebarProfile(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              height: double.infinity,
              decoration: themeController.isDarkMode.value
                  ? const BoxDecoration(gradient: AppTheme.blackBgGradient)
                  : const BoxDecoration(color: AppTheme.lightBackground),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 325,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: themeController.isDarkMode.value
                                ? AppTheme.lightBackground
                                : AppTheme.lightPurple,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(200),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 100),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: themeController.isDarkMode.value
                                    ? Colors.black.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 15,
                                offset: const Offset(0, 52),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage(
                              RAvatars.avatarMap[avatarIndex] ??
                                  RImages.profilePickImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      username,
                      style: GoogleFonts.play(
                          color: themeController.isDarkMode.value
                              ? Colors.white
                              : AppTheme.lightSecondary,
                          fontSize: 36),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      email,
                      style: GoogleFonts.play(
                        color: themeController.isDarkMode.value
                            ? Colors.white
                            : AppTheme.lightSecondary,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeController.isDarkMode.value
                              ? Colors.white
                              : AppTheme.lightPurple,
                          foregroundColor:
                              HelperFunctions.getWhiteBgTextThemeColor(),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          S.of(context).edit_profile,
                          style: GoogleFonts.play(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Divider(
                        color: Colors.grey,
                        thickness: 3,
                      ),
                    ),

                    // Achievements section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: themeController.isDarkMode.value
                                ? Colors.grey
                                : Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).achievements,
                                style: GoogleFonts.play(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: themeController.isDarkMode.value
                                      ? Colors.white
                                      : AppTheme.lightSecondary,
                                ),
                              ),
                              const SizedBox(height: 10),
                              achievements.isEmpty
                                  ? Text(
                                      S.of(context).no_achievements_yet,
                                      style: GoogleFonts.play(
                                        fontSize: 16,
                                        color: themeController.isDarkMode.value
                                            ? Colors.white70
                                            : Colors.black54,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: achievements.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color:
                                              themeController.isDarkMode.value
                                                  ? AppTheme.lightBackground
                                                  : AppTheme.lightPurple
                                                      .withOpacity(0.3),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.emoji_events,
                                                color: Colors.amber),
                                            title: Text(
                                              achievements[index] ?? '',
                                              style: GoogleFonts.play(
                                                fontSize: 18,
                                                color: themeController
                                                        .isDarkMode.value
                                                    ? Colors.white
                                                    : AppTheme.lightSecondary,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
