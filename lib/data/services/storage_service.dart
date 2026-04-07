import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage;

  StorageService({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  Future<String> uploadImage(File file, String path) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = _storage.ref().child('$path/$fileName');

    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }
}