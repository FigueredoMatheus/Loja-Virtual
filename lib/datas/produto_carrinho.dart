//Carrinho conterá instâncias dessa classe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual2/datas/produto_data.dart';

class ProdutoCarrinho{
  String idCarrinho; //Id do produto no carrinho
  //String categoria; //Chocolate, Morango, etc
  String idProduto; //Id do produto dentro da categoria
  int quantProdutos; //Quantidade de produtos que o usuario irá comprar
  int indexMedidaPreco; //Indice de medida escolhida
  //String medida; //Medida escolhida 50g, 100g
  ProdutoData produtoData; //Dados do produto

  ProdutoCarrinho();

  ProdutoCarrinho.fromDocument(DocumentSnapshot documentSnapshot){
    idCarrinho = documentSnapshot['idCarrinho'];
   // categoria = documentSnapshot['categoria'];
    idProduto = documentSnapshot['idProduto'];
    quantProdutos = documentSnapshot['quantProdutos'];
//    medida = documentSnapshot['medida'];
    indexMedidaPreco = documentSnapshot['indexMedidaPreco'];
  }

  Map<String, dynamic> toMap(){
    return{
      //'categoria' : categoria,
      'idProduto' : idProduto,
      'quantProdutos' : quantProdutos,
      //'medida' : medida,
      'indexMedidaPreco' : indexMedidaPreco,
      'produto' : produtoData.toResumeMap(indexMedidaPreco),
    };
  }
}