import 'package:flutter_test/flutter_test.dart';
import 'package:imc_mvvm/model/user_model.dart';
import 'package:imc_mvvm/repositories/user_repository.dart';

void main() {
  group('UserRepository Tests', () {
    late UserRepository repository;

    setUp(() {
      repository = UserRepository();
    });

    test('Deve criar um UserModel com dados válidos', () {
      repository.setUserData(1.75, 70.0);
      expect(repository.user, isA<UserModel>());
      expect(repository.user?.height, 1.75);
      expect(repository.user?.weight, 70.0);
    });

    test('Deve lançar erro se altura ou peso forem inválidos', () {
      expect(() => repository.setUserData(null, 70.0), throwsA(isA<ArgumentError>()));
      expect(() => repository.setUserData(1.75, null), throwsA(isA<ArgumentError>()));
    });

    test('Deve retornar o IMC correto do usuário', () {
      repository.setUserData(1.75, 70.0);
      expect(repository.getUserImc(), 22.86);
    });

    test('Deve retornar a mensagem de IMC correta do usuário', () {
      repository.setUserData(1.75, 70.0);
      expect(repository.getUserInfo(), "Peso ideal.");
    });

    test('Deve retornar null para IMC e Info se usuário não existir', () {
      expect(repository.getUserImc(), isNull);
      expect(repository.getUserInfo(), isNull);
    });

    test('Deve limpar os dados do usuário corretamente', () {
      repository.setUserData(1.75, 70.0);
      repository.clearUserData();
      expect(repository.user, isNull);
      expect(repository.getUserImc(), isNull);
      expect(repository.getUserInfo(), isNull);
    });
  });
}
