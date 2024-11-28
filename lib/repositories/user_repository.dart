import 'package:imc_mvvm/model/user_model.dart';

class UserRepository {
  // o repositório armazena uma instância de UserModel
  UserModel? user;

  // definindo os dados do usuário
  void setUserData(double? height, double? weight) {

    if (height == null || weight == null) {
      throw ArgumentError("Altura e/ou peso não podem ser nulos.");
    }
    
    user = UserModel(height: height, weight: weight);  //salvando um objeto UserModel
  }

  void clearUserData() {
    user = null; // remove o usuário
  }

  // recuperando os Imc e ImcInfo para a ViewModel
  double? getUserImc()  => user?.getImc();
  String? getUserInfo()  => user?.getImcInfo();
}
