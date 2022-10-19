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
  PageController _controller = PageController(initialPage: 0, keepPage: false);


  void backToInitialPageView() {
    setState(() {
      _controller.animateToPage(0,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
      //_controller.jumpToPage(0);
    });
  }

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
                              onPressed: () {
                                _controller.animateToPage(1,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
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
                              onPressed: () {
                                _controller.animateToPage(2,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
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
                              onPressed: () {
                                _controller.animateToPage(3,duration : const Duration(milliseconds: 150),curve:Curves.easeIn);
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
                // Center(
                //   child: Text('UserName Form'),
                // ),
                // // EMAIL FORM
                UpdateEmailForm(backToInitialPageView: backToInitialPageView,),
                // Center(
                //   child: Text('Email Form'),                      
                // ),
                // // PASSWORD FORM
                UpdatePasswordForm(backToInitialPageView: backToInitialPageView,),
                // Center(
                //   child: Text('PassWord Form'),
                // ),
              ],
            ),
          ),


        ],
        
      ),
      
      
      
    );
  }


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

    print(newUserName);

    // try update name await for an response!!!!!
    // Verify if we have connection to send request


    // Show Snackbar

    setState(() {
      _showSpinner = false;
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
                        setState(() {
                          _showSpinner = true;
                        });
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

  // manage state of progress Spinner
  late bool _showSpinner;
  late String newEmail;
  @override
  void initState() {
    _showSpinner = false;
  }

  void _submitForm() async {
    _formKey.currentState!.save();

    // dimiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());

    print(newEmail);

    // try update name await for an response!!!!!
    // Verify if we have connection to send request


    // Show Snackbar

    setState(() {
      _showSpinner = false;
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
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: FirebaseAuth.instance.currentUser?.email,
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) => value!.trim().isEmpty ? 'Email Inválido': null,
                onSaved: (value) {
                  setState(() {
                    
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
                ElevatedButton(
                    onPressed: () {
                      // @TODO add route here!!!
                      // if (_formKey.currentState!.validate()) {
                      //   //_submitRegister();
                      // }
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

  // change visibility of form input
  late bool _isObscure;
  // manage state of progress Spinner
  late bool _showSpinner;
  late String newPassWord;
  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _showSpinner = false;

  }

  void _submitForm() async {
    _formKey.currentState!.save();

    // dimiss keyboard during async call
    FocusScope.of(context).requestFocus(FocusNode());

    print(newPassWord);

    // try update name await for an response!!!!!
    // Verify if we have connection to send request


    // Show Snackbar

    setState(() {
      _showSpinner = false;
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
              child: 
                TextFormField(
                  //@TODO Validate password here!
                  maxLines: 1,                  
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Insira a nova senha",
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
                      // _passWord = value as String;
                      // _updatePassWord = true;
                    });
                  },
                ),              
              
              // TextFormField(
              //   decoration: const InputDecoration(
              //     prefixIcon: Icon(Icons.lock),
              //   ),
              //   validator: (value) => value!.length < 6 ? 'A senha deve conter no mínimo 6 caracteres': null,
              //   onSaved: (value) {
              //     setState(() {
                    
              //     });
              //   },
              // ),
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
                ElevatedButton(
                    onPressed: () {
                      // @TODO add route here!!!
                      // if (_formKey.currentState!.validate()) {
                      //   //_submitRegister();
                      // }
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