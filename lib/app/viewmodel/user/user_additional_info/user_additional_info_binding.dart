import 'package:bibliopolium/app/controllers/community/community_repository.dart';
import 'package:bibliopolium/app/controllers/community/community_repository_impl.dart';
import 'package:bibliopolium/app/controllers/user/user_controller.dart';
import 'package:bibliopolium/app/controllers/user/user_repository.dart';
import 'package:bibliopolium/app/controllers/user/user_repository_impl.dart';
import 'package:bibliopolium/app/models/community/community_source.dart';
import 'package:bibliopolium/app/models/community/community_source_impl.dart';
import 'package:bibliopolium/app/models/user/user_source.dart';
import 'package:bibliopolium/app/models/user/user_source_impl.dart';
import 'package:get/get.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RegisterSource>(
      RegisterSourceImpl(
        firebaseFirestore: Get.find(),
      ),
    );
    Get.put<RegisterRepository>(
      RegisterRepositoryImpl(
        userSource: Get.find(),
      ),
    );

    Get.put<UserController>(UserController(
      authController: Get.find(),
      userRepository: Get.find(),
    ));
  }
}
