
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gkfin/data/dummy_user_data.dart';

class UserProvider with ChangeNotifier {

  final User user;

  UserProvider({required this.user});

}