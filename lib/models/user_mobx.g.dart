// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserMobx on _UserMobx, Store {
  Computed<bool> _$getIsLoadingComputed;

  @override
  bool get getIsLoading =>
      (_$getIsLoadingComputed ??= Computed<bool>(() => super.getIsLoading,
              name: '_UserMobx.getIsLoading'))
          .value;
  Computed<bool> _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
          Computed<bool>(() => super.isLoggedIn, name: '_UserMobx.isLoggedIn'))
      .value;
  Computed<String> _$userNomeComputed;

  @override
  String get userNome => (_$userNomeComputed ??=
          Computed<String>(() => super.userNome, name: '_UserMobx.userNome'))
      .value;

  final _$pedidosAtom = Atom(name: '_UserMobx.pedidos');

  @override
  PedidosMobx get pedidos {
    _$pedidosAtom.reportRead();
    return super.pedidos;
  }

  @override
  set pedidos(PedidosMobx value) {
    _$pedidosAtom.reportWrite(value, super.pedidos, () {
      super.pedidos = value;
    });
  }

  final _$enderecoAtom = Atom(name: '_UserMobx.endereco');

  @override
  Endereco get endereco {
    _$enderecoAtom.reportRead();
    return super.endereco;
  }

  @override
  set endereco(Endereco value) {
    _$enderecoAtom.reportWrite(value, super.endereco, () {
      super.endereco = value;
    });
  }

  final _$_authAtom = Atom(name: '_UserMobx._auth');

  @override
  FirebaseAuth get _auth {
    _$_authAtom.reportRead();
    return super._auth;
  }

  @override
  set _auth(FirebaseAuth value) {
    _$_authAtom.reportWrite(value, super._auth, () {
      super._auth = value;
    });
  }

  final _$firebaseUserAtom = Atom(name: '_UserMobx.firebaseUser');

  @override
  FirebaseUser get firebaseUser {
    _$firebaseUserAtom.reportRead();
    return super.firebaseUser;
  }

  @override
  set firebaseUser(FirebaseUser value) {
    _$firebaseUserAtom.reportWrite(value, super.firebaseUser, () {
      super.firebaseUser = value;
    });
  }

  final _$userDataAtom = Atom(name: '_UserMobx.userData');

  @override
  ObservableMap<String, dynamic> get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(ObservableMap<String, dynamic> value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_UserMobx.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$sairAsyncAction = AsyncAction('_UserMobx.sair');

  @override
  Future<void> sair() {
    return _$sairAsyncAction.run(() => super.sair());
  }

  final _$_loadCurrentUserAsyncAction =
      AsyncAction('_UserMobx._loadCurrentUser');

  @override
  Future<Null> _loadCurrentUser() {
    return _$_loadCurrentUserAsyncAction.run(() => super._loadCurrentUser());
  }

  final _$changeNomeAsyncAction = AsyncAction('_UserMobx.changeNome');

  @override
  Future<void> changeNome(String nome) {
    return _$changeNomeAsyncAction.run(() => super.changeNome(nome));
  }

  final _$_UserMobxActionController = ActionController(name: '_UserMobx');

  @override
  dynamic toggleLoading() {
    final _$actionInfo = _$_UserMobxActionController.startAction(
        name: '_UserMobx.toggleLoading');
    try {
      return super.toggleLoading();
    } finally {
      _$_UserMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logar(
      {@required String email,
      @required String senha,
      @required VoidCallback onSucess,
      @required VoidCallback onFail,
      @required VoidCallback onFailVerified}) {
    final _$actionInfo =
        _$_UserMobxActionController.startAction(name: '_UserMobx.logar');
    try {
      return super.logar(
          email: email,
          senha: senha,
          onSucess: onSucess,
          onFail: onFail,
          onFailVerified: onFailVerified);
    } finally {
      _$_UserMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void registrar(
      {@required Map<String, dynamic> userData,
      @required String senha,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {
    final _$actionInfo =
        _$_UserMobxActionController.startAction(name: '_UserMobx.registrar');
    try {
      return super.registrar(
          userData: userData, senha: senha, onSucess: onSucess, onFail: onFail);
    } finally {
      _$_UserMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void recuperarSenha(String email) {
    final _$actionInfo = _$_UserMobxActionController.startAction(
        name: '_UserMobx.recuperarSenha');
    try {
      return super.recuperarSenha(email);
    } finally {
      _$_UserMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pedidos: $pedidos,
endereco: $endereco,
firebaseUser: $firebaseUser,
userData: $userData,
isLoading: $isLoading,
getIsLoading: $getIsLoading,
isLoggedIn: $isLoggedIn,
userNome: $userNome
    ''';
  }
}
