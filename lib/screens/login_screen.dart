import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/generics_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/screens/register_screen.dart';
import 'package:lojavirtual2/widgets/custom_icon.dart';
import 'package:lojavirtual2/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    UserMobx user = Provider.of<UserMobx>(context);
    GenericsMobx genericsMobx = GenericsMobx();

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Entrar"),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterScreen())
                  );
                },
                child: Text(
                  "CRIAR CONTA",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                textColor: Colors.white70,
              ),
            ],
          ),
          //backgroundColor: Colors.deepPurpleAccent,
          body: Observer(
            builder: (_){
              return user.getIsLoading ? Center(child: CircularProgressIndicator())
                  : Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: Card(
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          CustomTextField(
                            controller: emailController,
                            prefix: Icon(Icons.account_circle),
                            hint: "E-mail",
                            textInputType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 16.0),

                          Observer(
                            builder: (_){
                              return CustomTextField(
                                controller: senhaController,
                                prefix: Icon(Icons.lock),
                                suffix: CustomIconButton(
                                  radius: 32,
                                  iconData: !genericsMobx.genericBool ? Icons.visibility
                                      : Icons.visibility_off,
                                  onTap: genericsMobx.toggleGenericBool,
                                ),
                                hint: "Senha",
                                textInputType: TextInputType.text,
                                obscure: !genericsMobx.genericBool,
                                //onChanged: (senha) {},
                              );
                            },
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () {
                                if (emailController.text.isEmpty) {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(
                                        "Insira seu email para recuperar a senha"),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ));
                                } else {
                                  user.recuperarSenha(emailController.text);
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text("Email de recuperação enviado!"),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ));
                                }
                              },
                              child: Text(
                                "Esqueci minha senha",
                              ),
                              //FlatButton por padrão tem um padding
                              padding: EdgeInsets.zero,
                            ),
                          ),

                          const SizedBox(height: 16.0,),

                          SizedBox(
                            height: 44,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Text("Entrar"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: (){
                                user.logar(
                                    email: emailController.text,
                                    senha: senhaController.text,
                                    onSucess: _onSucess,
                                    onFail: _onFail,
                                    onFailVerified: _onFailVerified
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            },
          )


      ),
    );
  }

  void _onSucess() {
    Navigator.of(context).pop();
  }

  void _onFailVerified() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("E-mail não verificado!"),
            //Conteúdo
            content: Text(""),
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

  void _onFail() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("E-mail ou senha inválido!"),
            //Conteúdo
            content: Text("Verifique os dados inseridos."),
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

/*
 appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterScreen())
                );
              },
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              textColor: Colors.white70,
            ),
          ],
        ),
        //Assim é possível acessar o estado do usuário
        //Podendoverificar o estado do model
        //Obetendo acesso ao usuário atual
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            //Formulário para valiar os campos
            return  Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty) return "Insira seu e-mail";
                    },
                  ),
                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: senhaController,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty) return "Insira sua senha";
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: (){
                        if(emailController.text.isEmpty){
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Insira seu email para recuperar a senha"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              )
                          );
                        }else {
                          model.recuperarSenha(emailController.text);
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Email de recuperação enviado!"),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              )
                          );

                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                      ),
                      //FlatButton por padrão tem um padding
                      padding: EdgeInsets.zero,
                    ),
                  ),

                  SizedBox(height: 14.0,),

                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){}
                        model.logar(
                            email: emailController.text,
                            senha: senhaController.text,
                            onSucess: _onSucess,
                            onFail: _onFail,
                            onFailVerified: _onFailVerified
                        );
                      },
                      color:Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text("Entrar"),
                    ),
                  ),
                ],
              ),
            );
          },
        )
 */
