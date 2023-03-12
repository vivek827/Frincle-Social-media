import "package:flutter/material.dart";
import 'package:frincle_v2/service/auth_service.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  final AuthService _authService = AuthService();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authService.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
