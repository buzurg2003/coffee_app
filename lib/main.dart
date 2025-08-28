import 'package:coffee_app/features/auth/presentation/components/loading.dart';
import 'package:coffee_app/navigations/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/auth/presentation/cubits/auth_states.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/auth/data/firebase_auth_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'themes/dark_mode.dart';
import 'firebase_options.dart';

// ! Global list to hold added items
List<Map<String, String>> addedItems = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // ! auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ! provide the cubits to the app
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepo: firebaseAuthRepo,
          )..checkAuth(),
        ),
      ],
      // ! app
      child: MaterialApp(
        theme: darkMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            print(state);

            // ! unauthenticated -> auth page (login/register)
            if (state is Unauthenticated) {
              return const AuthPage();
            }
            // ! authenticated -> navigation bar
            if (state is Authenticated) {
              return const NavigationBarWidget();
            }
            // ! loading...
            return LoadingScreen();
          },
          // ! listen for state changes
          listener: (context, state) {
            if (state is AuthError) {
              // ! show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// https://console.firebase.google.com/u/0/project/coffee-app-434da/firestore/databases/-default-/data/~2Fadded_items
