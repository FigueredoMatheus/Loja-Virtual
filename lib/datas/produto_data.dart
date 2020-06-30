import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoData {
  String categoria;
  String id;
  String title;
  String descricao;

  List preco;
  List images;
  List medida;

  //Pegando o documento do Firebase e passando para os atributos
  ProdutoData.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.documentID;
    title = documentSnapshot.data['title'];
    descricao = documentSnapshot.data['descricao'];
    preco = documentSnapshot.data['preco'];
    images = documentSnapshot.data['images'];
    medida = documentSnapshot.data['medida'];
  }

  Map<String, dynamic> toResumeMap(int precoIndex){
    return {
      'title' : title,
      'descricao' : descricao,
      'preco' : preco[precoIndex],
      'medida': medida[precoIndex],
    };
  }
}

