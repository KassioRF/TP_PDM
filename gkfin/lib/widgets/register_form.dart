// Referência usada: https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/register_screen.dart
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterForm createState() => _RegisterForm();

}

class _RegisterForm extends State<RegisterForm> {
  //@TODO: slider form
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;


  @override
  Widget build(BuildContext context) {
    return Column(
      // Childrens
      children: <Widget>[
        // Screen Title                  
        Text(
          'Cadastro',
          style: Theme.of(context).textTheme.headline4,
        ),

        const SizedBox(height: 20,), // space between elements
        // Form inputs
        Form(
          key: _formKey,
          child: Column(                
            children: [
              // Name field
              TextFormField(
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Seu nome',
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.account_circle),
                ),
              ),
              const SizedBox(height: 10,), // space between elements                        
              
              // Email field
              TextFormField(
                //@TODO Validate email here!
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
          
                ),
              ),
              const SizedBox(height: 10,), // space between elements
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
                    icon: Icon( _isObscure ?  Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }, 
                  ),
                ),
              ),
              // CheckBox Remember me
                      
              const SizedBox(height: 10,), // space between elements
              //SignIn Buttom
              ElevatedButton(
                onPressed: () {
                  // @TODO add route here!!!
                  if (_formKey.currentState!.validate()) {}
                }, 
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                ),
                child: const Text(
                  'Cadastrar',
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
                  const Text('Já possui cadastro?',),
                  TextButton(
                    onPressed: () {
                      // @TODO Redirect to register view!
                      Navigator.of(context).pop();

                    },
                    child: const Text('Entrar',),
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
