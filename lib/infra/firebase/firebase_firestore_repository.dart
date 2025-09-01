import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreRepository {
  FirebaseFirestoreRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> collection(String path) => _firestore.collection(path);
}


