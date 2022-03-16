import 'package:get/get.dart';
import 'package:todo_getx_isar/app/view/auth/login/login_page.dart';
import 'package:todo_getx_isar/app/view/auth/method/email_password/email_password_page.dart';
import 'package:todo_getx_isar/app/view/splash/splash_page.dart';
import 'package:todo_getx_isar/app/view/user/user_additional_info/user_additional_info_page.dart';
import 'package:todo_getx_isar/app/viewmodel/auth/auth_binding.dart';
import 'package:todo_getx_isar/app/viewmodel/auth/login/login_binding.dart';
import 'package:todo_getx_isar/app/viewmodel/auth/method/email_password/email_password_binding.dart';

class Routes {
  static const splash = '/';
  static const authLogin = '/auth/login';
  static const authEmailPassword = '/auth/email_password';
  static const userAdditionalInfo = '/user/additional_info';
  static const userAnalyzingInfo = '/user/analyzing_info';
  static const home = '/home';
  static const taskCreate = '/task/create';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: AuthBinding(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.authLogin,
      binding: AuthLoginBinding(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.authEmailPassword,
      binding: AuthEmailPasswordBinding(),
      page: () => AuthEmailPasswordPage(),
    ),
    GetPage(
      name: Routes.userAdditionalInfo,
      binding: UserAdditionalInfoBinding(),
      page: () => UserAdditionalInfoPage(),
    ),
    GetPage(
      name: Routes.userAnalyzingInfo,
      page: () => UserAnalyzingInfoPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeBinding(),
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.taskCreate,
      binding: TaskCreateBinding(),
      page: () => TaskCreatePage(),
    ),
  ];
}
