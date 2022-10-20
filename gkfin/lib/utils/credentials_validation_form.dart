

import 'package:email_validator/email_validator.dart';


mixin CredentialsValidationForm {

  static String? validateEmail(String emailAddress, bool _isEmailAlreadyUsed, setState) {
    // Validação Email
    if (!EmailValidator.validate(emailAddress)) {
      return 'Insira um email válido';
    }
    
    if (_isEmailAlreadyUsed) {
      setState(() => _isEmailAlreadyUsed = false);      
      return 'email já cadastrado';
    }
    return null;
  }
  static String? validatePassword(String password, bool _passWordIsCorrect, setState) {
    // Validação Senha
    if (password.trim().isEmpty) {
      return "preencha os campos";
    }
    if (password.length < 6 ) {
      return "A senha deve ter no minimo 6 caracteres";
    }
    if (!_passWordIsCorrect) {
      return 'Senha incorreta';
    }
    return null;
  }
}
