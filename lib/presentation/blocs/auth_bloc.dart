import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_all_the_way/domain/use_cases/get_current_user.dart';
import 'package:plan_all_the_way/domain/use_cases/sign_in_with_email.dart';
import 'package:plan_all_the_way/domain/use_cases/sign_out.dart';
import 'package:plan_all_the_way/domain/use_cases/sign_up_with_email.dart';

import '../../../domain/entities/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signIn;
  final SignUpWithEmail signUp;
  final SignOut signOutUseCase;
  final GetCurrentUser getUser;

  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.signOutUseCase,
    required this.getUser,
  }) : super(AuthInitial()) {
    on<AuthSignInEvent>(_onSignIn);
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthSignOutEvent>(_onSignOut);
    on<AuthCheckStatusEvent>(_onCheckStatus);
  }

  Future<void> _onSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await signIn(event.email, event.password);
    user == null
        ? emit(AuthError("Login failed"))
        : emit(AuthAuthenticated(user));
  }

  Future<void> _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await signUp(event.email, event.password);
    user == null
        ? emit(AuthError("Signup failed"))
        : emit(AuthAuthenticated(user));
  }

  Future<void> _onSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await signOutUseCase();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckStatus(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final user = await getUser();
    user == null ? emit(AuthUnauthenticated()) : emit(AuthAuthenticated(user));
  }
}
