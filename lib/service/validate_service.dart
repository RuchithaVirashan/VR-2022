class ValidateService {
  String? isEmptyField(String value) {
    if (value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    String? isEmpty = isEmptyField(value);

    if (isEmpty != null) {
      return isEmpty;
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 8) {
      return "Must be more than 8 charactors";
    }

    if (!password.contains(RegExp(r"[a-z]"))) {
      return "at least one lowercase character";
    }
    if (!password.contains(RegExp(r"[A-Z]"))) {
      return "at least one upper case character";
    }
    if (!password.contains(RegExp(r"[0-9]"))) {
      return "at least one Digit";
    }
    return null;
  }
}
