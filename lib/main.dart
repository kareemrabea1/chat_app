import 'package:chat_app/screens/chat-page.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // بنعمل push عن طريق ال name
        "Register": (context) => Register(),
        "Login": (context) => Login(),
        ChatPage.id: (context) => ChatPage(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
