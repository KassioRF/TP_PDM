
//@TODO Make an correct widget build

import 'package:flutter/material.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key:key);
  

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          // Childrens
          children: <Widget>[
            // Screen Title                  
            Text(
              'Bem vindo!',
              style: Theme.of(context).textTheme.headline1,
            ),

            const SizedBox(height: 45,), // space between elements
            // Form inputs
            Form(
              //key: _formKey,
              child: Column(                
                children: [
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
  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //const Text('Não está cadastrado?',),
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
                      //if (_formKey.currentState!.validate()) {}
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
                      const SizedBox(height: 60,), // space between elements
                    ],
                    
                  ),

                ], // end Form fields
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key?key}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          // Childrens
          children: <Widget>[
            // Screen Title                  
            Text(
              'Bem vindo!',
              style: Theme.of(context).textTheme.headline1,
            ),

            const SizedBox(height: 45,), // space between elements
            // Form inputs
            Form(
              //key: _formKey,
              child: Column(                
                children: [
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
  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //const Text('Não está cadastrado?',),
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
                      //if (_formKey.currentState!.validate()) {}
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
                      const SizedBox(height: 60,), // space between elements
                    ],
                    
                  ),

                ], // end Form fields
              ),
            ),
          ],
        ),
      ),
    );
  }  


}
