import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOutEvent());
              },
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return Text(
                  'Welcome, ${state.user.email ?? state.user.uid}',
                  style: const TextStyle(fontSize: 18),
                );
              } else {
                return const Text('Not logged in.');
              }
            },
          ),
        ),
        bottomNavigationBar: DefaultTabController(
          length: 5,
          child: TabBar(
            tabs: [
              Tab(text: 'to do list'),
              Tab(text: 'calendar'),
              Tab(text: '+'),
              Tab(text: 'budget planner'),
              Tab(text: 'vacation planner'),
            ],
          ),
        ),
      ),
    );
  }
}
