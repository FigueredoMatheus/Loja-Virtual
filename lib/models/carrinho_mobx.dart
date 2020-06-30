import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual2/datas/produto_carrinho.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:mobx/mobx.dart';
//flutter packages pub run build_runner build
part 'carrinho_mobx.g.dart';

class CarrinhoMobx = _CarrinhoMobx with _$CarrinhoMobx;

abstract class _CarrinhoMobx extends ChangeNotifier with Store{

  _CarrinhoMobx(this.user){
    if(user.isLoggedIn){
      _loadItensCarrinho();
    }
  }

  @observable
  bool pedidoValido = true;

  @action
  validarPedido(ProdutoCarrinho produtoCarrinho){
    if(produtoCarrinho.quantProdutos == 0)
      pedidoValido = false;
    else
      pedidoValido = true;
  }

  @observable
  bool status = false;

  @action
  void setStatus(){

    if(listProdutosCarrinho.every((element) => element.produtoData != null)){
      status = true;
    }

  }
 
  @observable
  bool updatePreco = false;

  @observable
  ObservableList<ProdutoCarrinho> listProdutosCarrinho =
    ObservableList<ProdutoCarrinho>().asObservable(); //Lista de produtos no carrinho

  @observable
  UserMobx user;


  String cupomCodigo;
  int porcentagemDesconto = 0;

  @observable
  double desconto = 0.0;

  @computed
  double get getDesconto => desconto;

  @action
  setDesconto(){
    desconto = getSubtotal * porcentagemDesconto / 100;
  }

  @action
  void salvarCupom(String cupomCodigo, int porcentagemDesconto){
    this.cupomCodigo = cupomCodigo;
    this.porcentagemDesconto = porcentagemDesconto;
    setDesconto();
    setTotal();
  }

  @observable
  double entrega = 2.0;

  @computed
  double get getEntrega => 2.0;

  
  @observable
  double subtotal = 0.0;

  @computed
  double get getSubtotal => subtotal;

  
  setSubtotal(){
    subtotal = 0.0;
    
    for(ProdutoCarrinho c in listProdutosCarrinho){
      if(c.produtoData != null){
        subtotal += c.quantProdutos * c.produtoData.preco[c.indexMedidaPreco];
      }
    }

    
  }

  @observable
  double total = 0.0;

  @computed
  double get getTotal => total;

  @action
  setTotal(){
    
    setSubtotal();
    setDesconto();

    total = getSubtotal - getDesconto + entrega;
  }

  @observable
  bool isLoading = false;

  @computed
  bool get getIsLoading => isLoading;

  @action
  toggleIsLoading() => isLoading = !isLoading;

  @action
  void addProduto(ProdutoCarrinho produto){
    listProdutosCarrinho.add(produto);
    //Adicionando dados do produto no firebase
    Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('carrinho').add(produto.toMap())
        .then((document) {
      produto.idCarrinho = document.documentID;
      document.updateData({
        'idCarrinho' : document.documentID,
      });
    });

    
    setTotal();
  }

  @action
  void removerProduto(ProdutoCarrinho produto){
    listProdutosCarrinho.remove(produto);
  
    Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('carrinho').document(produto.idCarrinho).delete();

    setTotal();
  }

  @action
  Future<String> finalizarPedido(Map<dynamic, dynamic> endereco) async {
    if(listProdutosCarrinho.length == 0) return null;

    toggleIsLoading();

    DocumentReference documentReference = await Firestore.instance.collection('pedidos').add(
        {
          'endereco': endereco,
          'subtotal' : subtotal,
          'desconto' : desconto,
          'entrega' : entrega,
          'total' : total,
          'clienteId' : user.firebaseUser.uid,
          'status' : 1,
          'produtos' : listProdutosCarrinho.map((produto) => produto.toMap()).toList(),
        }
    );

    await Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('pedidos').document(documentReference.documentID).setData(
        {
          'pedidoId' : documentReference.documentID,
        }
    );

    //Removendo os dados do carrinho
    QuerySnapshot querySnapshot = await Firestore.instance.collection('users')
        .document(user.firebaseUser.uid).collection('carrinho').getDocuments();

    for(DocumentSnapshot doc in querySnapshot.documents){
      doc.reference.delete();
    }

    listProdutosCarrinho.clear();
    cupomCodigo = null;
    porcentagemDesconto = 0;

    toggleIsLoading();

    return documentReference.documentID;
  }

  @action
  void quantidadeProduto(ProdutoCarrinho produtoCarrinho, int quantidade){
    produtoCarrinho.quantProdutos = quantidade;

    Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('carrinho').document(produtoCarrinho.idCarrinho)
        .updateData({'quantProdutos' : quantidade});

    setTotal();
  }

  @action
  Future<void> _loadItensCarrinho() async{

    QuerySnapshot querySnapshot = await Firestore.instance.collection('users')
        .document(user.firebaseUser.uid).collection('carrinho').getDocuments();

    listProdutosCarrinho = querySnapshot.documents.map((document) =>
        ProdutoCarrinho.fromDocument(document)).toList().asObservable();

    //todo Tomar cuidado com isso. Uma vez que esse Provider não é Notifier, vai dar um erro
    notifyListeners();
  }
}
