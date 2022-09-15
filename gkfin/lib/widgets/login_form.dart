
// Referência usada: https://github.com/hawier-dev/flutter-login-ui/blob/main/
//@TODO Make an correct widget build

import 'package:flutter/material.dart';
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
              ElevatedButton(
                onPressed: () {
                  // @TODO add route here!!!
                  // if (_formKey.currentState!.validate()) {}
                  Navigator.of(context).pushNamed(AppRoutes.HOME);
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

