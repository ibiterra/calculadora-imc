import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:imc_mvvm/main.dart';
import 'package:imc_mvvm/view/pages/home/home_page.dart';
import 'package:imc_mvvm/viewmodel/imc_viewmodel.dart';
import 'package:imc_mvvm/repositories/user_repository.dart';

void main() {
  group('Main', () {
    testWidgets('Deve carregar a aplicação com os providers e home page',
        (tester) async {
      //cCriar o app com o MultiProvider configurado
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => ImcViewModel(userRepository: UserRepository())),
            Provider(create: (_) => UserRepository()),
          ],
          child: const MyApp(),
        ),
      );

      // verificar se a HomePage foi carregada
      expect(find.byType(Home), findsOneWidget);

      // verificar se o título da app está correto
      expect(find.text('Calculadora de IMC'), findsOneWidget);
    });

    testWidgets('Deve fornecer o ImcViewModel corretamente', (tester) async {
      // criar o app com os providers
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => ImcViewModel(userRepository: UserRepository())),
            Provider(create: (_) => UserRepository()),
          ],
          child: const MyApp(),
        ),
      );

      // verificar se o ImcViewModel está sendo injetado corretamente
      final viewModel = Provider.of<ImcViewModel>(
          tester.element(find.byType(Home)),
          listen: false);

      // verificar que o viewModel não está nulo
      expect(viewModel, isNotNull);
    });
  });
}
