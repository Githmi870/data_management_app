import '../repositories/user_repository.dart';
import '../utils/crypto_helper.dart';

class LoginController {
  final UserRepository _userRepo = UserRepository();

  Future<String?> login(String username, String password) async {
    final user = await _userRepo.getUserByUsername(username);
    if (user == null) return 'Invalid username or password';

    final hashedInput = CryptoHelper.hashPassword(password);
    if (user.password != hashedInput) return 'Invalid username or password';

    return null; // Login successful
  }
}
