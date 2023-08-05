String? emailValidator(String email) {
  if (email != "") {
    var regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (regex) {
      return null;
    } else {
      return "Masukan email yang valid";
    }
  } else {
    return "Email harus diisi!";
  }
}

String? ipValidator(String? value) {
  if (value != "" && value != null) {
    var valid = RegExp(
      r"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",
    ).hasMatch(value);
    if (valid) {
      return null;
    } else {
      return "Masukan ip address yang valid";
    }
  } else {
    return "Ip Address harus diisi!";
  }
}

String? phoneValidator(String field, String value) {
  if (value.isNotEmpty) {
    var regex = RegExp(
      r"^[0-9]+$",
    ).hasMatch(value);
    if (regex) {
      return null;
    } else {
      return "$field harus valid!";
    }
  } else {
    return "$field tidak boleh kosong";
  }
}

String? pwValidator(String password) {
  if (password != "") {
    if (password.length >= 5) {
      return null;
    } else {
      return "Password minimal 5 huruf";
    }
  } else {
    return "Password harus diisi!";
  }
}

String? emptyValidator(String field, String value) {
  if (value.isNotEmpty) {
    return null;
  } else {
    return "$field harus diisi!";
  }
}
