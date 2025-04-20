import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
import 'package:get/get.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

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
    );

    if (response.user != null) {
      await createUserProfile();
    }
    return response;
  }

  Future<void> createUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    try {
      await Supabase.instance.client.from('users').insert({
        'id': user.id,
        'email': user.email,
        'username': '',
        'url_path': '',
        'strike': 0,
        'gender': null,
        'total_points': 0,
      });
      ResponseSnackbar.show(Get.context!, true, "usuario creado exitosamente");
    } catch (e) {
      ResponseSnackbar.show(
          Get.context!, true, "error al crear usuario en la bd");
    }
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
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  //Delete account
  Future<void> deleteUserDataAndSignOut(BuildContext context) async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      try {
        await _supabase.auth.admin.deleteUser(user.id); // Delete user from OAuth
        //await _supabase.from('users').delete().eq('id', user.id); // Delete user data from Supabase table users
        await _supabase.auth.signOut();// Sign Out from account

        ResponseSnackbar.show(context, false, S.of(context).delete_account);
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

  //Get current user
  User? get currentUsser => _supabase.auth.currentUser;

  Future<bool> checkIfProfileIsCompleted() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return false;

    final response = await Supabase.instance.client
        .from('users')
        .select('username')
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return false;

    final username = response['username'];
    return username != null && username.toString().trim().isNotEmpty;
  }
}
