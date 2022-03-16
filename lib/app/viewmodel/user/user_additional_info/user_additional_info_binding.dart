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
