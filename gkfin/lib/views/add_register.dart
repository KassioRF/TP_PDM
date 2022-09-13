import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter_localizations/flutter_localizations.dart';


// Mantém o Input text no formato BRL
//ref: https://gist.github.com/andre-bahia/14fdb0c751822f848a364b3129df1fed
class CurrencyPtBrInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    // ignore: prefer_interpolation_to_compose_strings
    String newText = "R\$ " + formatter.format(value/100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length));
  }
}




class AddRegister extends StatefulWidget {
  const AddRegister({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRegister createState()=> _AddRegister();
}

class _AddRegister extends State<AddRegister> {
  final _formKey = GlobalKey<FormState>();
  final List<bool> _selections = List.generate(3, (_)=>false);

  final List<Color> _fill = [
    Colors.green.withOpacity(.2),
    Colors.red.withOpacity(.2),
    Colors.deepPurple.withOpacity(.2),
  ];
  final List<Color> _border = [
    Colors.green,
    Colors.red,
    Colors.deepPurple,
  ];

  late Color _fillSelected;
  late Color _borderSelected;

  late bool _confirmSave;

  TextEditingController dateinput = TextEditingController(); 
  @override
  void initState() {
    super.initState();
    _confirmSave = false;
    _selections[0] = true;
    _fillSelected = _fill[0];
    _borderSelected = _border[0];
    dateinput.text = "";

  }


  showDialogConfirm(BuildContext context) {
    print('show dialog');
    return showDialog(context: context,
      builder: (context){    
        return StatefulBuilder(builder: (context,setState){
          return AlertDialog(
            content: Text('< ...Confira os dados antes de salvar>'),
            actions: <Widget>[                
              IconButton(onPressed: (){
                  _confirmSave = false;
                  Navigator.of(context).pop(true); 
                },               
              icon: const Icon(Icons.close)),
              IconButton(onPressed: (){
                 _confirmSave = true;
                 Navigator.of(context).pop(true); 
                },
                icon: const Icon(Icons.check_sharp),
                // Navigator.of(context).pop(true);
              ),
              
            ],
          );
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
      
      //@TODO COMPONENTIZAR O FORM
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  margin: const EdgeInsets.all(15.0),
                  child: Row(
                    children: const <Widget> [
                      Text('Despesa'),
                      Icon(Icons.arrow_downward, color: Colors.red),      
                    ],                    
                  )
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const <Widget> [
                      Text('Invest.'),
                      Icon(Icons.stacked_bar_chart, color: Colors.deepPurple),      
                    ],                    
                  )
                ),                
              ],
            ),
            
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column (
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.monetization_on),
                        labelText: 'Valor *',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyPtBrInputFormatter()
                      ]
                    ),
                    TextFormField(
                      //@TODO Validate email here!
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'descrição *',
                        icon: Icon(Icons.info),
                      ),
                    ),                  
                    TextField(
                      //ref: https://gist.github.com/andre-bahia/14fdb0c751822f848a364b3129df1fed
                      controller: dateinput, //editing controller of this TextField
                      decoration: const InputDecoration( 
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "data *" //label text of field
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101)
                        );
                        
                        if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                            String formattedDate = DateFormat('dd-MM-yy').format(pickedDate); 
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text = formattedDate; //set output date to TextField value. 
                            });
                        }else{
                            print("Date is not selected");
                        }
                      },
                    ),                
                  ],
                ),
              ),  
            ),
          ],
        )
      ),
      
    
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check), // cuidado com esse const!
        //@TODO ADD BTN EVENT
        onPressed: () async{
            //@TODO VALIDATE
            // if (validation) {
              //Provider save register
            // }
            await showDialogConfirm(context);
            if (_confirmSave) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              // ignore: use_build_context_synchronously
              showSnackBar(context);
            }
          },

      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //Bottom bar
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        color: Theme.of(context).primaryColor,
        child: Container(height: 37,)

      ),    
    
    
    
    
    
      // floatingActionButton: 
      // Visibility(
      //   visible: !keyboardIsOpen,
      //   child: FloatingActionButton.extended(
      //     // child: const Icon(Icons.add), // cuidado com esse const!
      //     label: const Text('Adicionar'),
      //     //@TODO ADD BTN EVENT
      //     onPressed: (){
      //       //@TODO VALIDATE
      //       // if (validation) {
      //         //Provider save register
      //       // }

      //       showSnackBar(context);
      //       Navigator.of(context).pop();
      //     },

      //   ),
      // )
    );
  }
}


  // Show snackbar when onDismissed list item
void showSnackBar(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text("registrado!"),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: "ok",
        onPressed: () async{
          // Provider.of<Records>(context, listen: false).undoDelete(id, record);
          // await showDialogConfirm(context);
        },
      ),
    ),
  );

}
