// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endereco.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Endereco on _EnderecoBase, Store {
  final _$listEnderecosAtom = Atom(name: '_EnderecoBase.listEnderecos');

  @override
  ObservableList<Map<dynamic, dynamic>> get listEnderecos {
    _$listEnderecosAtom.reportRead();
    return super.listEnderecos;
  }

  @override
  set listEnderecos(ObservableList<Map<dynamic, dynamic>> value) {
    _$listEnderecosAtom.reportWrite(value, super.listEnderecos, () {
      super.listEnderecos = value;
    });
  }

  final _$enderecoEscolhidooAtom =
      Atom(name: '_EnderecoBase.enderecoEscolhidoo');

  @override
  Map<dynamic, dynamic> get enderecoEscolhidoo {
    _$enderecoEscolhidooAtom.reportRead();
    return super.enderecoEscolhidoo;
  }

  @override
  set enderecoEscolhidoo(Map<dynamic, dynamic> value) {
    _$enderecoEscolhidooAtom.reportWrite(value, super.enderecoEscolhidoo, () {
      super.enderecoEscolhidoo = value;
    });
  }

  final _$_loadEnderecosAsyncAction =
      AsyncAction('_EnderecoBase._loadEnderecos');

  @override
  Future<void> _loadEnderecos(FirebaseUser user) {
    return _$_loadEnderecosAsyncAction.run(() => super._loadEnderecos(user));
  }

  final _$excluirEnderecoAsyncAction =
      AsyncAction('_EnderecoBase.excluirEndereco');

  @override
  Future<void> excluirEndereco(Map<dynamic, dynamic> endereco) {
    return _$excluirEnderecoAsyncAction
        .run(() => super.excluirEndereco(endereco));
  }

  final _$_EnderecoBaseActionController =
      ActionController(name: '_EnderecoBase');

  @override
  void adicionarEndereco(
      {@required String rua,
      @required String bairro,
      @required String cidade,
      @required String estado,
      @required String numero,
      @required String cep,
      @required bool padrao,
      String complemento}) {
    final _$actionInfo = _$_EnderecoBaseActionController.startAction(
        name: '_EnderecoBase.adicionarEndereco');
    try {
      return super.adicionarEndereco(
          rua: rua,
          bairro: bairro,
          cidade: cidade,
          estado: estado,
          numero: numero,
          cep: cep,
          padrao: padrao,
          complemento: complemento);
    } finally {
      _$_EnderecoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editarEndereco(Map<dynamic, dynamic> endereco) {
    final _$actionInfo = _$_EnderecoBaseActionController.startAction(
        name: '_EnderecoBase.editarEndereco');
    try {
      return super.editarEndereco(endereco);
    } finally {
      _$_EnderecoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void definirPadrao(Map<dynamic, dynamic> endereco) {
    final _$actionInfo = _$_EnderecoBaseActionController.startAction(
        name: '_EnderecoBase.definirPadrao');
    try {
      return super.definirPadrao(endereco);
    } finally {
      _$_EnderecoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerPadrao(Map<dynamic, dynamic> endereco) {
    final _$actionInfo = _$_EnderecoBaseActionController.startAction(
        name: '_EnderecoBase.removerPadrao');
    try {
      return super.removerPadrao(endereco);
    } finally {
      _$_EnderecoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetEnderecoCarrinho() {
    final _$actionInfo = _$_EnderecoBaseActionController.startAction(
        name: '_EnderecoBase.resetEnderecoCarrinho');
    try {
      return super.resetEnderecoCarrinho();
    } finally {
      _$_EnderecoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listEnderecos: $listEnderecos,
enderecoEscolhidoo: $enderecoEscolhidoo
    ''';
  }
}
