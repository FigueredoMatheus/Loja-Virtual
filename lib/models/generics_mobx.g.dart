// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GenericsMobx on _GenericsMobx, Store {
  Computed<double> _$getPrecoComputed;

  @override
  double get getPreco =>
      (_$getPrecoComputed ??= Computed<double>(() => super.getPreco,
              name: '_GenericsMobx.getPreco'))
          .value;
  Computed<String> _$medidaComputed;

  @override
  String get medida => (_$medidaComputed ??=
          Computed<String>(() => super.medida, name: '_GenericsMobx.medida'))
      .value;

  final _$precoAtom = Atom(name: '_GenericsMobx.preco');

  @override
  double get preco {
    _$precoAtom.reportRead();
    return super.preco;
  }

  @override
  set preco(double value) {
    _$precoAtom.reportWrite(value, super.preco, () {
      super.preco = value;
    });
  }

  final _$genericBoolAtom = Atom(name: '_GenericsMobx.genericBool');

  @override
  bool get genericBool {
    _$genericBoolAtom.reportRead();
    return super.genericBool;
  }

  @override
  set genericBool(bool value) {
    _$genericBoolAtom.reportWrite(value, super.genericBool, () {
      super.genericBool = value;
    });
  }

  final _$medidaOpAtom = Atom(name: '_GenericsMobx.medidaOp');

  @override
  String get medidaOp {
    _$medidaOpAtom.reportRead();
    return super.medidaOp;
  }

  @override
  set medidaOp(String value) {
    _$medidaOpAtom.reportWrite(value, super.medidaOp, () {
      super.medidaOp = value;
    });
  }

  final _$_GenericsMobxActionController =
      ActionController(name: '_GenericsMobx');

  @override
  dynamic precoView(ProdutoData produto) {
    final _$actionInfo = _$_GenericsMobxActionController.startAction(
        name: '_GenericsMobx.precoView');
    try {
      return super.precoView(produto);
    } finally {
      _$_GenericsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMedidaOp(String value) {
    final _$actionInfo = _$_GenericsMobxActionController.startAction(
        name: '_GenericsMobx.setMedidaOp');
    try {
      return super.setMedidaOp(value);
    } finally {
      _$_GenericsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleGenericBool() {
    final _$actionInfo = _$_GenericsMobxActionController.startAction(
        name: '_GenericsMobx.toggleGenericBool');
    try {
      return super.toggleGenericBool();
    } finally {
      _$_GenericsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
preco: ${preco},
genericBool: ${genericBool},
medidaOp: ${medidaOp},
getPreco: ${getPreco},
medida: ${medida}
    ''';
  }
}
