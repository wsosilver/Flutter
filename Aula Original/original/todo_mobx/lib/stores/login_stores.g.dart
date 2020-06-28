// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_stores.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$validationEmailComputed;

  @override
  bool get validationEmail =>
      (_$validationEmailComputed ??= Computed<bool>(() => super.validationEmail,
              name: '_LoginStore.validationEmail'))
          .value;
  Computed<bool> _$validationPasswordComputed;

  @override
  bool get validationPassword => (_$validationPasswordComputed ??=
          Computed<bool>(() => super.validationPassword,
              name: '_LoginStore.validationPassword'))
      .value;
  Computed<bool> _$isValidationComputed;

  @override
  bool get isValidation =>
      (_$isValidationComputed ??= Computed<bool>(() => super.isValidation,
              name: '_LoginStore.isValidation'))
          .value;
  Computed<bool> _$validationShowPasswordComputed;

  @override
  bool get validationShowPassword => (_$validationShowPasswordComputed ??=
          Computed<bool>(() => super.validationShowPassword,
              name: '_LoginStore.validationShowPassword'))
      .value;

  final _$loadingAtom = Atom(name: '_LoginStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$emailAtom = Atom(name: '_LoginStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$showPasswordAtom = Atom(name: '_LoginStore.showPassword');

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  final _$loggedInAtom = Atom(name: '_LoginStore.loggedIn');

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  final _$acLoadingAsyncAction = AsyncAction('_LoginStore.acLoading');

  @override
  Future<void> acLoading() {
    return _$acLoadingAsyncAction.run(() => super.acLoading());
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void funcShowPass() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.funcShowPass');
    try {
      return super.funcShowPass();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
email: ${email},
password: ${password},
showPassword: ${showPassword},
loggedIn: ${loggedIn},
validationEmail: ${validationEmail},
validationPassword: ${validationPassword},
isValidation: ${isValidation},
validationShowPassword: ${validationShowPassword}
    ''';
  }
}
