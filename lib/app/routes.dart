import 'package:get/get.dart';
import 'package:todo_getx_isar/app/ui/auth/login/login_page.dart';
import 'package:todo_getx_isar/app/ui/auth/register/register_page.dart';
import 'package:todo_getx_isar/app/ui/create/task_create_page.dart';
import 'package:todo_getx_isar/app/ui/home/home_page.dart';
import 'package:todo_getx_isar/app/ui/splash/splash_page.dart';
import 'package:todo_getx_isar/app/view/splash/splash_page.dart';

class Routes {
  static const splash = '/';
  static const authLogin = '/auth/login';
  static const authEmailPassword = '/auth/method/email_password';
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
      binding: LoginBinding(),
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.authEmailPassword,
      binding: EmailPasswordBinding(),
      page: () => EmailPasswordPage(),
    ),
    GetPage(
      name: Routes.additionalInfoUser,
      binding: AdditionalInfoUserBinding(),
      page: () => AdditionalInfoUserPage(),
    ),
    GetPage(
      name: Routes.analyzingInfoUser,
      page: () => AnalyzingInfoUserPage(),
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
