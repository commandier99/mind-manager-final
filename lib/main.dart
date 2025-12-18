import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:mind_manager/firebase_options.dart';
import 'package:mind_manager/shared/providers/navigation_provider.dart';
import 'package:mind_manager/shared/widgets/splash_screen.dart';
import 'package:mind_manager/features/authentication/presentation/pages/authentication_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider<NavigationProvider>(
      create: (_) => NavigationProvider(),
      child: const MindManagerApp(),
    ),
  );
}

class MindManagerApp extends StatelessWidget {
  const MindManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind-Manager Final',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          return SplashScreen(
            duration: const Duration(seconds: 2),
            onFinish: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
