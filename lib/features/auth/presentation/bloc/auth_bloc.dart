import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_with_google_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  AuthBloc({
    required this.loginWithGoogleUseCase,
  }) : super(AuthInitial()) {
    on<GoogleLoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await loginWithGoogleUseCase.call();

        emit(AuthSuccess());
      } catch (e) {
        emit(
          AuthFailure(e.toString()),
        );
      }
    });
  }
}