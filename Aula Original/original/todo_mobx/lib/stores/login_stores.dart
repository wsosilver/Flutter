import 'package:mobx/mobx.dart';


part 'login_stores.g.dart';

class LoginStore = _LoginStore with _$LoginStore;


abstract class _LoginStore with Store{

  _LoginStore(){
   autorun((_){
     print(email);
   });
  }

  @observable
  bool loading = false;

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool showPassword = true;

  @observable
  bool loggedIn = false;

  @action
  Future<void> acLoading() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    loggedIn = true;
  }



  @action
  void funcShowPass() => showPassword = !showPassword;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get validationEmail => email.length >= 6;

  @computed
  bool get validationPassword => password.length >= 6;

  @computed
  bool get isValidation => validationEmail && validationPassword;

  @computed
  bool get validationShowPassword => showPassword == true;
}