import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _info = "Informe seus dados.";

  List<Map<String, dynamic>> listaIMC = [];

  void _resetFields() {
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
      _info = "Informe seus dados.";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      //print(imc);
      if (imc < 18.6) {
        _info = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
        //print(_info);
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
        //print(_info);
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
        //print(_info);
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
        //print(_info);
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';

        ///print(_info);
      } else if (imc >= 40) {
        _info = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
        //print(_info);
      }

      listaIMC.add({
        'peso': peso,
        'altura': altura,
        'imc': imc,
        'info': _info,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: pesoController,
                    validator: (String? value) {
                      return "Insira seu peso!";
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: alturaController,
                    validator: (String? value) {
                      return "Insira sua altura!";
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 36.0),
                    child: Text(
                      _info,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(50, 50),
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _calcular,
                    child: const Text('Calcular'),
                  ),
                  const SizedBox(height: 20),
                  if (listaIMC.isNotEmpty)
                    DataTable(
                      headingTextStyle: const TextStyle(color: Colors.white),
                      dataTextStyle: const TextStyle(color: Colors.white),
                      columns: [
                        DataColumn(label: Text('Peso(kg)')),
                        DataColumn(label: Text('Altura(cm)')),
                        DataColumn(label: Text('IMC')),
                      ],
                      rows: listaIMC.map((record) {
                        return DataRow(cells: [
                          DataCell(Text(record['peso'].toString())),
                          DataCell(Text(record['altura'].toString())),
                          DataCell(Text(record['info'].toString())),
                        ]);
                      }).toList(),
                    ),
                ],
              ),
            )));
  }
}
