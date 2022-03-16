import 'package:bibliopolium/app/controllers/user/user_controller.dart';
import 'package:bibliopolium/app/models/model/comunity_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class UserPage extends StatefulWidget {
  final UserController _userController = Get.find();
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  final _cellPhoneTec = TextEditingController();
  final _addressTec = TextEditingController();
  final _cepTec = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _cellPhoneTec.text = '63992304757';
    _addressTec.text = 'aa';
    _cepTec.text = '77018416';
    super.initState();
  }

  @override
  void dispose() {
    _cellPhoneTec.dispose();
    _addressTec.dispose();
    _cepTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserPage'),
      ),
      body: Obx(
        () => Visibility(
          visible: widget._userController.collectAdditionalInformation.value,
          replacement: const CircularProgressIndicator(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Telefone Celular'),
                    TextFormField(
                      controller: _cellPhoneTec,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 11) {
                          return 'Informe apenas digitos DDDNumero. exemplo: 11912345678';
                        }
                        return null;
                      },
                    ),
                    // validator: Validatorless.min(11,
                    //     'Informe apenas digitos DDDNumero. exemplo: 11912345678')),
                    Text('Endereço'),
                    TextFormField(
                      controller: _addressTec,
                    ),
                    Text('CEP'),
                    TextFormField(
                      controller: _cepTec,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 8) {
                          return 'Informe apenas digitos DDDNumero. exemplo: 12123123';
                        }
                        return null;
                      },
                    ),
                    Text('Sua comunidade'),
                    Container(
                      // margin: EdgeInsets.all(10),
                      width: 300,
                      // height: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Obx(
                        () => DropdownButton<String>(
                          value: widget._userController.communitySelected!.id,
                          onChanged: (String? newValue) {
                            print(newValue);
                            widget._userController.setCommunity(newValue!);
                          },
                          items: widget._userController.communityList
                              .map<DropdownMenuItem<String>>(
                            (CommunityRef community) {
                              return DropdownMenuItem<String>(
                                value: community.id,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${community.state}-${community.city}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Text('${community.name}'),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                          iconSize: 36,
                          isExpanded: true,
                          // icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          // style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Confirmar'),
                onPressed: () {
                  print('validando...');
                  // final formValid = _formKey.currentState?.validate() ?? false;
                  if (_formKey.currentState!.validate()) {
                    widget._userController.onRegister(
                        cellPhone: _cellPhoneTec.text,
                        address: _addressTec.text,
                        cep: _cepTec.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
