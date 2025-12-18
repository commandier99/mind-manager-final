    import 'package:flutter/material.dart';
    import 'package:firebase_core/firebase_core.dart';
    import 'package:mind_manager/firebase_options.dart';
    import 'package:mind_manager/features/home/presentation/pages/home_screen.dart'; // Import HomeScreen
    

    void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(const MindManagerApp());
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
          home: const HomeScreen(), // Now points to HomeScreen in features/home
        );
      }
    }