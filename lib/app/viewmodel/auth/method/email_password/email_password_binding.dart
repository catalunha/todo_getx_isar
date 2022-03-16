import 'package:get/get.dart';
import 'package:todo_getx_hive/app/controllers/auth/register/register_controller.dart';

class EmailPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailPasswordController>(
        () => EmailPasswordController(userService: Get.find()));
  }
}
