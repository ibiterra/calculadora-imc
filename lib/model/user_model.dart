class UserModel {
  final double height;
  final double weight;

  // construtor
  UserModel({
    required this.height,
    required this.weight,
  });

  // retorna o IMC calculado
  double getImc() {
    if (height <= 0 && weight <= 0) {
      throw ArgumentError("Altura e peso devem ser maiores que 0.");
    }
    if (height <= 0) {
      throw ArgumentError("Altura deve ser maior que 0.");
    }
    if (weight <= 0) {
      throw ArgumentError("Peso deve ser maior que 0.");
    }

    return ((weight / (height * height)) * 100).roundToDouble() / 100;
  }

  // retorna a mensagem do IMC
  String getImcInfo() {
    final imc = getImc();
    if (imc < 18.6) {
      return "Abaixo do peso";
    } else if (imc >= 18.6 && imc < 24.9) {
      return "Peso ideal.";
    } else if (imc >= 24.9 && imc < 29.9) {
      return "Levemente acima do peso";
    } else if (imc >= 29.9 && imc < 34.9) {
      return "Obesidade de grau I";
    } else if (imc >= 34.9 && imc < 39.9) {
      return "Obesidade de grau II";
    } else {
      return "Obesidade de grau III";
    }
  }

  // método para criar uma instância a partir de um Map (por exemplo, do Firestore ou API)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      height: map['height'] as double,
      weight: map['weight'] as double,
    );
  }
 
  // método para converter uma instância em Map (útil para salvar no Firestore ou API)
  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'weight': weight,
    };
  }
}

