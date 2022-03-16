import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController with LoaderMixin, MessageMixin {
  final AuthController _authController;
  final UserRepository _userRepository;
  final CommunityRepository _communityRepository;
  UserController({
    required AuthController authController,
    required UserRepository userRepository,
    required CommunityRepository communityRepository,
  })  : _authController = authController,
        _userRepository = userRepository,
        _communityRepository = communityRepository;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  User? get userAuth => _authController.user;

  Rxn<UserModel> _userModel = Rxn<UserModel>();
  UserModel? get userModel => _userModel.value;

  var collectAdditionalInformation = false.obs;

  Rxn<CommunityRef> _communitySelected = Rxn<CommunityRef>();
  CommunityRef? get communitySelected => _communitySelected.value;
  var _communityList = <CommunityRef>[].obs;
  List<CommunityRef> get communityList => _communityList;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
    await loadCommunityList();
    await getUser();
  }

  Future<void> getUser() async {
    try {
      print('UserController');
      print('userUid: ${userAuth!.uid}');
      var userModel;
      try {
        userModel = await _userRepository.getByUid(userAuth!.uid);
      } on UserException catch (e) {
        _message.value = MessageModel(
          title: 'Erro',
          message: e.message,
          isError: true,
        );
      }
      if (userModel == null) {
        // await getInfo();
        collectAdditionalInformation(true);
        print('Usuario nao cadastrado aguardando informações complementares.');
      } else {
        _userModel(userModel);
        print('home');
        Get.offAllNamed(Routes.home);
      }
    } on UserException catch (e) {
      print('Erro em user exception');
      print(e.message);
    } catch (e) {
      print('Erro geral em _userRepository.getByuid(${userAuth!.uid})');
      print(e);
    }
  }

  Future<void> loadCommunityList() async {
    print('CommunityRef');
    try {
      var communityList = await _communityRepository.getAll();
      _communityList(communityList);
      setCommunity(null);
      print(communityList);
    } on CommunityException catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: e.message,
        isError: true,
      );
    }
  }

  void setCommunity(String? id) {
    var communitySelected;
    if (id == null) {
      communitySelected = _communityList.first;
    } else {
      communitySelected = _communityList.where((value) => value.id == id).first;
    }
    _communitySelected(communitySelected);
  }

  Future<UserModel> createUser(Map<String, dynamic> data) async {
    print("Usuario nao encontrado. Criando..");
    data['uid'] = userAuth?.uid ?? '';
    data['email'] = userAuth?.email ?? '';
    data['displayName'] = userAuth?.displayName ?? 'Sem nome.';
    data['photoUrl'] = userAuth?.photoURL ?? '';
    data['level'] = ['buys'];
    data['createdAt'] = DateTime.now();
    data['isActive'] = true;
    print(data);

    try {
      var userModel = await _userRepository.create(data);
      return userModel;
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Nao consegui criar UserModel',
        isError: true,
      );
      rethrow;
    }
  }

  void logout() async {
    _authController.logout();
  }

  void onRegister({
    required String cellPhone,
    required String address,
    required String cep,
  }) async {
    collectAdditionalInformation(false);

    Map<String, dynamic> data = {};
    data['cellPhone'] = cellPhone;
    data['address'] = address;
    data['cep'] = cep;
    data['communityRefList'] = [communitySelected!.toMap()];
    print(data);
    var userModel = await createUser(data);
    _userModel(userModel);
    print('home');
    Get.offAllNamed(Routes.home);
  }

  void includeDoing(bool? value) {}
}
