import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imc_mvvm/viewmodel/imc_viewmodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ImcViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              viewModel.clearData();
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person_outline, size: 120, color: Colors.black),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                controller: viewModel.weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "INSIRA SEU PESO!!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                controller: viewModel.heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "INSIRA SUA ALTURA!!";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          viewModel.setUserDataFromControllers();

                          viewModel.calculateImc();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString(),
                              style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:Text('Por favor, digite algo nos campos.',
                              style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      "CALCULAR",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                viewModel.imc == null
                    ? "Por favor, insira suas informações."
                    : "Seu IMC: ${viewModel.imc}\n${viewModel.imcInfo}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
