import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gkfin/providers/userAuthentication.dart';
import '../utils/app_routes.dart';

import 'package:gkfin/utils/snack_bar_generic.dart';

class RecoveryForm extends StatefulWidget {
  const RecoveryForm({super.key});

  @override
  _RecoveryForm createState() => _RecoveryForm();
}

class _RecoveryForm extends State<RecoveryForm> {
  final _formKey = GlobalKey<FormState> ();

  // show spinner controller
  late bool _showSpinner;
  // for controll if email exists
  late bool _emailExists;
  late String email;
  @override
  void initState() {    
    super.initState();
    _showSpinner = false;
    _emailExists = true;

  }

  // check if email is in the correct format
  String? _validateEmail(String emailAddress) {
    // if (!EmailValidator.validate(emailAddress)) {
    //   return 'Insira um email válido';
    // }
    if (!_emailExists) {
      //_emailExists = false;
      return 'email incorreto';
    }
    
    return null;
  }


  void _submitRregister() async {
    _formKey.currentState!.save();
    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());
    // show spinner when createUser its request
    setState(() {
      _showSpinner = true;
    });

    // call email method
    try {
      await UserAuthentication.recoveryPassword(email)
      .timeout(const Duration(seconds: 10))
      .then((opStatus) {
        print("<><><> $opStatus <><><>");
        if (opStatus == 'success') {
          showSnackBar(context, "Um email de recuperação foi enviado para você ^^");

        } else if (opStatus == 'invalid-email') {
          print(email);
          setState(() {
            _emailExists = false;
            _formKey.currentState!.validate();
          });
        }
        else {
          showSnackBar(context, "Ops.. algo deu errado :(");
        }
      });
    } on TimeoutException catch (e) {
      showSnackBar(context, "Sem resposta do servido... Tente novamente tarde");
    }

    setState(() {
      _showSpinner = false;
      _emailExists = true;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Childrens
      children: <Widget>[
        // Screen Title                  
        Text(
          'Lembrar senha',
          style: Theme.of(context).textTheme.headline4,
        ),

        const SizedBox(height: 45,), // space between elements
        // Form inputs
        Form(
          key: _formKey,
          child: Column(                
            children: [                        
              // Email field
              TextFormField(
                //@TODO Validate email here!
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.email)
                ),
                validator: (value) => _validateEmail(value?.replaceAll(" ", '') as String),
                onSaved: (value) => email = value?.replaceAll(" ", '') as String,
              ),
              const SizedBox(height: 20,), // space between elements
              // Password Field
              
              const SizedBox(height: 20,), // space between elements
              //SignIn Buttom
              _showSpinner ? const CircularProgressIndicator(color: Colors.black12) :
              ElevatedButton(
                onPressed: () {
                  print("<><><> validate <><><>");
                  if (_formKey.currentState!.validate()) {
                    _submitRregister();
                  }
                  // @TODO add route here!!!
                  // if (_formKey.currentState!.validate()) {}
                  // Navigator.of(context).pushNamed(AppRoutes.HOME);
                }, 
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                ),
                child: const Text(
                 'Enviar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40,), // space between elements

              // Create an account redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não está cadastrado?',),
                  TextButton(
                    onPressed: () {
                      // @TODO Redirect to register view!
                      Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                    },
                    child: const Text('Voltar',),
                  ),
                  const SizedBox(height: 60,), // space between elements
                ],
                
              ),

            ], // end Form fields
          ),
        ),
      ],
    );
  }
}