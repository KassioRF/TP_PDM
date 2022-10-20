import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gkfin/providers/userAuthentication.dart';
import '../data/dummy_user_data.dart';
import 'package:gkfin/utils/checkInternetConn.dart';


class ProfileView extends StatefulWidget {
  const ProfileView ({Key?key}) : super(key:key);

  @override
  _ProfileView createState() => _ProfileView();

}

class _ProfileView extends State<ProfileView> {
  PageController _controller = PageController(initialPage: 0, keepPage: false);


  void backToInitialPageView() {
    setState(() {
      _controller.animateToPage(0,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
      //_controller.jumpToPage(0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[        
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.account_circle, 
                color: Colors.grey.withOpacity(.5),
                size:120,              
              ),                                        
            ),    
          ),
          const Divider(height: 5,),
          Expanded(
            //flex: 1,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // EDIT: USERNAME
                    Container(                    
                      padding: const EdgeInsets.fromLTRB(50, 80, 50, 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[                      
                          Expanded(
                            flex: 2,
                            child: TextField(
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: FirebaseAuth.instance.currentUser?.displayName,
                                prefixIcon: const Icon(Icons.account_circle),
                              ),
                            ),
                          ),
                          Expanded(

                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.grey.withOpacity(.9),),
                              onPressed: () async {
                                bool internetConn = await CheckInternetConn();
                                if (internetConn) {
                                  _controller.animateToPage(1,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
                                }else {
                                  showSnackBar(context, "Atualizar os dados requer conexão com a internet");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // EDIT: EMAIL
                    Container(                    
                      padding: const EdgeInsets.fromLTRB(50, 15, 50, 10),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[                      
                          Expanded(
                            flex: 2,
                            child: TextField(
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: FirebaseAuth.instance.currentUser?.email,
                                prefixIcon: const Icon(Icons.email),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.grey.withOpacity(.9),),
                              onPressed: () async {
                                bool internetConn = await CheckInternetConn();
                                if (internetConn) {
                                  _controller.animateToPage(2,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
                                }else {
                                  showSnackBar(context, "Atualizar os dados requer conexão com a internet");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // EDIT PASSWORD
                    Container(                    
                      padding: const EdgeInsets.fromLTRB(50, 15, 50, 10),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[                      
                          const Expanded(
                            flex: 2,
                            child: TextField(
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: 'Alterar senha',
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.grey.withOpacity(.9),),
                              onPressed: () async {
                                bool internetConn = await CheckInternetConn();
                                if (internetConn) {
                                  _controller.animateToPage(3,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
                                }else {
                                  showSnackBar(context, "Atualizar os dados requer conexão com a internet");
                                }                                
                              },
                            ),
                          ),
                        ],
                      ),
                    ),                    
                  ],
                ),
                // FORMS
                // USERNAME FORM            
                UpdateUserNameForm(backToInitialPageView: backToInitialPageView,),
                // // EMAIL FORM
                UpdateEmailForm(backToInitialPageView: backToInitialPageView,),
                // // PASSWORD FORM
                UpdatePasswordForm(backToInitialPageView: backToInitialPageView,),
              ],
            ),
          ),


        ],
        
      ),
      
      
      
    );
  }


}

// Widgets e funções auxiliares


void showSnackBar(context, String msgFeedback) {
  // Exibe um snackbar com uma mensagem de feedback
  // Utilizada ao final de uma operação
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msgFeedback),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: "ok",
        onPressed: () async {},
      ),
    ),
  );

}

String? _validateEmail(String emailAddress, bool _isEmailAlreadyUsed, setState) {
  // Validação Email
  if (!EmailValidator.validate(emailAddress)) {
    return 'Insira um email válido';
  }
  
  if (_isEmailAlreadyUsed) {
    setState(() => _isEmailAlreadyUsed = false);      
    return 'email já cadastrado';
  }
  return null;
}
String? _validatePassword(String password, bool _passWordIsCorrect, setState) {
  // Validação Senha
  if (password.trim().isEmpty) {
    return "preencha os campos";
  }
  if (password.length < 6 ) {
    return "A senha deve ter no minimo 6 caracteres";
  }
  if (!_passWordIsCorrect) {
    return 'Senha incorreta';
  }
  return null;
}




// Username Form Widget
class UpdateUserNameForm extends StatefulWidget {
  UpdateUserNameForm({Key? key, required this.backToInitialPageView}) : super(key:key);  
  final VoidCallback backToInitialPageView;
  @override
  _UpdateUserNameForm createState() => _UpdateUserNameForm();
}
class _UpdateUserNameForm extends State<UpdateUserNameForm> {
  final _formKey = GlobalKey<FormState>();

  // manage state of progress Spinner
  late bool _showSpinner;
  late String newUserName;
  @override
  void initState() {
    _showSpinner = false;
  }

  void _submitForm() async {
    _formKey.currentState!.save();
    // dimiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());

    await UserAuthentication.updateName(newUserName)
    .then((opStatus) {
      setState(() {
        _showSpinner = false;
      });
      if (opStatus == 'success') {
        showSnackBar(context, "Nome atualizado!");
      }else {
        showSnackBar(context, "Ops! Algo deu errado...");
      }
      widget.backToInitialPageView();        
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    //return const Text('updateUser Form');
    return Center(
      child: Container(                    
        padding: const EdgeInsets.fromLTRB(50, 80, 50, 10),
        alignment: Alignment.center,            
        child: Column(
          children: <Widget>[                      
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: FirebaseAuth.instance.currentUser?.displayName,
                  prefixIcon: const Icon(Icons.account_circle),
                ),
                validator: (value) => value!.trim().isEmpty ? 'Nome inválido': null,
                onSaved: (value) {
                  setState(() {
                    newUserName = value as String;
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
                    widget.backToInitialPageView();
                  },
                  child: const Text('voltar',),
                ),          

                _showSpinner ? const CircularProgressIndicator(color: Colors.black12) :
                ElevatedButton(
                    onPressed: () {
                      
                      if (_formKey.currentState!.validate()) {
                        setState(() { _showSpinner = true; });
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

// Email Form Widget
class UpdateEmailForm extends StatefulWidget {
  const UpdateEmailForm({Key? key, required this.backToInitialPageView}) : super(key:key);  
  final VoidCallback backToInitialPageView;
  
  @override
  _UpdateEmailForm createState() => _UpdateEmailForm();
}
class _UpdateEmailForm extends State<UpdateEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  late bool _isEmailAlreadyUsed;
  late bool _passWordIsCorrect;
  // change visibility of form input
  late bool _isObscure;
  // manage state of progress Spinner
  late bool _showSpinner;
  late String newEmail;
  late String password;
  
  @override
  void initState() {
    super.initState();
    _showSpinner = false;
    _isObscure = false;
    _passWordIsCorrect = true;
    _isEmailAlreadyUsed = false;
  }

  void _submitForm() async {
    _formKey.currentState!.save();
    _formKeyPassword.currentState!.save();
    // dimiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() => _showSpinner = true );
    print("\n\t ------------- <><><<><><><><><><><>");
    print(newEmail);
    
    final String confirmAuth = await UserAuthentication.reautenticateUser(password);
    if (confirmAuth == 'success') {
      setState(() => _passWordIsCorrect = true );
      print(confirmAuth);
      print("\n\t ------------- <><><<><><><><><><><>");
      try {
        await UserAuthentication.updateEmail(newEmail).timeout(const Duration(seconds: 10))
        .then((opStatus) {
          setState(() {
            _showSpinner = false;
          });

          if (opStatus == 'success') {
            showSnackBar(context, "Email atualizado!");
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
      _formKeyPassword.currentState!.validate();
      
    }
    

    setState(() {
      _showSpinner = false;
      _isEmailAlreadyUsed = false;
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
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: FirebaseAuth.instance.currentUser?.email,
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) => _validateEmail(value as String, _isEmailAlreadyUsed, setState),
                onSaved: (value) {
                  setState(() {
                    newEmail = value as String;
                  });
                },
              ),
            ),
            const SizedBox(height: 20,), // space between elements
            Form(
              key: _formKeyPassword,
              child: 
                TextFormField(
                  //@TODO Validate password here!
                  maxLines: 1,                  
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "* requer a senha p/ atualizar",
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
                  validator: (value)  => _validatePassword(value as String, _passWordIsCorrect, setState),
                  onSaved: (value) {
                    setState(() {
                      password = value as String;
                      // _updatePassWord = true;
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
                    widget.backToInitialPageView();
                  },
                  child: const Text('voltar',),
                ),
                _showSpinner ? const CircularProgressIndicator(color: Colors.black12) :
                ElevatedButton(
                    onPressed: () {
                      // @TODO add route here!!!
                      if (_formKey.currentState!.validate() && _formKeyPassword.currentState!.validate()) {
                        print("\n\t ------------- <><><<><><><><><><><>");
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
                  validator: (value)  => _validatePassword(value as String, _passWordIsCorrect, setState),
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