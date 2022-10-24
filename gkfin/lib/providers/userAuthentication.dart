


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/semantics.dart';
import 'package:gkfin/providers/records.dart';
import '../models/user.dart';


class UserAuthentication {


  static Future<bool> verifyEmail(String emailAddress) async {
    // Verifica a disponibilidade do email
    // se o email já existir nos cadastros retorna false
    // se o email não existe nos cadastros retorna true
    var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);
    if (methods.contains('password')) {
      return false;
    }else {
      return true;
    }
  }

  static Future<String> createUser (String emailAddress, String password, String userName) async {
    String opStatus = '';
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress, password: password,
      ).then((cred) => cred.user?.updateDisplayName(userName));


      opStatus = 'success';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        opStatus = e.code;

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        opStatus = 'email already exists';
      }
      opStatus = e.code;
    } catch (e) {
      print('<><><><> auth <><><><>');
      print(e);
      opStatus = "Ops... algo deu errado :/. Tente novamente";
    }

    return opStatus;
  }


  // must have internet connection
  static Future<String> updateName(String name) async {
    late String opStatus;    
    try {

      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      opStatus = 'success';

    } on FirebaseAuthException catch (e) {
      opStatus = e.code;
    }

    return opStatus;
  
  }
  // must have internet connection
  static Future<String> updateEmail(String emailAddress) async {
    late String opStatus;    
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(emailAddress);
      opStatus = 'success';

    } on FirebaseAuthException catch (e) {
      opStatus = e.code;
    }

    return opStatus;
  
  }
  // must have internet connection
  static Future<String> updatePassword(String password) async {
    late String opStatus;
    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(password);
      opStatus = 'success';
    }on FirebaseAuthException catch (e) {
      opStatus = e.code;
    }

    return opStatus;
  }

  static Future<String> logIn(String emailAddress, String password, setDbUser) async{
    String opStatus = '';
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress, password: password
      );  
      opStatus = 'success';
      
      
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        opStatus = e.code;
      }else if (e.code == 'wrong-password') {
        opStatus = e.code;

      } else {
        opStatus = e.code;
      }
    } finally {
        return opStatus;
    }    
  }

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }


  static Future<String> recoveryPassword(String email) async {
    late String opStatus;

    try {
      print("<><><> await send recovery <><><>");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      opStatus = 'success';
    } on FirebaseAuthException catch(e) {
      print("<> await send recovery return ${e.code} <>");
      opStatus = e.code;
    }

    return opStatus;
  }

  static Future<String> reautenticateUser(String password) async {
    late String opStatus;
    try {
      String email = await FirebaseAuth.instance.currentUser?.email as String;
      final credential = EmailAuthProvider.credential(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential);
      
      opStatus = 'success';
    }on FirebaseAuthException catch(e) {
      opStatus = e.code;
    }
    return opStatus;
  }

  static bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null)  {
      return true;
    }else {
      return false;
    }
  }



}
// kassiorf1@gmail.com