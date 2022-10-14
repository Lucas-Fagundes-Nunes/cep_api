import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

////////////////////// Busca CEP //////////////////////

String resultado = "";
String h1 = "Seu cep irá aparecer aqui";
TextEditingController txtcep = TextEditingController();


void buscacep() async
{
  // 1 passo  -  Recuperar o CEP
  String cep = txtcep.text;

  // 2 passo  -  Definir a minha URL
  String url = "https://viacep.com.br/ws/$cep/json/";

  // 3 passo  -  Criar váriavel que vai armazenar a resposta da requisição
  http.Response resposta;

  // 4 passo  -  Efetuar a requisição para a url para o método GET
  resposta = await http.get(Uri.parse(url));

  //  Sincrona  -  fala com a pessoa e responde na hora 
  // Assincrona -  fala com a pessoa e demora um tempo para ser respondida


  print(resposta.body);

  print(resposta.statusCode.toString());

  Map<String, dynamic> dados = json.decode(resposta.body);


  String complemento = dados['complemento'];
  String bairro = dados['bairro'];
  String logradouro = dados['logradouro'];
  String localidade = dados['localidade'];
  String uf = dados['uf'];
  String ddd = dados['ddd'];
 
  String endereco = """



Complemento: $complemento,

Bairro: $bairro

Logradouro: $logradouro

Localidade: $localidade

Uf: $uf

DDD: $ddd

""";
String h1novo = "Endereço";

  setState(() {
    resultado = endereco;
    h1 = h1novo;
  });
}

///////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center( child: Text('Consulta de CEP'),),
        backgroundColor: Colors.blueAccent,
      ),

      body: Container(
        padding: EdgeInsets.all(40),
        child: Center(child: Column(children: [
          TextField(
            controller:txtcep, // Manipular o text em váriavel
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Digite um cep: ex: 18133400"),
            style: TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            child: ElevatedButton(child: Text('Consultar') ,
            onPressed: buscacep
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(h1 ,style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),),),
          Container(
            width: double.infinity,
            child: Text(resultado))
        ],)),
      ),
    );
  }
}