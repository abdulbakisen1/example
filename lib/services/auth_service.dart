import 'package:flutter/foundation.dart';

/// Basit/sahte auth servisi: yalnızca bellek içi login durumu.
/// Normalde burada API çağrıları ve token yönetimi olur.
class AuthService {
  bool _loggedIn = false;
  String? _email;

  // UI'nin dinlemesi için reaktif değişken
  final ValueNotifier<bool> isLoggedInListenable = ValueNotifier(false);

  String? get email => _email;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 450)); // Demo gecikme
    _loggedIn = true;
    _email = email;
    isLoggedInListenable.value = true;
    return true;
  }

  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 450));
    _loggedIn = true;
    _email = email;
    isLoggedInListenable.value = true;
    return true;
  }

  void logout() {
    _loggedIn = false;
    _email = null;
    isLoggedInListenable.value = false;
  }
}
