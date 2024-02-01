import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/firebase_options.dart';
import 'loginstate/login.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final splashScreenProvider = FutureProvider.autoDispose<void>((ref) async {
  // Simulate initialization, replace with your actual initialization logic
  await Future.delayed(Duration(seconds: 2));
});

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          final initialization = ref.watch(splashScreenProvider);

          return initialization.when(
            data: (_) => login_screen(),
            loading: () => SplashScreen(),
            error: (_, __) => Scaffold(
              body: Center(
                child: Text('Error during app initialization'),
              ),
            ),
          );
        },
      ),
    );
  }
}
