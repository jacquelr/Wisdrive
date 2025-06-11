import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/service/auth_service.dart';

class SupabaseService {
  final authService = Get.find<AuthService>();
  final supabase = Supabase.instance.client;
  bool firstTimeLogged = true; // set true as default until it changes
  bool deletedUser = false;
  bool matchedEmail = false;

  // Get user from public.users table by UUID
  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('uuid', user.id)
          .maybeSingle();
      return response;
    } catch (e) {
      throw Exception("Error al obtener usuario: $e");
    }
  }

  // Get user from public.users table (this one calls previous one)
  Future<Map<String, dynamic>> getUserProfileOrThrow() async {
    final user = await getUserProfile();
    if (user == null) {
      throw Exception("No se encontró el perfil del usuario.");
    }
    return user;
  }

  // Get user from public.users table by Email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('email', email)
          .maybeSingle();

      return response;
    } catch (e) {
      Exception('Error fetching user: $e');
      return null;
    }
  }

  // Check if user has value in deleted_at from public.users table by Email
  Future<bool> isUserDeleted(email) async {
    try {
      final response = await supabase
          .from('users')
          .select('deleted_at')
          .eq('email', email)
          .maybeSingle();

      if (response == null) return false;

      // If deleted_at not null, user was deleted
      return response['deleted_at'] != null;
    } catch (e) {
      Exception(e);
    }
    return deletedUser;
  }

  // Check if parameter email matches one from public.users table
  Future<bool> isMatchedEmail(String email) async {
    try {
      final response = await supabase
          .from('users')
          .select('email')
          .eq('email', email)
          .maybeSingle();

      // if deleted_at has value, it means user "deleted his account"
      response != null ? matchedEmail = true : matchedEmail = false;
    } catch (e) {
      Exception(e);
    }
    return matchedEmail;
  }

  // Check if user already exists in public.users table
  Future<bool> isExistentUser() async {
    final userId = supabase.auth.currentUser!.id;

    // matching users table and oauth table uuids
    final response = await supabase
        .from('users')
        .select('uuid')
        .eq('uuid', userId)
        .maybeSingle();

    //if uuid match with record, then user exists
    // if (response != null) {
    //   firstTimeLogged = false;
    // }

    //return firstTimeLogged;
    return response != null;
  }

  // supabase -> INSERT INTO users (<user properties>)
  Future<void> createUserProfile(
      String username, int? avatar, String? gender) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final existing = await Supabase.instance.client
        .from('users')
        .select('id')
        .eq('uuid', user.id)
        .maybeSingle();

    try {
      if (existing == null) {
        await Supabase.instance.client.from('users').insert({
          'username': username,
          'email': user.email,
          'strike': 0,
          'gender': gender,
          'total_points': 0,
          'deleted_at': null,
          'avatar': avatar,
          'uuid': user.id
        });
      }
    } catch (e) {
      throw Exception("Error al crear usuario en la bd: $e");
    }
  }

   // supabase -> UPDATE FROM TABLE public.users WHERE uuid = auth.uuid
  Future<void> updateUserProfile(
      {String? username, int? avatar, String? gender}) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception("Usuario no autenticado.");

    final updates = <String, dynamic>{};

    if (username != null && username.isNotEmpty) {
      updates['username'] = username;
    }

    if (avatar != null) {
      updates['avatar'] = avatar;
    }

    if (gender != null && gender.isNotEmpty) {
      updates['gender'] = gender;
    }

    if (updates.isEmpty) return; // Nada que actualizar

    try {
      await supabase
          .from('users')
          .update(updates)
          .eq('uuid', userId)
          .select()
          .maybeSingle();
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

   // supabase -> DELETE FROM TABLE public.users WHERE email = parameter email
  Future<void> deleteUserProfile(String email) async {
    try {
      // Delete user data to start over again
      await supabase.from('users').delete().eq('email', email).maybeSingle();
    } catch (e) {
      throw Exception(e);
    }
  }

  // Set a integer value for user's avatar in avatar field
  Future<void> setUserAvatar(int avatarKey) async {
    await Supabase.instance.client // Save avatar in supabase
        .from('users')
        .update({'avatar': avatarKey}).eq(
            'uuid', Supabase.instance.client.auth.currentUser!.id);
  }

  // Gets value of integer in users avatar field
  Future<int?> getUserAvatar() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await Supabase.instance.client
        .from('users')
        .select('avatar')
        .eq('uuid', userId)
        .single();

    return response['avatar'];
  }

  // Get user id from public.users table
  Future<int?> getUserId() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await supabase
        .from('users')
        .select('id')
        .eq('uuid', userId)
        .single();

    if (response['id'] == null) {
    return null;
  }

  return response['id'] as int;
  }

  // Gets the route of AvatarImage depending on the sent avatar index
  Future<String> getAvatarImagePath(int? avatarIndex) async {
    if (avatarIndex == null || !RAvatars.avatarMap.containsKey(avatarIndex)) {
      return RImages.profilePickImage;
    }
    return RAvatars.avatarMap[avatarIndex]!;
  }
}
