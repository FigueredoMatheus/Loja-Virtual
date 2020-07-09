import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/models/endereco.dart';
import 'package:lojavirtual2/models/pedidos_mobx.dart';
import 'package:mobx/mobx.dart';

//flutter packages pub run build_runner build

part 'user_mobx.g.dart';

class UserMobx = _UserMobx with _$UserMobx;

abstract class _UserMobx extends ChangeNotifier with Store{
  
  @observable
  PedidosMobx pedidos;

  @observable
  Endereco endereco;

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  @observable
  FirebaseAuth _auth = FirebaseAuth.instance;

  @observable
  FirebaseUser firebaseUser;

  @observable
  ObservableMap<String, dynamic> userData = ObservableMap<String, dynamic>();

  @observable
  bool isLoading = false;

  @computed
  bool get getIsLoading => isLoading;

  @action
  toggleLoading() => isLoading = !isLoading;

  @computed
  bool get isLoggedIn => firebaseUser != null;

  @action
  void logar({@required String email, @required String senha,
    @required VoidCallback onSucess, @required VoidCallback onFail,
    @required VoidCallback onFailVerified}){

    toggleLoading();

    _auth.signInWithEmailAndPassword(email: email, password: senha)
        .then((user) async {
      if(user.isEmailVerified) {
        firebaseUser = user;

        await _loadCurrentUser();
        endereco = Endereco(user);
        pedidos = PedidosMobx(user);
        print("Lista de endereços(Logar): ${endereco.listEnderecos.length}");
        print("Lista de pedidos(Logar): ${pedidos.listPedidos.length}");

        onSucess();
        notifyListeners();
      }else{
        onFailVerified();
      }
      toggleLoading();

    }).catchError((e){
      toggleLoading();
      onFail();
      notifyListeners();
    });

  }

  @action
  void registrar({@required Map<String, dynamic> userData, @required String senha,
    @required VoidCallback onSucess, @required VoidCallback onFail}){

    toggleLoading();

    _auth.createUserWithEmailAndPassword(
      email: userData['email'],
      password: senha,
      //Retorna um usuário
    ).then((user) async{

      user.sendEmailVerification();
      await Firestore.instance.collection('users').document(user.uid).setData(userData);

      onSucess();
      toggleLoading();
    }).catchError((e){
      onFail();
      toggleLoading();
    });
  }

  @action
  Future<void> sair() async {
    await _auth.signOut();
    userData = ObservableMap<String, dynamic>();
    firebaseUser = null;
    endereco.listEnderecos.clear();
    pedidos.listPedidos.clear();
    notifyListeners();
  }

  @action
  void recuperarSenha(String email){
    _auth.sendPasswordResetEmail(email: email);
  }
  @computed
  String get userNome => userData['nome'];

  @action
  Future<Null> _loadCurrentUser() async{
    if(firebaseUser == null){
      firebaseUser = await _auth.currentUser().then((user) {
        endereco = Endereco(user);
        pedidos = PedidosMobx(user);
        print("Lista de endereços(CurrentUser): ${endereco.listEnderecos.length}");
        print("Lista de pedidos(CurrentUser): ${pedidos.listPedidos.length}");
        //endereco.loadEnderecos(user);
        //pedidos.loadPedidos(user);  
        return user;
      });
    }
    
    if(firebaseUser != null){
      if(userData['nome'] == null){
        DocumentSnapshot docUser = await Firestore.instance.collection('users')
            .document(firebaseUser.uid).get();

        userData = docUser.data.asObservable();
      }
      notifyListeners();
      //loadEnderecos();
      //pedidos.loadPedidos();
    }
  }

  @action
  Future<void> changeNome(String nome) async{
    userData['nome'] = nome;

    await Firestore.instance.collection('users').document(firebaseUser.uid)
        .updateData(
        {
          'nome' : nome,
        }
    );
  }
   
  
}