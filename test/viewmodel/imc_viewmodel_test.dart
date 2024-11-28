import 'package:flutter_test/flutter_test.dart';
import 'package:imc_mvvm/viewmodel/imc_viewmodel.dart';
import 'package:imc_mvvm/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('ImcViewModel Tests', () {
    late ImcViewModel viewModel;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      viewModel = ImcViewModel(userRepository: mockRepository);
    });

    test('Deve setar os dados do usuário a partir dos controladores', () {
      // Configurar os controladores
      viewModel.heightController.text = '1.75';
      viewModel.weightController.text = '70';

      viewModel.setUserDataFromControllers();

      verify(() => mockRepository.setUserData(1.75, 70.0)).called(1);
    });

    test('Deve calcular o IMC e a mensagem corretamente', () {
      when(() => mockRepository.getUserImc()).thenReturn(22.86);
      when(() => mockRepository.getUserInfo()).thenReturn("Peso ideal.");

      viewModel.calculateImc();

      expect(viewModel.imc, 22.86);
      expect(viewModel.imcInfo, "Peso ideal.");
    });

    test('Deve limpar os dados corretamente', () {
      // Configurar o mock
      viewModel.heightController.text = '1.75';
      viewModel.weightController.text = '70';
      viewModel.imc = 22.86;
      viewModel.imcInfo = "Peso ideal.";

      viewModel.clearData();

      expect(viewModel.imc, isNull);
      expect(viewModel.imcInfo, isNull);
      expect(viewModel.heightController.text, isEmpty);
      expect(viewModel.weightController.text, isEmpty);

      verify(() => mockRepository.clearUserData()).called(1);
    });
  });
}
