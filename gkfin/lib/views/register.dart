// Reference source: https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/main.dart

// Reference source: https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/main.dart

import 'package:flutter/material.dart';
import 'package:gkfin/assets/bg_clipper.dart';
import 'package:gkfin/views/login.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key, required this.title}) : super(key: key);
  
  final String title;


  @override
  State<RegisterView> createState() => _RegisterView();

}

class _RegisterView extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  @override
  Widget build(BuildContext context) {
    //@TODO break elements in small widgets
    return Scaffold(
      // Defines background color as primary color of MyApp ThemeData
      //backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).backgroundColor,
      //prevent resize when keyboard shows up
      resizeToAvoidBottomInset: false,
      body: Stack(
        //@TODO add icon logo ?
        //@TODO change Title
        children: <Widget>[

          ClipPath(
            clipper: WaveClipper(waveDeep: 5, waveDeep2: 45),
            child: Container(
              padding: const EdgeInsets.only(bottom: 450),
              color: Colors.green.withOpacity(.8),
              height: 140,
              alignment: Alignment.center,
              
            ),
          ),
          ClipPath(
              clipper: WaveClipper(waveDeep2: 50),
              child: Container(
                padding: const EdgeInsets.only(bottom: 50),
                color: Colors.green.withOpacity(.3),
                height: 130,
                alignment: Alignment.center,
                
              ),
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                // Childrens
                children: <Widget>[
                  // Screen Title                  
                  Text(
                    'Cadastro',
                    style: Theme.of(context).textTheme.headline1,
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
                          decoration: InputDecoration(
                            hintText: 'Seu nome',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                    
                          ),
                        ),
                        const SizedBox(height: 20,), // space between elements                        
                        
                        // Email field
                        TextFormField(
                          //@TODO Validate email here!
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            fillColor: Colors.white,
                            filled: true,
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
                            fillColor: Colors.white,
                            filled: true,
                            //@TODO Make global style for duplicate properties!!!
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        // CheckBox Remember me
                                
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => 
                                    const LoginView(title: 'Login UI')
                                  ),
                                );
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
