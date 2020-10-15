// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrinho_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarrinhoMobx on _CarrinhoMobx, Store {
  Computed<double> _$getDescontoComputed;

  @override
  double get getDesconto =>
      (_$getDescontoComputed ??= Computed<double>(() => super.getDesconto,
              name: '_CarrinhoMobx.getDesconto'))
          .value;
  Computed<double> _$getEntregaComputed;

  @override
  double get getEntrega =>
      (_$getEntregaComputed ??= Computed<double>(() => super.getEntrega,
              name: '_CarrinhoMobx.getEntrega'))
          .value;
  Computed<double> _$getSubtotalComputed;

  @override
  double get getSubtotal =>
      (_$getSubtotalComputed ??= Computed<double>(() => super.getSubtotal,
              name: '_CarrinhoMobx.getSubtotal'))
          .value;
  Computed<double> _$getTotalComputed;

  @override
  double get getTotal =>
      (_$getTotalComputed ??= Computed<double>(() => super.getTotal,
              name: '_CarrinhoMobx.getTotal'))
          .value;
  Computed<bool> _$getIsLoadingComputed;

  @override
  bool get getIsLoading =>
      (_$getIsLoadingComputed ??= Computed<bool>(() => super.getIsLoading,
              name: '_CarrinhoMobx.getIsLoading'))
          .value;

  final _$pedidoValidoAtom = Atom(name: '_CarrinhoMobx.pedidoValido');

  @override
  bool get pedidoValido {
    _$pedidoValidoAtom.reportRead();
    return super.pedidoValido;
  }

  @override
  set pedidoValido(bool value) {
    _$pedidoValidoAtom.reportWrite(value, super.pedidoValido, () {
      super.pedidoValido = value;
    });
  }

  final _$statusAtom = Atom(name: '_CarrinhoMobx.status');

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$updatePrecoAtom = Atom(name: '_CarrinhoMobx.updatePreco');

  @override
  bool get updatePreco {
    _$updatePrecoAtom.reportRead();
    return super.updatePreco;
  }

  @override
  set updatePreco(bool value) {
    _$updatePrecoAtom.reportWrite(value, super.updatePreco, () {
      super.updatePreco = value;
    });
  }

  final _$listProdutosCarrinhoAtom =
      Atom(name: '_CarrinhoMobx.listProdutosCarrinho');

  @override
  ObservableList<ProdutoCarrinho> get listProdutosCarrinho {
    _$listProdutosCarrinhoAtom.reportRead();
    return super.listProdutosCarrinho;
  }

  @override
  set listProdutosCarrinho(ObservableList<ProdutoCarrinho> value) {
    _$listProdutosCarrinhoAtom.reportWrite(value, super.listProdutosCarrinho,
        () {
      super.listProdutosCarrinho = value;
    });
  }

  final _$userAtom = Atom(name: '_CarrinhoMobx.user');

  @override
  UserMobx get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserMobx value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$descontoAtom = Atom(name: '_CarrinhoMobx.desconto');

  @override
  double get desconto {
    _$descontoAtom.reportRead();
    return super.desconto;
  }

  @override
  set desconto(double value) {
    _$descontoAtom.reportWrite(value, super.desconto, () {
      super.desconto = value;
    });
  }

  final _$entregaAtom = Atom(name: '_CarrinhoMobx.entrega');

  @override
  double get entrega {
    _$entregaAtom.reportRead();
    return super.entrega;
  }

  @override
  set entrega(double value) {
    _$entregaAtom.reportWrite(value, super.entrega, () {
      super.entrega = value;
    });
  }

  final _$subtotalAtom = Atom(name: '_CarrinhoMobx.subtotal');

  @override
  double get subtotal {
    _$subtotalAtom.reportRead();
    return super.subtotal;
  }

  @override
  set subtotal(double value) {
    _$subtotalAtom.reportWrite(value, super.subtotal, () {
      super.subtotal = value;
    });
  }

  final _$totalAtom = Atom(name: '_CarrinhoMobx.total');

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_CarrinhoMobx.isLoading');

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

  final _$finalizarPedidoAsyncAction =
      AsyncAction('_CarrinhoMobx.finalizarPedido');

  @override
  Future<String> finalizarPedido(Map<dynamic, dynamic> endereco) {
    return _$finalizarPedidoAsyncAction
        .run(() => super.finalizarPedido(endereco));
  }

  final _$_loadItensCarrinhoAsyncAction =
      AsyncAction('_CarrinhoMobx._loadItensCarrinho');

  @override
  Future<void> _loadItensCarrinho() {
    return _$_loadItensCarrinhoAsyncAction
        .run(() => super._loadItensCarrinho());
  }

  final _$_CarrinhoMobxActionController =
      ActionController(name: '_CarrinhoMobx');

  @override
  dynamic validarPedido(ProdutoCarrinho produtoCarrinho) {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.validarPedido');
    try {
      return super.validarPedido(produtoCarrinho);
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatus() {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.setStatus');
    try {
      return super.setStatus();
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDesconto() {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.setDesconto');
    try {
      return super.setDesconto();
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void salvarCupom(String cupomCodigo, int porcentagemDesconto) {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.salvarCupom');
    try {
      return super.salvarCupom(cupomCodigo, porcentagemDesconto);
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTotal() {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.setTotal');
    try {
      return super.setTotal();
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleIsLoading() {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.toggleIsLoading');
    try {
      return super.toggleIsLoading();
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProduto(ProdutoCarrinho produto) {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.addProduto');
    try {
      return super.addProduto(produto);
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerProduto(ProdutoCarrinho produto) {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.removerProduto');
    try {
      return super.removerProduto(produto);
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void quantidadeProduto(ProdutoCarrinho produtoCarrinho, int quantidade) {
    final _$actionInfo = _$_CarrinhoMobxActionController.startAction(
        name: '_CarrinhoMobx.quantidadeProduto');
    try {
      return super.quantidadeProduto(produtoCarrinho, quantidade);
    } finally {
      _$_CarrinhoMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pedidoValido: $pedidoValido,
status: $status,
updatePreco: $updatePreco,
listProdutosCarrinho: $listProdutosCarrinho,
user: $user,
desconto: $desconto,
entrega: $entrega,
subtotal: $subtotal,
total: $total,
isLoading: $isLoading,
getDesconto: $getDesconto,
getEntrega: $getEntrega,
getSubtotal: $getSubtotal,
getTotal: $getTotal,
getIsLoading: $getIsLoading
    ''';
  }
}
