import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';

class SupabaseService {
  final box = GetStorage();

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

    if (existing != null) return;

    try {
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
      box.write("isFirstTimeLogged", false);
    } catch (e) {
      ResponseSnackbar.show(Get.context!, true,
          "error al crear usuario en la bd: ${e.toString()}");
    }
  }

  Future<void> setUserAvatar(int avatarKey) async {
    await Supabase.instance.client // Save avatar in supabase
        .from('users')
        .update({'avatar': avatarKey}).eq(
            'id', Supabase.instance.client.auth.currentUser!.id);
  }

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

  Future<String> getAvatarImagePath(int? avatarIndex) async {
    if (avatarIndex == null || !RAvatars.avatarMap.containsKey(avatarIndex)) {
      return RImages.profilePickImage;
    }
    return RAvatars.avatarMap[avatarIndex]!;
  }
}
