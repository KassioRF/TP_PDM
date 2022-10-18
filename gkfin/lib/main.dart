// rodar: flutter run --no-sound-null-safety

// --no-sound-null-safety
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gkfin/services/userAuthentication.dart';
import 'package:google_fonts/google_fonts.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Records(),          
        )
      ],
      child: MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'GK Fin',
        theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.white,
          fontFamily: 'Open Sans',
          // fontFamily: GoogleFon,

          // Tex Styling for Headlines, titles, bodies, and more...
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),

        ),
        // Alterar DatePicker pra Pt-br
        // ref: https://pt.stackoverflow.com/questions/399390/flutter-alterar-internacionaliza%C3%A7%C3%A3o-de-nomes-de-datas
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        // supportedLocales: [const Locale('pt', 'BR')],
        // @TODO check if user validation is cached
        // If true: Redirect to main view
        // Else: Redirect to LoginView
        //home: const LoginView(title: 'Login UI',),
        initialRoute: '/splash',
        // Ref: Aulas: APP41/42
        routes: {
          // AppRoutes.HOME: (ctx) => _isLogedIn ? HomeView(title: 'Home',) : EnterView(title: 'Login', form:  LoginForm()),
          AppRoutes.SPLASH: (ctx) => const Splash(),
          AppRoutes.HOME: (ctx) => UserAuthentication.isLoggedIn() ? const HomeView(title: 'Home',) : const EnterView(title: 'Login', form:  LoginForm()),
          // AppRoutes.HOME: (ctx) => const HomeView(title: 'Home',),
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
