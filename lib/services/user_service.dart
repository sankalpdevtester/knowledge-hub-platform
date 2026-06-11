import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comprehensive_knowledge_hub_platform/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String uid) async {
    final DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(uid).get();
    if (documentSnapshot.exists) {
      return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
    return UserModel(
      uid: '',
      email: '',
      displayName: '',
      photoURL: '',
    );
  }

  Future<void> updateUser(UserModel userModel) async {
    await _firestore.collection('users').doc(userModel.uid).update({
      'email': userModel.email,
      'displayName': userModel.displayName,
      'photoURL': userModel.photoURL,
    });
  }

  Stream<List<UserModel>> getUsers() {
    return _firestore.collection('users').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((documentSnapshot) {
        return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}