// Username Form Widget
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:gkfin/providers/userAuthentication.dart";
import "package:gkfin/utils/snack_bar_generic.dart";

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