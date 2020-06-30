import 'package:flutter/material.dart';

//A configurações dos botões do Drawer
class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final int page; //Para saber qual página corresponde a qual botão
  final PageController pageController;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    //Quando o icone for pressionado, terá um efeito visual
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          //Fechando o Drawer quando clicar no botão
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        //Delimitar a area de cada icone
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                //Como pageController.page retorna um double, coloca-se pra arredondar para int
                color: pageController.page.round() == page ? Color.fromARGB(240, 255, 122, 173) :
                    Colors.white70
              ),
              //Dando um espaço entre o icone e o texto
              SizedBox(
                width: 32.0,
              ),

              Text(
                text,
                style: TextStyle(fontSize: 16.0, color: pageController.page.round() == page ? Color.fromARGB(240, 255, 122, 173) :
                Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
