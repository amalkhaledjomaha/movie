import '../repositories/auth_repository.dart';

class LoginWithGoogleUseCase {
  final AuthRepository repository;

  LoginWithGoogleUseCase({
    required this.repository,
  });

  Future<void> call() async {
    await repository.loginWithGoogle();
  }
}