import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/datas/produto_carrinho.dart';
import 'package:lojavirtual2/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoModel extends Model{

  List<ProdutoCarrinho> listProdutosCarrinho = []; //Lista de produtos no carrinho
  UserModel user; //Usuário atual
  bool isLoading = false;

  String cupomCodigo;
  int porcentagemDesconto = 0;

  CarrinhoModel(this.user){
    if(user.isLoggedIn()){
      _loadItensCarrinho();
    }
  }

  static CarrinhoModel of(BuildContext context) =>
      ScopedModel.of<CarrinhoModel>(context);
  
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

    notifyListeners();
  }

  Future<String> finalizarPedido() async {
    if(listProdutosCarrinho.length == 0)  return null;

    isLoading = true;
    notifyListeners();

    double subtotal = getSubtotal();
    double desconto = getDesconto();
    double entrega = getEntrega();

    DocumentReference documentReference = await Firestore.instance.collection('pedidos').add(
      {
        'subtotal' : subtotal,
        'desconto' : desconto,
        'entrega' : entrega,
        'total' : subtotal + entrega - desconto,
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

    isLoading = false;
    notifyListeners();

    return documentReference.documentID;

  }
  
  void removerProduto(ProdutoCarrinho produto){
    listProdutosCarrinho.remove(produto);

    Firestore.instance.collection('users').document(user.firebaseUser.uid)
      .collection('carrinho').document(produto.idCarrinho).delete();

    notifyListeners();
  }
  
  void decProduto(ProdutoCarrinho produtoCarrinho){
    produtoCarrinho.quantProdutos--;
    
    Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('carrinho').document(produtoCarrinho.idCarrinho)
        .updateData(produtoCarrinho.toMap());
    notifyListeners();
  }

  void incProduto(ProdutoCarrinho produtoCarrinho){
    produtoCarrinho.quantProdutos++;

    Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('carrinho').document(produtoCarrinho.idCarrinho)
        .updateData(produtoCarrinho.toMap());
    notifyListeners();
  }

  void setCupom(String cupomCodigo, int porcentagemDesconto){
    this.cupomCodigo = cupomCodigo;
    this.porcentagemDesconto = porcentagemDesconto;
  }

  void _loadItensCarrinho() async{

    QuerySnapshot querySnapshot = await Firestore.instance.collection('users')
        .document(user.firebaseUser.uid).collection('carrinho').getDocuments();

    listProdutosCarrinho = querySnapshot.documents.map((document) =>
        ProdutoCarrinho.fromDocument(document)).toList();
    notifyListeners();
  }

  void updatePrecos(){
    notifyListeners();
  }

  double getSubtotal(){
    double preco = 0.0;

    for(ProdutoCarrinho c in listProdutosCarrinho){
      if(c.produtoData != null){
        preco += c.quantProdutos * c.produtoData.preco[c.indexMedidaPreco];
      }
    }
    return preco;
  }

  double getDesconto(){

    return getSubtotal() * porcentagemDesconto / 100;
  }

  double getEntrega(){
    return 2.0;
  }
  
}