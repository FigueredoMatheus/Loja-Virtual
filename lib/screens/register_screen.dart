import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final cofirmarSenhaController = TextEditingController();
  final enderecoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    UserMobx user = Provider.of<UserMobx>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        //Formulário para valiar os campos
        body: Observer(
          builder: (_){
            return user.getIsLoading ? Center(child: CircularProgressIndicator(),)
                : Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      hintText: "Nome Completo",
                    ),
                    keyboardType: TextInputType.text,
                    validator: (text){
                      if(text.isEmpty) return "Insira seu nome";

                      return null;
                    },
                  ),

                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty)
                        return "Insira seu e-mail";
                      if(!text.contains("@") && !text.contains(".com"))
                        return "E-mail inválido.";

                      return null;
                    },
                  ),

                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: senhaController,
                    decoration: InputDecoration(
                      hintText: "Senha (mínimo 6 caracteres)",
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty) return "Insira sua senha";
                      if(text.length < 6) return "Senha muito curta";
                      if(senhaController.text != cofirmarSenhaController.text)
                        return 'As senhas devem ser iguais.';

                      return null;
                    },
                  ),

                  SizedBox(height: 14.0,),

                  TextFormField(
                    controller: cofirmarSenhaController,
                    decoration: InputDecoration(
                      hintText: "Confirme a senha",
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (text){
                      if(senhaController.text != cofirmarSenhaController.text)
                        return 'As senhas devem ser iguais';

                      return null;
                    },
                  ),

                  //  SizedBox(height: 14.0,),

                  /*
                  TextFormField(
                    controller: enderecoController,
                    decoration: InputDecoration(
                      hintText: "Endereço",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty) return "Insira seu endereço";
                    },
                  ),

                   */
                  SizedBox(height: 16.0),

                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            'nome': nomeController.text,
                            'email': emailController.text,
                            //'endereco': enderecoController.text
                          };

                          user.registrar(
                              userData: userData,
                              senha: senhaController.text,
                              onSucess: _onSucess,
                              onFail: _onFail
                          );
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text("Criar Conta"),
                      textColor: Colors.white,
                    ),
                  ),

                ],
              ),
            );
          },
        ),
            );
  }
  //Mostrar uma barra de criação com sucesso e fechar a pagina de registrar
  void _onSucess(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Cadastro realizado com sucesso!"),
        //Conteúdo
        content: Text("E-mail de verificação enviado."),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            //Saindo do Dialog e do ContatoPage
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }
  void _onFail(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("E-mail inválido!"),
        //Conteúdo
        content: Text("E-mail já está cadastrado ou\ne-mail inexistente."),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            //Saindo do Dialog e do ContatoPage
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }
}

