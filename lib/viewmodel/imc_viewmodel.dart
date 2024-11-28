import 'package:flutter/material.dart';

import 'package:imc_mvvm/repositories/user_repository.dart';

class ImcViewModel with ChangeNotifier {
  final UserRepository userRepository;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  ImcViewModel({required this.userRepository});

  double? imc;
  String? imcInfo;

  void setUserDataFromControllers() {
    // obtendo os valores dos controladores
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);

    // passando os dados para o repositório
    userRepository.setUserData(height, weight);
  }

  void calculateImc() {
    imc = userRepository.getUserImc();
    imcInfo = userRepository.getUserInfo();
    
    notifyListeners();
  }

  void clearData() {
    userRepository.clearUserData();
    imc = null;
    imcInfo = null;

    heightController.clear();
    weightController.clear();

    notifyListeners();
  }
}
