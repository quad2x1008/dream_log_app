import 'package:dream_log_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/dream_log_screen.dart';
import 'providers/dream_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DreamLogApp());
}

class DreamLogApp extends StatelessWidget {
  const DreamLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DreamProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => _checkUserLogin(),
        },
      ),
    );
  }

  // Function to check if the user is logged in
  Widget _checkUserLogin() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If the user is logged in, navigate to DreamLogScreen
      return DreamLogScreen();
    } else {
      // If the user is not logged in, navigate to AuthScreen
      return AuthScreen();
    }
  }
}
