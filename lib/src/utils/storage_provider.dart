// Package imports:
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/data/auth_repository.dart';

class StorageProvider {
  final AuthRepository authProvider = AuthRepository();
  static final _secureStorage = EncryptedSharedPreferences();
  StorageProvider();

  static getValue(String key) async {
    return await _secureStorage.getString(key);
  }

  static setValue(String key, value) async {
    await _secureStorage.setString(key, value);
  }

  static deleteValue(String key) async {
    await _secureStorage.remove(key);
  }
}
