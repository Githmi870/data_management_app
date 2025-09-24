import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../utils/crypto_helper.dart';

class AuthService {
  final UserRepository _userRepo = UserRepository();

  Future<String?> registerUser(String username, String password) async {
    final exists = await _userRepo.usernameExists(username);
    if (exists) return 'Username already exists.';

    final hashedPassword = CryptoHelper.hashPassword(password);
    final user = User(username: username, password: hashedPassword);
    final userId = await _userRepo.insertUser(user);

    return userId > 0 ? null : 'Failed to create account.';
  }
}
