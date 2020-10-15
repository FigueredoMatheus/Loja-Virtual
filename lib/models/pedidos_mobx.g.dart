// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedidos_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidosMobx on _PedidosMobxBase, Store {
  final _$listPedidosAtom = Atom(name: '_PedidosMobxBase.listPedidos');

  @override
  ObservableList<String> get listPedidos {
    _$listPedidosAtom.reportRead();
    return super.listPedidos;
  }

  @override
  set listPedidos(ObservableList<String> value) {
    _$listPedidosAtom.reportWrite(value, super.listPedidos, () {
      super.listPedidos = value;
    });
  }

  final _$_PedidosMobxBaseActionController =
      ActionController(name: '_PedidosMobxBase');

  @override
  void add(String doc) {
    final _$actionInfo = _$_PedidosMobxBaseActionController.startAction(
        name: '_PedidosMobxBase.add');
    try {
      return super.add(doc);
    } finally {
      _$_PedidosMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remover(String doc, FirebaseUser user) {
    final _$actionInfo = _$_PedidosMobxBaseActionController.startAction(
        name: '_PedidosMobxBase.remover');
    try {
      return super.remover(doc, user);
    } finally {
      _$_PedidosMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listPedidos: $listPedidos
    ''';
  }
}
