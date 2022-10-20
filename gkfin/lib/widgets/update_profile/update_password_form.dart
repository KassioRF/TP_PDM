// Username Form Widget
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:gkfin/providers/userAuthentication.dart";
import "package:gkfin/utils/snack_bar_generic.dart";

import "package:gkfin/utils/credentials_validation_form.dart";

// Password Form Widget
class UpdatePasswordForm extends StatefulWidget {
  const UpdatePasswordForm({Key? key, required this.backToInitialPageView}) : super(key:key);  
  final VoidCallback backToInitialPageView;
  
  @override
  _UpdatePasswordForm createState() => _UpdatePasswordForm();
}
class _UpdatePasswordForm extends State<UpdatePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyCurrPassWord = GlobalKey<FormState>();
  // change visibility of form input
  late bool _isObscure;
  // manage state of progress Spinner
  late bool _showSpinner;
  late String currentPassWord;
  late String newPassWord;

  late bool _passWordIsCorrect; 
  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _showSpinner = false;
    _passWordIsCorrect = true;

  }

  void _submitForm() async {
    _formKey.currentState!.save();
    _formKeyCurrPassWord.currentState!.save();
    // dimiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() => _showSpinner = true );

   final String confirmAuth = await UserAuthentication.reautenticateUser(currentPassWord);
    if (confirmAuth == 'success') {
      setState(() => _passWordIsCorrect = true );
      print(confirmAuth);
      try {
        await UserAuthentication.updatePassword(newPassWord).timeout(const Duration(seconds: 10))
        .then((opStatus) {
          setState(() {
            _showSpinner = false;
          });

          print("\n\t ------------- $opStatus <><><<><><><><><><><>");
          if (opStatus == 'success') {
            showSnackBar(context, "Senha atualizada atualizada!");
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
      _formKeyCurrPassWord.currentState!.validate();
      
    }
    

    setState(() {
      _showSpinner = false;
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
              key: _formKeyCurrPassWord,
              child: 
                TextFormField(
                  //@TODO Validate password here!
                  maxLines: 1,                  
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Senha atual",
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
                      currentPassWord = value as String;
                      // _updatePassWord = true;
                    });
                  },
                ),
            ),
            const SizedBox(height: 20,), // space between elements
            Form(
              key: _formKey,
              child: 
                TextFormField(
                  //@TODO Validate password here!
                  maxLines: 1,                  
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Nova senha",
                    suffixIcon: IconButton(
                      icon: Icon( _isObscure ?  Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }, 
                    ),
                  ),
                  validator: (value) => value!.length < 6 ? "A senha deve ter no minimo 6 caracteres" : null,
                  onSaved: (value) {
                    setState(() {
                      newPassWord = value as String;
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
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.backToInitialPageView();
                  },
                  child: const Text('voltar',),
                ),
                _showSpinner ? const CircularProgressIndicator(color: Colors.black12) :          
                ElevatedButton(
                    onPressed: () {
                      // @TODO add route here!!!
                      print("<><><><> validate <><><><><>");
                      if (_formKey.currentState!.validate() && _formKeyCurrPassWord.currentState!.validate()) {
                        print("<><><><> SUBMIT <><><><><>");
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