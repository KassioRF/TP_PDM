import 'package:flutter/material.dart';

class AddRegister extends StatefulWidget {
  const AddRegister({super.key});

  @override
  _AddRegister createState()=> _AddRegister();
}

class _AddRegister extends State<AddRegister> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        // toolbarHeight: 60,
        //@TODO ADD BTN EVENT
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        title: const Text('Adicionar'),
        // actions: [
        //   //@TODO ADD BTN EVENT
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert),)        
        // ],

      )        
      
    );
  }
}
