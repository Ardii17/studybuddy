import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onDelete;

  const DeleteConfirmationDialog({
    Key? key,
    this.title = 'Konfirmasi Hapus',
    this.content = 'Apakah Anda yakin ingin menghapus data ini?',
    required this.onDelete,
  }) : super(key: key);

  // Fungsi untuk menampilkan dialog
  static Future<void> show({
    required BuildContext context,
    String? title,
    String? content,
    required Function() onDelete,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          title: title ?? 'Konfirmasi Hapus',
          content: content ?? 'Apakah Anda yakin ingin menghapus data ini?',
          onDelete: onDelete,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Batal',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onDelete();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'Hapus',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}