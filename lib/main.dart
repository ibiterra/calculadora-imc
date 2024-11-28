import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imc_mvvm/viewmodel/imc_viewmodel.dart';
import 'package:imc_mvvm/repositories/user_repository.dart';
import 'package:imc_mvvm/view/pages/home/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImcViewModel(userRepository: UserRepository())),
        Provider(create: (_) => UserRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}