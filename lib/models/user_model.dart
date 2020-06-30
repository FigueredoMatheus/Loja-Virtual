import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

//Para o ScopedModel funcionar em todo o App, é necessário coloca-lo na main primeiro
//O estado atual do usuario será influenciado por todo o App
class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();
  bool isLoading = false;
  
  //Como utilizar os métodos do Model sem precisar do Decendent
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);
  
  //Quando o aplicativo abrir, se ja tiver um user logado
  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void logar({@required String email, @required String senha,
    @required VoidCallback onSucess, @required VoidCallback onFail,
    @required VoidCallback onFailVerified}){

    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: senha)
        .then((user) async {
          if(user.isEmailVerified) {
            firebaseUser = user;

            await _loadCurrentUser();

            onSucess();
          }else{
            onFailVerified();
          }
            isLoading = false;
            notifyListeners();

    }).catchError((e){
        isLoading = false;
        onFail();
        notifyListeners();
    });

  }
  //Colocando com opcional apenas para facilitar na hr de chamar essa função
  //@required marca esse campo como obrigatório
  void registrar({@required Map<String, dynamic> userData, @required String senha,
    @required VoidCallback onSucess, @required VoidCallback onFail}){

    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData['email'],
      password: senha,
        //Retorna um usuário
    ).then((user) async{

        await Firestore.instance.collection('users').document(user.uid).setData(userData);

        onSucess();
        isLoading = false;
        notifyListeners();
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void changeNome(String nome){
    Firestore.instance.collection('users').document(firebaseUser.uid)
      .updateData(
      {
        'nome' : nome,
      }
    );

    notifyListeners();
  }
  void changeEmail(String email){
      firebaseUser.updateEmail(email);
      notifyListeners();
  }

  void changeSenha(String senha){
    firebaseUser.updatePassword(senha);

  }

  Future<String> userName()async {
    DocumentSnapshot userDoc =  await Firestore.instance.collection('users')
        .document(firebaseUser.uid).get();

    String x = userDoc.data['nome'];
    return x;
  }

  Future<String> userEmail() async{
    DocumentSnapshot userDoc = await Firestore.instance.collection('users')
        .document(firebaseUser.uid).get();

    return userDoc.data['email'];
  }

  dynamic userEndereco() async{
    DocumentSnapshot userDoc = await Firestore.instance.collection('users')
        .document(firebaseUser.uid).get();

    return userDoc.data['endereco'];
  }

  void sair() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recuperarSenha(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _loadCurrentUser() async{
    if(firebaseUser == null){
      firebaseUser = await _auth.currentUser();
    }

    if(firebaseUser != null){
      if(userData['nome'] == null){
        DocumentSnapshot docUser = await Firestore.instance.collection('users')
            .document(firebaseUser.uid).get();
        userData = docUser.data;
      }

    }
    notifyListeners();
  }

  bool isEmailVerified(FirebaseUser user){
    return user.isEmailVerified;
  }


}