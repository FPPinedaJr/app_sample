import 'package:drift/drift.dart' as drift;
import 'package:app_example/core/database/app_database.dart'; 

class RegisterLogic {
  Future<String?> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // 1. Validate input
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      return 'Please fill all fields';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    // 2. Database Insertion
    try {
      await appDb.usersDao.registerUser(
        UsersCompanion(
          fullName: drift.Value(fullName),
          email: drift.Value(email),
          password: drift.Value(password),
        ),
      );

      return null; 
    } catch (e) {
      return 'Registration Failed: Email might already exist.';
    }
  }
}
