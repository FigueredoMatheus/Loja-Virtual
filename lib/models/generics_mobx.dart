import 'package:lojavirtual2/datas/produto_data.dart';
import 'package:mobx/mobx.dart';

part 'generics_mobx.g.dart';

class GenericsMobx = _GenericsMobx with _$GenericsMobx;

abstract class _GenericsMobx with Store{

  int indexMedidaPreco = 0;

  @observable
  double preco = 0.0;

  @observable
  bool genericBool = false;

  @observable
  String medidaOp = "";

  @computed
  double get getPreco => preco;

  @computed
  String get medida => medidaOp;

  @action
  precoView(ProdutoData produto) {
    for (indexMedidaPreco = 0;
    indexMedidaPreco < produto.medida.length;
    indexMedidaPreco++) {
      if (medidaOp == produto.medida[indexMedidaPreco]) {
          preco = produto.preco[indexMedidaPreco];
        return getPreco;
      }
    }
  }

  @action
  setMedidaOp(String value) => medidaOp = value;

  @action
  toggleGenericBool() => genericBool = !genericBool;

}