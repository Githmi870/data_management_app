import '../models/user.dart';

class AuthService {
  Future<bool> login(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}