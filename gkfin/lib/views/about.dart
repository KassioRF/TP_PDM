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
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget>[
            Image.asset('assets/FRONT-END-GK-Financas-No-BG-Green-Vectorized.png', width:120, height: 100,),
            // const SizedBox(height: 20,),
            
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('GK Finanças é a sua solução portátil para facilitar a organização e controle de suas finanças pessoais!',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16,),                  
                  const Text('Você poderá:', textAlign: TextAlign.start,),
                  const SizedBox(height: 12,),                  
                  const Text('Cadastrar e realizar login utilizando seu e-mail;', textAlign: TextAlign.justify, style: TextStyle(fontSize: 12),),
                  const SizedBox(height: 6,),                  
                  const Text('Cadastrar, pesquisar, editar e excluir Despesas, Receitas e Investimentos;', textAlign: TextAlign.justify, style: TextStyle(fontSize: 12),),
                  const SizedBox(height: 6,),                  
                  const Text('Visualizar o Saldo no Período (Receita - Despesas);', textAlign: TextAlign.justify, style: TextStyle(fontSize: 12),),
                  const SizedBox(height: 6,),                  
                  const Text('Visualizar separadamente o total de Receita, Despesas e Investimentos;', textAlign: TextAlign.justify, style: TextStyle(fontSize: 12),),
                  const SizedBox(height: 6,),                  
                  const Text('Tudo isso com uma interface simples e direta! =D', textAlign: TextAlign.justify, style: TextStyle(fontSize: 12),),
                  const SizedBox(height: 6,),                  
                  const Text('Tudo isso para você  para você explorar de forma gratuita, não é uma beleza?', textAlign: TextAlign.justify, style: TextStyle(fontSize: 12),),
                  const SizedBox(height: 12,),                  
                  
                  
                  
                  Column(
                    children: const <Widget>[                      
                      Divider(height: 24,),
                      Text('Desenvolvido por: '),
                      SizedBox(height: 20,),
                      Text('Kassio Rodrigues Ferreira e Gustavo Estevam Sena.', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 20,),
                      Text('2022'),
                    ],
                  ),
                ],
              ),
            ),

            ],
          ),
      ), 

    );
  }
}