
class ValidatorModelAppDefault {

  List<String>bannedLetters = [
    "\$",
    "<",
    ">",
    "&",
    '"',
    "+",
    "-",
    "%",
    "'",
    ";",
    "_",
    "[",
    "]",
    "{",
    "}",
    "=",
    "/",
    "*",
    ";",
    ".",
    "#"
  ];

  checkBannedLetters(String text, String exceptionLetter){
    for(String l in text.split('')){
      if(l != exceptionLetter){
        if(bannedLetters.contains(l)){
          return true;
        }
      }
    }
    return false;
  }

  String? validateEmail(email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(emailValid == false) return 'email inválido';
    return null;
  }

  String? validatePassword(password){

    bool passwordValid = RegExp(r"^(?=.*?[0-9]).{8,}$").hasMatch(password);

    if(password.isEmpty) {
      return 'obrigatório';
    } else if(passwordValid == false) {
      return 'a senha deve conter números e no mínimo 8 caracteres';
    }
    return null;
  }

  String? validateText(text){
    if(text.isEmpty) return 'obrigatório';
    return null;
  }

  String? validateTags(text){
    if(text.isEmpty) {
      return 'obrigatório';
    }
    bool checkLetter = checkBannedLetters(text, '');
    if(checkLetter) {
      return 'formato inválido';
    }
    String textValueTag = text.replaceAll('#', '');
    if(textValueTag.isEmpty) {
      return 'formato inválido';
    }
    return null;
  }

}