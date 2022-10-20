
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gkfin/utils/checkInternetConn.dart';
import 'package:gkfin/utils/snack_bar_generic.dart';

// FORMS update user data
import 'package:gkfin/widgets/update_profile/update_username_form.dart';
import 'package:gkfin/widgets/update_profile/update_email_form.dart';
import 'package:gkfin/widgets/update_profile/update_password_form.dart';


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
          Expanded(
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.blueAccent),
            // ),
            //flex: 1,
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
            flex: 4,
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
