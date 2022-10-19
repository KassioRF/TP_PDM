import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/dummy_user_data.dart';

class ProfileView extends StatefulWidget {
  const ProfileView ({Key?key}) : super(key:key);

  @override
  _ProfileView createState() => _ProfileView();

}

class _ProfileView extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _user = UserPreferences.userTest;

  late String _email;
  late String _userName;
  late String _passWord;
  
  // manage state of progress Spinner
  late bool _showSpinner;
  // controll validEmail
  late bool _isEmailAlreadyUsed;

  // controll wich field must be updated
  late bool _updateUserName;
  late bool _updateEmail;
  late bool _updatePassWord;

  bool _isObscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showSpinner = false;
    _isEmailAlreadyUsed = false;
    _updateUserName = false;
    _updateEmail = false;
    _updatePassWord = false;
  }

  // validator controller for email input
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
  
  void _submitForm() async {
    _formKey.currentState!.save();

    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());

    // check fields to update
    // se erro em alguma operação return 0; show snackbar
    if (_updateUserName) {

    }

    if (_updateEmail) {

    }

    if (_updatePassWord) {


    }

    // show snackbar feedback


  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      //prevent resize when keyboard shows up
      // resizeToAvoidBottomPadding: false,
      // resizeToAvoidBottomInset: false,
      
      appBar: AppBar(
        // toolbarHeight: 60,
        //@TODO ADD BTN EVENT
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        title: const Text('Meus dados'),
        // actions: [
        //   //@TODO ADD BTN EVENT
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert),)        
        // ],

      ),

      body: SingleChildScrollView (
        child: Column(          
          children: <Widget>[            
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.account_circle, 
                color: Colors.grey.withOpacity(.5),
                size:120,              
              ),                
            ),
            const Divider(height: 5,),              
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 80, 50, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: FirebaseAuth.instance.currentUser?.displayName,
                          filled: false,
                          prefixIcon: const Icon(Icons.account_circle),
                          suffixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) => value!.trim().isEmpty ? 'Nome inválido' : null,
                        onSaved: (value) {
                          setState(() {
                            _userName = value as String;
                            _updateUserName = true;
                          
                          });
                        },

                      ),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: FirebaseAuth.instance.currentUser?.email,
                          filled: false,
                          prefixIcon: const Icon(Icons.email),
                          suffixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) => _validateEmail(value!),
                        onSaved: (value) {
                          setState(() {
                            _email = value as String;
                            _updateEmail = true;
                          });
                        },
                      ),
                      TextFormField(
                        //@TODO Validate password here!
                        maxLines: 1,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          // hintText: ,
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
                            _passWord = value as String;
                            _updatePassWord = true;
                          });
                        },
                      ),
                      
                      SizedBox(height: 20,),
                      // SUBIMIT
                      ElevatedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            _submitForm();
                            
                          }
                          //@TODO VALIDATE FORM
                          // for tests

                        },
                      child: const Text('Salvar'),
                      ),      
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }


}