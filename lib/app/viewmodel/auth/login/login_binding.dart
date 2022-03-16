import 'package:get/get.dart';
import 'package:todo_getx_hive/app/controllers/auth/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        () => LoginController(userService: Get.find()));
  }
}
