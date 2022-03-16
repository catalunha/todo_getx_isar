import 'package:bibliopolium/app/controllers/user/user_repository.dart';
import 'package:bibliopolium/app/models/model/user_model.dart';
import 'package:bibliopolium/app/models/user/user_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserSource _userSource;
  UserRepositoryImpl({required UserSource userSource})
      : _userSource = userSource;
  @override
  Future<UserModel?> getByUid(String uid) async {
    print('Em UserRepositoryImpl.getByuid');
    return await _userSource.getByUid(uid);
  }

  @override
  Future<UserModel> create(Map<String, dynamic> data) async {
    print('Em UserRepositoryImpl.create');
    return await _userSource.create(data);
  }
}
