
// Referência usada: https://github.com/hawier-dev/flutter-login-ui/blob/main/
//@TODO Make an correct widget build

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gkfin/services/userAuthentication.dart';
import 'package:provider/provider.dart';
import '../providers/records.dart';
import '../utils/app_routes.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _showSpinner = false;

  // form values
  late String emailAddress;
  late String password;

  bool _emailExists = true;
  bool _passWordIsCorrect = true;
  
  // check if email is in the correct format
  String? _validateEmail(String emailAddress) {
    if (!EmailValidator.validate(emailAddress)) {
      return 'Insira um email válido';
    }
    if (!_emailExists) {
      //_emailExists = false;
      return 'email incorreto';
    }
    
    return null;
  }

  String? _validatePassWord(String password) {
    if (!_passWordIsCorrect) {
      return 'Senha inválida';
    }
  }

  void _submitRegister() async {
    _formKey.currentState!.save();

    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());
    // show spinner when createUser its request
    setState(() {
      _showSpinner = true;
    });

    // call login method
    await UserAuthentication.logIn(emailAddress, password, Provider.of<Records>(context, listen: false).setDbUser)
    .then((opStatus) {
      if (opStatus == 'success') {
        Navigator.of(context).pushNamed(AppRoutes.HOME);
      } else if (opStatus == 'user-not-found') {
        setState(() {
          _emailExists = false;
          _formKey.currentState!.validate();
        });
      } else if (opStatus == 'wrong-password') {
        _passWordIsCorrect = false;
        _formKey.currentState!.validate();        
      }

      setState(() {
        // remove Spinner
        _showSpinner = false;
        // reset form validate controllers
        _emailExists = true;
        _passWordIsCorrect = true;
      });

    });

    


  }


  @override
  Widget build(BuildContext context) {
    return Column(
      // Childrens
      children: <Widget>[
        // Screen Title                  
        Text(
          'Bem vindo!',
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
                validator: (value) => _validateEmail(value!),
                onSaved: (value) => emailAddress = value as String,
              ),
              const SizedBox(height: 20,), // space between elements
              // Password Field
              TextFormField(
                //@TODO Validate password here!
                maxLines: 1,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Senha',
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon( _isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        // https://fluttercorner.com/how-to-show-hide-password-in-textformfield-in-flutter/
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                validator: (value) => _validatePassWord(value!),
                onSaved: (value) => password = value as String,
              ),
              // CheckBox Remember me

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //const Text('Não está cadastrado?',),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.RECOVERYPASS);
                    },
                    child: const Text('lembrar senha',),
                  ),
                  //const SizedBox(height: 20,), // space between elements
                ],
                
              ),

              
              const SizedBox(height: 20,), // space between elements
              //SignIn Buttom
              
              _showSpinner ? const CircularProgressIndicator(color: Colors.black12) :
              
              ElevatedButton(
                onPressed: () {
                  // @TODO add route here!!!
                  if (_formKey.currentState!.validate()) {
                    _submitRegister();
                  }
                  //Navigator.of(context).pushNamed(AppRoutes.HOME);
                }, 
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                ),
                child: const Text(
                  'Entrar',
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
                      Navigator.of(context).pushNamed(AppRoutes.REGISTER);
                    },
                    child: const Text('Cadastre-se',),
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

