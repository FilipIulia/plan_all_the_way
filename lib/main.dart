import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_all_the_way/data/datasources/firebase_auth_datasource.dart';
import 'package:plan_all_the_way/data/repositories/auth_repository_impl.dart';
import 'package:plan_all_the_way/domain/use_cases/get_current_user.dart';
import 'package:plan_all_the_way/domain/use_cases/sign_in_with_email.dart';
import 'package:plan_all_the_way/domain/use_cases/sign_out.dart';
import 'package:plan_all_the_way/domain/use_cases/sign_up_with_email.dart';
import 'package:plan_all_the_way/firebase_options.dart';
import 'package:plan_all_the_way/presentation/blocs/auth_bloc.dart';
import 'package:plan_all_the_way/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepository = AuthRepositoryImpl(FirebaseAuthDatasource());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            signIn: SignInWithEmail(authRepository),
            signUp: SignUpWithEmail(authRepository),
            signOutUseCase: SignOut(authRepository),
            getUser: GetCurrentUser(authRepository),
          )..add(AuthCheckStatusEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Plan All The Way',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
