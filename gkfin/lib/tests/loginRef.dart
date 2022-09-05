//Reference source: https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/main.dart

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginView> createState() => _LoginView();

}

class _LoginView extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Defines background color as primary color of MyApp ThemeData
      //backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            // Childrens
            children: <Widget>[
              // Screen Title
              const Text(
                'Bem vindo!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 60,), // space between elements
              // Form inputs
              Form(
                key: _formKey,
                child: Column(                
                  children: [
                    // Email field
                    TextFormField(
                      //@TODO Validate email here!
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,), // space between elements
                    // Password Field
                    TextFormField(
                      //@TODO Validate password here!
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Senha',
                        //@TODO Make global style for duplicate properties!!!
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // CheckBox Remember me
                    CheckboxListTile(
                      title: const Text("Lembrar"),
                      contentPadding: EdgeInsets.zero,
                      value: rememberValue,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (newValue) {
                        setState(() {
                          rememberValue = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 20,), // space between elements
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
                        'Entrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,), // space between elements

                    // Create an account redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não está cadastrado?',),
                        TextButton(
                          onPressed: () {
                            // @TODO Redirect to register view!
                            //Navigator.pushReplacement(
                            //  context,
                            //  MaterialPageRoute(
                            //    builder: (context) => 
                            //    const RegisterPage(title: 'Register UI')
                            //  ),
                            //),
                          },
                          child: const Text('Cadastre-se',),
                        ),
                      ],
                    ),

                  ], // end Form fields
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
