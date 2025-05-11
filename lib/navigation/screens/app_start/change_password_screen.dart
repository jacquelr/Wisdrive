import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/navigation/screens/home/home_screen.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/service/supabase_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
import 'package:wisdrive/widgets/profile/profile_appbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final authService = Get.find<AuthService>();
  final supabaseService = Get.find<SupabaseService>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _updatePassword() async {
    final newPassword = _passwordController.text.trim();

    // Validate if password is empty or format password
    if (newPassword.isEmpty) {
      ResponseSnackbar.show(context, true, S.of(context).fill_all_fields);
      return;
    } else if (HelperFunctions.isSecurePassword(newPassword)) {
      ResponseSnackbar.show(context, true, S.of(context).invalid_password_format);
      return;
    }

    setState(() => _isLoading = true);

    // Exception handler updating new password
    try {
      await authService.updatePassword(newPassword);
      ResponseSnackbar.show(context, false, S.of(context).updated_password);
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      ResponseSnackbar.show(context, true, S.of(context).updated_password_error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      backgroundColor: HelperFunctions.getBlackContainerThemeColor(),
      appBar: ProfileAppbar(appbarTitle: S.of(context).edit_profile),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Divider(color: Colors.grey),
              const SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: S.of(context).new_password,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _updatePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeController.isDarkMode.value
                            ? AppTheme.lightPurple
                            : AppTheme.darkPurple,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        S.of(context).apply,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
