import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ),
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _distanciaController = TextEditingController();
  TextEditingController _valorCombustivelController = TextEditingController();
  TextEditingController _mediaController = TextEditingController();
  String _result;

  @override
  void initState() {
    super.initState();
    resetFields();
  }
  //método para inicializar os campos vazios
  void resetFields() {
    _distanciaController.text = '';
    _valorCombustivelController.text = '';
    _mediaController.text = '';
    setState(() {
      _result = 'Informe os dados';
    });
  }

  void calculateCusto() {
    double distancia = double.parse(_distanciaController.text);
    double valor = double.parse(_valorCombustivelController.text);
    double media = double.parse(_mediaController.text);
    double res = valor * (distancia / media);

    setState(() {
      _result = "Custo = ${res.toStringAsPrecision(2)}\n";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de Viagem'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Distancia (km)",
              error: "Insira a distancia!",
              controller: _distanciaController),
          buildTextFormField(
              label: "Valor do combustível (RS)",
              error: "Insira o valor!",
              controller: _valorCombustivelController),
          buildTextFormField(
              label: "Média de Consumo (Km/L)",
              error: "Insira a Média!",
              controller: _mediaController),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  Padding buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateCusto();
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Padding buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
      ),
    );
  }

  TextFormField buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}