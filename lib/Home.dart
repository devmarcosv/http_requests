import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "";

  _recuperarCep() async {
    var url = Uri.parse("https://viacep.com.br/ws/01001000/json/");
    var response = await http.get(url);

    if(response.statusCode == 200) {
      var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
      var logradouro = jsonResponse['logradouro'];
      var bairro = jsonResponse['bairro'];
      var cep = jsonResponse['cep'];

      setState(() {
        _resultado = "$logradouro, $bairro, $cep";
      });

      print('Logradouro: $logradouro');

    }else {
      print('shit');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HTTP requests"),
      ),
    body: Container(
    padding: const EdgeInsets.all(40),
    child: Column(
    children: <Widget>[
      Text(_resultado),
      RaisedButton(
    onPressed: _recuperarCep,
    child: const Text("Tap here"),
    ),
    ],
    ),
    ),
    );
  }
}