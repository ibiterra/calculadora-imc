import 'package:flutter_test/flutter_test.dart';
import 'package:imc_mvvm/model/user_model.dart';

void main() {
  group('UserModel Tests', () {
    test('Deve calcular o IMC corretamente', () {
      final user = UserModel(height: 1.75, weight: 70.0);
      expect(user.getImc(), 22.86);
    });

    test('Deve lançar erro se a altura for zero ou negativa', () {
      final user = UserModel(height: 0, weight: 70.0);
      expect(() => user.getImc(), throwsA(isA<ArgumentError>()));

      final userNegativeHeight = UserModel(height: -1.75, weight: 70.0);
      expect(() => userNegativeHeight.getImc(), throwsA(isA<ArgumentError>()));
    });

    test('Deve lançar erro se o peso for zero ou negativo', () {
      final user = UserModel(height: 1.75, weight: 0);
      expect(() => user.getImc(), throwsA(isA<ArgumentError>()));

      final userNegativeWeight = UserModel(height: 1.75, weight: -70.0);
      expect(() => userNegativeWeight.getImc(), throwsA(isA<ArgumentError>()));
    });

    test('Deve retornar a mensagem correta do IMC', () {
      final userUnderweight = UserModel(height: 1.75, weight: 50.0);
      expect(userUnderweight.getImcInfo(), "Abaixo do peso");

      final userIdealWeight = UserModel(height: 1.75, weight: 70.0);
      expect(userIdealWeight.getImcInfo(), "Peso ideal.");

      final userOverweight = UserModel(height: 1.75, weight: 85.0);
      expect(userOverweight.getImcInfo(), "Levemente acima do peso");

      final userObesityGrade1 = UserModel(height: 1.75, weight: 95.0);
      expect(userObesityGrade1.getImcInfo(), "Obesidade de grau I");

      final userObesityGrade2 = UserModel(height: 1.75, weight: 115.0);
      expect(userObesityGrade2.getImcInfo(), "Obesidade de grau II");

      final userObesityGrade3 = UserModel(height: 1.75, weight: 130.0);
      expect(userObesityGrade3.getImcInfo(), "Obesidade de grau III");
    });

    test('Deve converter UserModel para Map corretamente', () {
      final user = UserModel(height: 1.75, weight: 70.0);
      expect(user.toMap(), {'height': 1.75, 'weight': 70.0});
    });

    test('Deve criar UserModel a partir de um Map corretamente', () {
      final map = {'height': 1.75, 'weight': 70.0};
      final user = UserModel.fromMap(map);
      expect(user.height, 1.75);
      expect(user.weight, 70.0);
    });
  });
}
