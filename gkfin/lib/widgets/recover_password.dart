import 'package:flutter/material.dart';
import '../utils/app_routes.dart';


class RecoveryForm extends StatefulWidget {
  const RecoveryForm({super.key});

  @override
  _RecoveryForm createState() => _RecoveryForm();
}

class _RecoveryForm extends State<RecoveryForm> {
  final _formKey = GlobalKey<FormState> ();

  @override
  Widget build(BuildContext context) {
    return Column(
      // Childrens
      children: <Widget>[
        // Screen Title                  
        const Text(
          'Lembrar senha',
          style: TextStyle(fontSize: 18.0),
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
              
              const SizedBox(height: 20,), // space between elements
              //SignIn Buttom
              ElevatedButton(
                onPressed: () {
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