import 'package:flutter/material.dart';
import 'package:flutter_application/screens/networkingP2.dart';
import 'package:flutter_application/screens/stats.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://dbhwiwngltxrbuasrilt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRiaHdpd25nbHR4cmJ1YXNyaWx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3NTc2MzgsImV4cCI6MjA2MTMzMzYzOH0.OSwLzj3L2u4r9_WiFDFimLUdNw3RImF0jlkMCvgAUPw',
  );

  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkSupabaseSession();
    super.initState();
  }

  Future<void> checkSupabaseSession() async {
    await Future.delayed(Duration(seconds: 2));
    final session = await Supabase.instance.client.auth.currentSession;
    if (session != null) {
      // User is logged in, navigate to the main screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // builder: (context) => SubjectListScreen(),
          builder: (context) => StatsWidget(),
        ),
      );
    } else {
      // User is not logged in, navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Welcome to the app!")),
    );
  }
}
