// rodar: flutter run --no-sound-null-safety

// --no-sound-null-safety
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gkfin/services/userAuthentication.dart';
import 'package:google_fonts/google_fonts.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './utils/app_routes.dart';

import 'package:gkfin/providers/records.dart';

import 'package:gkfin/views/home.dart';
import 'package:gkfin/views/enter.dart';
import 'package:gkfin/views/add_register.dart';
import 'package:gkfin/views/about.dart';
import 'package:gkfin/views/profile.dart';

import 'package:gkfin/widgets/splash.dart';
import 'package:gkfin/widgets/login_form.dart';
import 'package:gkfin/widgets/register_form.dart';
import 'package:gkfin/widgets/recover_password.dart';


import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar firebase com a aplicação
  // fonte: https://stackoverflow.com/questions/70486658/no-firebase-app-has-been-created-call-firebase-initializeapp
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late StreamSubscription<User?> user;
  final Records recordsProvider = Records();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) { 
      if( user == null) {
        debugPrint('User is currently signed out!');
      }else {
        //debugPrint('User is signed in! ${user.displayName}');
        // Select user database collection [/users/userId/records]
        debugPrint('User is signed in! ${user.uid}');
        recordsProvider.setDbUser(user.uid);
        debugPrint('set DB');
        // Enable localPersistence and listeners for add and remove
        recordsProvider.enableLocalPersistence();
        debugPrint('set LocalPersist');
      }
    });
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        ChangeNotifierProvider(
          create: (_) => recordsProvider,
        )
      ],
      child: MaterialApp(        
        debugShowCheckedModeBanner: false, // Remove the debug banner
        title: 'GK Fin',
        theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.white,
          fontFamily: 'Open Sans',
          // Text Styling for Headlines, titles, bodies, and more...
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),

        ),
        // Alterar DatePicker pra Pt-br
        // ref: https://pt.stackoverflow.com/questions/399390/flutter-alterar-internacionaliza%C3%A7%C3%A3o-de-nomes-de-datas
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        // supportedLocales: [const Locale('pt', 'BR')],
        initialRoute: '/splash',
        // Referência: Aulas: APP41/42
        routes: {
          AppRoutes.SPLASH: (ctx) => const Splash(),
          AppRoutes.HOME: (ctx) => UserAuthentication.isLoggedIn() ? const HomeView(title: 'Home',) : const EnterView(title: 'Login', form:  LoginForm()),
          AppRoutes.LOGIN: (ctx) => const EnterView(title: 'Login', form:  LoginForm()),
          AppRoutes.REGISTER: (ctx) => const EnterView(title: 'Register', form: RegisterForm()),
          AppRoutes.RECOVERYPASS: (ctx) => const EnterView(title: 'Recover pass', form:RecoveryForm()),
          AppRoutes.PROFILE: (ctx) => const ProfileView(),
          AppRoutes.ADDREGISTER: (ctx) => const AddRegister(),
          AppRoutes.ABOUT: (ctx) => const AboutView(),
        },
      ),
    );
  }
}
