import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity?> signIn(String email, String password) =>
      datasource.signIn(email, password);

  @override
  Future<UserEntity?> signUp(String email, String password) =>
      datasource.signUp(email, password);

  @override
  Future<void> signOut() => datasource.signOut();

  @override
  Future<UserEntity?> getCurrentUser() async => datasource.getCurrentUser();
}
