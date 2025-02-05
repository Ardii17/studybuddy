// Import package yang dibutuhkan
import 'package:shared_preferences/shared_preferences.dart'; // Package untuk menyimpan data lokal
import '../utils/encryption_helper.dart'; // Helper untuk enkripsi/dekripsi

// Class AuthService untuk menangani autentikasi
class AuthService {
  // Konstanta key untuk menyimpan username dan password di SharedPreferences
  static const _usernameKey = 'username';
  static const _passwordKey = 'password';

  // Method untuk registrasi user baru
  Future<bool> register(String username, String password) async {
    // Mendapatkan instance SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Cek apakah username sudah ada
    if (prefs.containsKey(_usernameKey)) return false; // Jika ada, return false

    // Enkripsi dan simpan username dan password
    prefs.setString(_usernameKey, username);
    prefs.setString(_passwordKey, password);

    return true; // Registrasi berhasil
  }

  // Method untuk login user
  Future<bool> login(String username, String password) async {
    // Mendapatkan instance SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Mengambil username dan password terenkripsi dari SharedPreferences
    final encryptedUsername = prefs.getString(_usernameKey);
    final encryptedPassword = prefs.getString(_passwordKey);

    // Jika username atau password tidak ditemukan, return false
    if (encryptedUsername == null || encryptedPassword == null) return false;

    // Dekripsi username dan password yang tersimpan
    // final storedUsername = EncryptionHelper.decrypt(encryptedUsername);
    // final storedPassword = EncryptionHelper.decrypt(encryptedPassword);

    // Bandingkan dengan input user
    return username == encryptedUsername && password == encryptedPassword;
  }

  // Method untuk logout user
  Future<void> logout() async {
    // Mendapatkan instance SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Menghapus semua data tersimpan
    await prefs.clear();
  }
}
