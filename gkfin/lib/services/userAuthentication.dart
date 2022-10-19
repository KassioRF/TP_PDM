

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/semantics.dart';
import 'package:gkfin/providers/records.dart';
import '../models/user.dart';


class UserAuthentication {


  static Future<bool> verifyEmail(String emailAddress) async {
    // se o email já existir nos cadastros retorna false
    // se o email não existe nos cadastros retorna true
    var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);
    if (methods.contains('password')) {
      return false;
    }else {
      return true;
    }
  }

  static Future<String> createUser (String emailAddress, String password, setDbUser) async {
    String opStatus = '';
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress, password: password,
      );

      //setDbUser(credential.user?.uid);      
      //Records.enableLocalPersistence();
      opStatus = 'success';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        opStatus = 'email already exists';
      }
    } catch (e) {
      print(e);
    } finally {
      return opStatus;
    }
    //return opStatus;
  }

  static Future<String> logIn(String emailAddress, String password, setDbUser) async{
    String opStatus = '';
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress, password: password
      );
    
      //Records.enableLocalPersistence();
      //setDbUser(credential.user?.uid);
      opStatus = 'success';
      
      
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        opStatus = e.code;
      }else if (e.code == 'wrong-password') {
        opStatus = e.code;

      }
    } finally {
        return opStatus;
    }    
  }

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null)  {
      return true;
    }else {
      return false;
    }
  }

  // static void enableLocalPersistence() {
  //   FirebaseDatabase.instance.setPersistenceEnabled(true);
  //   FirebaseDatabase.instance.ref().keepSynced(true);
  // }
}
