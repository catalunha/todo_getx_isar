import 'package:bibliopolium/app/models/model/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getByUid(String uid);
  Future<UserModel?> getById(String id);
  Future<UserModel> create(Map<String, dynamic> data);
  Future<void> update(Map<String, dynamic> data);
}
