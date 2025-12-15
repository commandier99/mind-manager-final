import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_manager/firebase_options.dart'; // Ensure this path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MindManagerApp()); // Renamed to a more fitting name
}

class MindManagerApp extends StatelessWidget {
  const MindManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind-Manager Final', // Updated title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Often a good default for new projects
      ),
      home: const PlaceholderScreen(), // A simple placeholder screen
    );
  }
}

// A simple screen to show that the app is running
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Mind-Manager!'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text(
          'Your Mind-Manager app is ready!\nStart building your features here.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
