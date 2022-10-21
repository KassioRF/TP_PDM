// Username Form Widget
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:gkfin/providers/userAuthentication.dart";
import "package:gkfin/utils/snack_bar_generic.dart";

import "package:gkfin/utils/credentials_validation_form.dart";

// Email Form Widget
class UpdateEmailForm extends StatefulWidget {
  const UpdateEmailForm({Key? key, required this.backToInitialPageView}) : super(key:key);  
  final VoidCallback backToInitialPageView;
  
  @override
  _UpdateEmailForm createState() => _UpdateEmailForm();
}
class _UpdateEmailForm extends State<UpdateEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  late bool _isEmailAlreadyUsed;
  late bool _passWordIsCorrect;
  // change visibility of form input
  late bool _isObscure;
  // manage state of progress Spinner
  late bool _showSpinner;
  late String newEmail;
  late String password;
  
  @override
  void initState() {
    super.initState();
    _showSpinner = false;
    _isObscure = false;
    _passWordIsCorrect = true;
    _isEmailAlreadyUsed = false;
  }

  void _submitForm() async {
    _formKey.currentState!.save();
    _formKeyPassword.currentState!.save();
    // dimiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() => _showSpinner = true );
    print("\n\t ------------- <><><<><><><><><><><>");
    print(newEmail);
    
    final String confirmAuth = await UserAuthentication.reautenticateUser(password);
    if (confirmAuth == 'success') {
      setState(() => _passWordIsCorrect = true );
      print(confirmAuth);
      print("\n\t ------------- <><><<><><><><><><><>");
      try {
        await UserAuthentication.updateEmail(newEmail).timeout(const Duration(seconds: 10))
        .then((opStatus) {
          setState(() {
            _showSpinner = false;
          });

          if (opStatus == 'success') {
            showSnackBar(context, "Email atualizado!");
            widget.backToInitialPageView();
          }else {
            print(opStatus);
            showSnackBar(context, "Ops! Algo deu errado... ");
          }
        }); 

      }on TimeoutException catch (e) {
        showSnackBar(context, "Sem resposta do servidor :/ . Tente novamente ");
      }

    }else {
      _passWordIsCorrect = false;
      _formKeyPassword.currentState!.validate();
      
    }
    

    setState(() {
      _showSpinner = false;
      _isEmailAlreadyUsed = false;
      _passWordIsCorrect = true;
    });

  }
  


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(                    
        padding: const EdgeInsets.fromLTRB(50, 80, 50, 10),
        alignment: Alignment.center,            
        child: Column(
          children: <Widget>[                      
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: FirebaseAuth.instance.currentUser?.email,
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) => CredentialsValidationForm.validateEmail(value?.replaceAll(" ", '') as String, _isEmailAlreadyUsed, setState),
                onSaved: (value) {
                  setState(() {
                    newEmail = value?.replaceAll(" ", '') as String;
                  });
                },
              ),
            ),
            const SizedBox(height: 20,), // space between elements
            Form(
              key: _formKeyPassword,
              child: 
                TextFormField(
                  //@TODO Validate password here!
                  maxLines: 1,                  
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "* requer a senha p/ atualizar",
                    suffixIcon: IconButton(
                      icon: Icon( _isObscure ?  Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }, 
                    ),
                  ),
                  //validator: (value) => value!.length < 6 ? "A senha deve ter no minimo 6 caracteres" : null,
                  validator: (value)  => CredentialsValidationForm.validatePassword(value as String, _passWordIsCorrect, setState),
                  onSaved: (value) {
                    setState(() {
                      password = value as String;
                      // _updatePassWord = true;
                    });
                  },
                ),
            ),            
            const SizedBox(height: 50,), // space between elements
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // PageView
                    widget.backToInitialPageView();
                  },
                  child: const Text('voltar',),
                ),
                _showSpinner ? const CircularProgressIndicator(color: Colors.black12) :
                ElevatedButton(
                    onPressed: () {
                      // @TODO add route here!!!
                      if (_formKey.currentState!.validate() && _formKeyPassword.currentState!.validate()) {
                        print("\n\t ------------- <><><<><><><><><><><>");
                        _submitForm();
                      }
                      //Navigator.of(context).pushNamed(AppRoutes.HOME);
                    }, 
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ), 
    );
  }
}
