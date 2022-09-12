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
  bool _isObscure = true;

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
                          hintText: _user.name,
                          filled: false,
                          prefixIcon: const Icon(Icons.account_circle),
                          suffixIcon: const Icon(Icons.edit),
                        ),
                      ),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: _user.email,
                          filled: false,
                          prefixIcon: const Icon(Icons.email),
                          suffixIcon: const Icon(Icons.edit),
                        ),
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
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: (){
                          //@TODO VALIDATE FORM}
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