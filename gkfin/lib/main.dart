import 'package:flutter/material.dart';

import './utils/app_routes.dart';

import 'package:gkfin/views/enter.dart';
// import 'package:gkfin/views/login.dart';
// import 'package:gkfin/views/register.dart';

import 'package:gkfin/widgets/login_form.dart';
import 'package:gkfin/widgets/register_form.dart';

void main() {
  runApp(const MyApp());
}

//ColorScheme defaultColorScheme = const ColorScheme(
//  primary: Color(0xffBB86FC),
//  secondary: Color(0xff03DAC6),
//  surface: Color(0xff181818),
//  background: Color(0xff121212),
//  error: Color(0xffCF6679),
//  onPrimary: Color(0xff000000),
//  onSecondary: Color(0xff000000),
//  onSurface: Color(0xffffffff),
//  onBackground: Color(0xffffffff),
//  onError: Color(0xff000000),
//  brightness: Brightness.dark,
//);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'GK Fin',
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.white,
        fontFamily: 'Ubuntu',

        // Tex Styling for Headlines, titles, bodies, and more...
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black54),
        ),

        // @TODO add app bar theme here...

      ),

      // @TODO check if user validation is cached
      // If true: Redirect to main view
      // Else: Redirect to LoginView
      //home: const LoginView(title: 'Login UI',),
      initialRoute: '/login',
      routes: {
        // AppRoutes.LOGIN: (ctx) => const LoginView(title: 'Login UI'),
        AppRoutes.LOGIN: (ctx) => EnterView(title: 'Login', form:  LoginForm()),
        AppRoutes.REGISTER: (ctx) => EnterView(title: 'Register', form: RegisterForm()),
      },
    
    );
  }
}