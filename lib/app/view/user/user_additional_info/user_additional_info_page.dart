import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_isar/app/viewmodel/user/user_additional_info/user_additional_info_controller.dart';

class UserAdditionalInfoPage extends StatefulWidget {
  final UserController _userController = Get.find();
  UserAdditionalInfoPage({Key? key}) : super(key: key);

  @override
  State<UserAdditionalInfoPage> createState() => _UserAdditionalInfoPageState();
}

class _UserAdditionalInfoPageState extends State<UserAdditionalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserAdditionalInfoPage'),
      ),
      body: Obx(
        () => Visibility(
          visible: widget._userController.collectAdditionalInformation.value,
          replacement: const CircularProgressIndicator(),
          child: Column(
            children: [
              CheckboxListTile(
                  value: widget._userController.includeDoing,
                  onChanged: (value) {
                    widget._userController.includeDoing(value);
                  }),
              ElevatedButton(
                child: const Text('Confirmar'),
                onPressed: () {
                  print('validando...');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
