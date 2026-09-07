import '../../data/datasources/google_auth_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final GoogleAuthDataSource googleAuthDataSource;

  AuthRepositoryImpl({
    required this.googleAuthDataSource,
  });


  @override
  Future<void> loginWithGoogle() async {
    await googleAuthDataSource.signInWithGoogle();
  }

}