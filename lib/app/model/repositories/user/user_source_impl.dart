import 'package:bibliopolium/app/models/exceptions/user_exceptions.dart';
import 'package:bibliopolium/app/models/model/user_model.dart';
import 'package:bibliopolium/app/models/user/user_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSourceImpl implements UserSource {
  final FirebaseFirestore _firebaseFirestore;

  UserSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<UserModel?> getByUid(String uid) async {
    print('Em UserSourceImpl.getByUid - 1');
    var querySnapshot = await _firebaseFirestore
        .collection(UserModel.collection)
        .where('uid', isEqualTo: uid)
        .get();
    print(
        'Em UserSourceImpl.getByUid | querySnapshot.size: ${querySnapshot.size}');
    if (querySnapshot.size == 0) {
      // print('Em UserSourceImpl.getByuid - 3');
      // print('Nao achei nenhum document em UserModel com uid $uid');
      return null;
    } else if (querySnapshot.size == 1) {
      // print('Em UserSourceImpl.getByuid - 4');
      var queryDocumentSnapshot = querySnapshot.docs.first;
      // print('Em UserSourceImpl.getByuid - 5');
      try {
        print('Em UserSourceImpl.getByuid - 6 ${queryDocumentSnapshot.data()}');
        var temp = UserModel.fromMap(queryDocumentSnapshot.data());
        // print('Em UserSourceImpl.getByuid - 7');
        return temp;
      } catch (e) {
        // print('Em UserSourceImpl.getByuid - 8');
        throw UserException(message: 'Erro em UserModel.fromMap');
      }
    } else {
      print('Em UserSourceImpl.getByuid - 9');
      throw UserException(message: 'Encontrei mais um UserModel');
    }
  }

  @override
  Future<UserModel> create(Map<String, dynamic> data) async {
    try {
      CollectionReference docRef =
          _firebaseFirestore.collection(UserModel.collection);
      String idNew = docRef.doc().id;
      print('create.map1 $data');
      var userModel = UserModel.fromMap(data).copyWith(id: idNew);
      print('create.map2 ${userModel.toMap()}');

      await docRef.doc(idNew).set(userModel.toMap());
      return userModel;
    } catch (e) {
      throw UserException(message: 'Erro em UserSourceImpl.create');
    }
  }

  @override
  Future<UserModel?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<String, dynamic> data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
