import 'package:flutter/material.dart';


class AboutView extends StatelessWidget {
  const AboutView ({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 60,
        //@TODO ADD BTN EVENT
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        title: const Text(''),
        // actions: [
        //   //@TODO ADD BTN EVENT
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert),)        
        // ],

      ),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
            Image.asset('assets/FRONT-END-GK-Financas-No-BG-Green-Vectorized.png', width:200, height: 175,),
            // const SizedBox(height: 20,),
            
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: const <Widget>[
                  Text(' GK Finançãs é a sua solução portátil para facilitar a organização e controle de suas finanças pessoais!'),
                  // const SizedBox(height: 5,),                  
                  Divider(height: 45,),
                  Text('Desenvolvido por: '),
                  SizedBox(height: 20,),
                  Text('Kassio Rodrigues Ferreira e Gustavo Estevam Sena.', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 20,),
                  Text('2022'),
                ],
              ),
            ),

            ],
          ),
      ), 

    );
  }
}