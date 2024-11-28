import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imc_mvvm/viewmodel/imc_viewmodel.dart';
import 'package:imc_mvvm/repositories/user_repository.dart';
import 'package:imc_mvvm/view/pages/home/home_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

// Mocks para os objetos necessários
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late ImcViewModel viewModel;
  late UserRepository userRepository;

  setUp(() {
    // Inicializa o repositório e a viewModel antes de cada teste
    userRepository = MockUserRepository();
    viewModel = ImcViewModel(userRepository: userRepository);
  });

  // Função para criar o widget Home com o MultiProvider
  Widget createHomeWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => viewModel),
        Provider(create: (_) => userRepository),
      ],
      child: const MaterialApp(
        title: 'Calculadora de IMC',
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }

  group('View Tests', () {
    testWidgets('Deve exibir os campos de peso e altura na Home',
        (tester) async {
      // Constrói o widget da Home
      await tester.pumpWidget(createHomeWidget());

      // Espera a UI ser completamente renderizada
      await tester.pumpAndSettle();

      // Verifica se os campos de peso e altura estão presentes
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Peso (kg)'), findsOneWidget);
      expect(find.text('Altura (m)'), findsOneWidget);
    });

    test('Deve calcular IMC com dados válidos', () {
      // Definindo dados válidos nos controladores
      viewModel.heightController.text = '1.75';
      viewModel.weightController.text = '70';

      // Simulando o comportamento do repositório
      when(userRepository.getUserImc).thenReturn(22.86);
      when(userRepository.getUserInfo).thenReturn("Peso ideal.");

      // Chamando o cálculo
      viewModel.calculateImc();

      // Verificando os resultados
      expect(viewModel.imc, 22.86);
      expect(viewModel.imcInfo, "Peso ideal.");
    });

    test('Deve limpar os dados', () {
      // Definindo dados nos controladores
      viewModel.heightController.text = '1.75';
      viewModel.weightController.text = '70';

      // Chamando o método de limpar dados
      viewModel.clearData();

      // Verificando se os dados foram limpos
      expect(viewModel.heightController.text, '');
      expect(viewModel.weightController.text, '');
      expect(viewModel.imc, null);
      expect(viewModel.imcInfo, null);
    });
  });
}