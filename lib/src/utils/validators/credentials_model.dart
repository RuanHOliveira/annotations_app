import 'package:flutter/material.dart';

class CredentialsModel extends ChangeNotifier {
  String name;
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String registerPassword;
  String confirmPassword;

  CredentialsModel({
    this.name = '',
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.registerPassword = '',
    this.confirmPassword = '',
  });

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setFirstName(String firstName) {
    this.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
    notifyListeners();
  }

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setRegisterPassword(String registerPassword) {
    this.registerPassword = registerPassword;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    notifyListeners();
  }
}
