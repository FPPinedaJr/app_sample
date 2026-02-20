import 'package:app_example/core/database/app_database.dart';
import 'package:app_example/core/session_manager.dart'; 

class LoginLogic {
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill in all fields';
    }

    try {
      final user = await appDb.usersDao.getUserByEmail(email);

      if (user == null) {
        return 'No account found for this email.';
      }

      if (user.password != password) {
        return 'Incorrect password.';
      }

      await sessionManager.saveSession(user.id);

      return null;
    } catch (e) {
      return 'An unexpected error occurred during login.';
    }
  }
}