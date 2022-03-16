import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_getx_isar/app/model/repositories/auth/auth_repository.dart';
import 'package:todo_getx_isar/app/model/repositories/auth/auth_repository_impl.dart';
import 'package:todo_getx_isar/app/viewmodel/auth/auth_controller.dart';
import 'package:todo_getx_isar/app/viewmodel/services/auth/auth_service.dart';
import 'package:todo_getx_isar/app/viewmodel/services/auth/auth_service_impl.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuth>(
      FirebaseAuth.instance,
      permanent: true,
    );
    Get.put<AuthRepository>(
        AuthRepositoryImpl(
          firebaseAuth: Get.find(),
        ),
        permanent: true);
    Get.put<AuthService>(
        AuthServiceImpl(
          authRepository: Get.find(),
        ),
        permanent: true);
    Get.put<AuthController>(
      AuthController(
        firebaseAuth: Get.find(),
        authService: Get.find(),
      ),
      permanent: true,
    );
  }
}
