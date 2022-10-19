//ref: https://www.youtube.com/watch?v=MBZupreHjn0
import 'package:flutter/material.dart';
import 'package:gkfin/utils/app_routes.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key:key);

  @override
  // ignore: library_private_types_in_public_api
  _Splash createState() => _Splash ();
}

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(AppRoutes.HOME);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/FRONT-END-GK-Financas-Green-BD-Vectorized.jpg', scale: 1,),
            const SizedBox(height: 20,),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),

      ),
    );
  }

}