import 'package:flutter/material.dart';
import 'package:login_signup/login.dart';
import 'package:login_signup/mongodb.dart';
import 'package:login_signup/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(title: 'Flutter Demo Home Page'),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) => SignupPage()
        });
  }
}
