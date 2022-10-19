// Referência usada: https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/register_screen.dart
import 'package:flutter/material.dart';


import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../providers/records.dart';
import '../services/userAuthentication.dart';
import '../utils/app_routes.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterForm createState() => _RegisterForm();

}

class _RegisterForm extends State<RegisterForm> {
  //@TODO: slider form
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};



  bool _isObscure = true;
  // manage state of modal progress HUD widget
  bool _showSpinner = false;
  
  //  controll validEmail
  bool _isEmailAlreadyUsed = false;
  

  @override
  void initState() {
    super.initState();
  }

  // check if email is in the correct format
  String? _validateEmail(String emailAddress) {
    if (!EmailValidator.validate(emailAddress)) {
      return 'Insira um email válido';
    }
    if (_isEmailAlreadyUsed) {
      _isEmailAlreadyUsed = false;
      return 'email já cadastrado';
    }
    return null;
  }


  // Submit register form
  void _submitRegister() async {
    // call register from user Authentication
    _formKey.currentState!.save();

    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());
    //print(_formData);
    String userName = _formData['userName'] as String;
    String emailAddress = _formData['email'] as String;
    String password = _formData['password'] as String;
    
    // show spinner when createUser its request
    setState(() {
      _showSpinner = true;
    });

    // verify if email already exists
    await UserAuthentication.verifyEmail(emailAddress)
    .then((checkEmail) async {
      setState(() {
        if(checkEmail) {
          _isEmailAlreadyUsed = false;
          //String opStatus = await UserAuthentication.createUser(emailAddress, password);
          //print(opStatus);
          
        }else {
          _isEmailAlreadyUsed = true;
          _formKey.currentState!.validate();
          //_isEmailAlreadyUsed = false;
        }

      });
      
      if (checkEmail) {
        // if email its valid then create User and redirect to HOME
        await UserAuthentication.createUser(emailAddress, password, Provider.of<Records>(context, listen: false).setDbUser).then((opStatus) {
          if (opStatus == 'success') {
            Navigator.of(context).pushNamed(AppRoutes.HOME);
          }          
        });      
      }
    });


    setState(() {
      _showSpinner = false; // hide spinner
      _isEmailAlreadyUsed = false; // reset the validate email controller
    });



  }


  
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
                validator: (value) => value!.trim().isEmpty ? 'Nome invalido': null,
                onSaved: (value) => _formData['userName'] = value as String,
              ),
              const SizedBox(height: 10,), // space between elements                        
              
              // Email field
              TextFormField(
                //@TODO Validate email here!
                maxLines: 1,
                initialValue: '',
                decoration: const InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
          
                ),
                validator: (value) => _validateEmail(value!),
                onSaved: (value) => _formData['email'] = value as String,
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
                validator: (value) => value!.length < 6 ? "A senha deve ter no minimo 6 caracteres" : null,
                onSaved: (value) => _formData['password'] = value as String,
              ),
              // CheckBox Remember me
                      
              const SizedBox(height: 10,), // space between elements
              //SignIn Buttom
              _showSpinner ? const CircularProgressIndicator(color: Colors.black12) :
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //showDialogSpinner(context);
                    _submitRegister();
                  }
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


