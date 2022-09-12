import 'package:flutter/material.dart';

class AddRegister extends StatefulWidget {
  const AddRegister({super.key});

  @override
  _AddRegister createState()=> _AddRegister();
}




class _AddRegister extends State<AddRegister> {
  final _formKey = GlobalKey<FormState>();
  List<bool> _selections = List.generate(3, (_)=>false);

  List<Color> _fill = [
    Colors.green.withOpacity(.2),
    Colors.blue.withOpacity(.2),
    Colors.red.withOpacity(.2),
  ];
  List<Color> _border = [
    Colors.green,
    Colors.blue,
    Colors.red,
  ];

  late Color _fillSelected;
  late Color _borderSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selections[0] = true;
    _fillSelected = _fill[0];
    _borderSelected = _border[0];
  }


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
        title: const Text(''),
        // actions: [
        //   //@TODO ADD BTN EVENT
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert),)        
        // ],

      ),      
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        // SizedBox(height: 20,),
          children: <Widget>[
            ToggleButtons(
              isSelected: _selections,
              selectedColor: Colors.black87,
              fillColor: _fillSelected,
              selectedBorderColor: _borderSelected,
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0; buttonIndex < _selections.length; buttonIndex++) {
                    if (buttonIndex == index) {
                      _selections[buttonIndex] = true;
                      _fillSelected = _fill[index];
                      _borderSelected = _border[index];
                    } else {
                      _selections[buttonIndex] = false;
                    }
                  }
                });
              },
              children:  <Widget>[

                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const <Widget>[
                      Text('Receita'),
                      Icon(Icons.arrow_upward, color: Colors.green),
                    ],
                    
                  )
                ),

                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const <Widget> [
                      Text('Invest.'),
                      Icon(Icons.stacked_bar_chart, color: Colors.blue),      
                    ],
                    
                  )

                ),

                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const <Widget> [
                      Text('Despesa'),
                      Icon(Icons.arrow_downward, color: Colors.red),      
                    ],
                    
                  )

                ),
              ],

            )
          ],
        ),  

      ),
      
      
      
      floatingActionButton: FloatingActionButton.extended(
        // child: const Icon(Icons.add), // cuidado com esse const!
        label: const Text('Adicionar'),
        //@TODO ADD BTN EVENT
        onPressed: (){
          //Provider save register
        },

      ),
    );
  }
}
