import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/service/auth_gate.dart';
//import 'package:wisdrive/service/supabase_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
import 'package:get/get.dart';

class AuthService {
  final _supabase = Supabase.instance.client;
  //final supabaseService = Get.find<SupabaseService>();
  final box = GetStorage();

  bool isFirstTime() {
    return box.read("isFirstTime") ?? true; //Check if user is new;
  }

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  //Sign up with email and password
  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: 'com.wisdrive://login-callback',
    );

    return response;
  }

  //Google authentication
  Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.wisdrive://login-callback',
    );
  }

  //Facebook authentication
  Future<void> signInWithFacebook() async {
    await _supabase.auth.signInWithOAuth(OAuthProvider.facebook);
  }

  //Sign out
  Future<void> signOut(BuildContext parentContext) async {
    await _supabase.auth.signOut();
    if (parentContext.mounted) {
      //Go to AuthGate to check if session is still active
      Navigator.of(parentContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthGate()),
        (route) => false,
      );
    }
  }

  //Send reset password link
  Future<void> sendResetPassowrdLink(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  //Delete account
  Future<void> deleteUserDataAndSignOut(BuildContext context) async {
    final user = _supabase.auth.currentUser;
    final dateTime = DateTime.now().toIso8601String();
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (user != null) {
      try {
        // Set deleted_at date to current user
        await _supabase
            .from('users')
            .update({'deleted_at': dateTime})
            .eq('uuid', userId as Object)
            .maybeSingle();

        signOut(context);

        ResponseSnackbar.show(context, false, S.of(context).deleteted_account);
      } catch (e) {
        ResponseSnackbar.show(
            context, true, '${S.of(Get.context!).deleted_account_error}: $e');
        rethrow;
      }
    }
  }

  //Update user password
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception("No hay sesión activa.");
      }
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      ResponseSnackbar.show(Get.context!, true, e.toString());
    }
  }

  Future<bool> reauthenticate(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.session != null;
    } catch (_) {
      return false;
    }
  }

  //Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
