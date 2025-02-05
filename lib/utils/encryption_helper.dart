import 'package:encrypt/encrypt.dart'; // Mengimpor library untuk enkripsi dan dekripsi data

// Membuat kelas EncryptionHelper untuk menangani enkripsi dan dekripsi
class EncryptionHelper {
  // Mendefinisikan kunci enkripsi (Key) dengan panjang 32 karakter
  static final _key = Key.fromUtf8(
      'my32lengthsupersecretnooneknows1'); // Gunakan kunci yang tepat sepanjang 32 karakter
  // Membuat Initial Vector (IV) dengan panjang 16 byte (IV digunakan untuk memperkuat keamanan)
  static final _iv = IV.fromLength(16);

  // Fungsi untuk mengenkripsi teks biasa (plainText)
  static String encrypt(String plainText) {
    // Membuat objek enkriptor dengan algoritma AES menggunakan kunci yang telah ditentukan
    final encrypter = Encrypter(AES(_key));
    // Mengenkripsi teks biasa dan menggunakan IV yang telah didefinisikan
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    // Mengembalikan hasil enkripsi dalam format base64
    return encrypted.base64;
  }

  // Fungsi untuk mendekripsi teks yang telah dienkripsi
  static String decrypt(String encryptedText) {
    // Membuat objek enkriptor dengan algoritma AES menggunakan kunci yang telah ditentukan
    final encrypter = Encrypter(AES(_key));
    // Mendekripsi teks yang telah dienkripsi (dalam format base64) menggunakan IV yang telah didefinisikan
    final decrypted = encrypter.decrypt64(encryptedText, iv: _iv);
    // Mengembalikan hasil dekripsi sebagai teks biasa
    return decrypted;
  }
}
