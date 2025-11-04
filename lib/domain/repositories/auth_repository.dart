import 'package:plan_all_the_way/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn(String email, String password);
  Future<UserEntity?> signUp(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}
