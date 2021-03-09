import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Desafio YesList'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _volumeGalaoController = TextEditingController();
  TextEditingController _qtdGarrafasController = TextEditingController();
  TextEditingController _garrafasVolumeController = TextEditingController();
  String garrafas = '';
  String sobras = '';
  void _encherGalao() {
    List<num> garrafas = [];
    num volumeGalao = num.tryParse(_volumeGalaoController.text);
    int qtdGarrafas = num.tryParse(_qtdGarrafasController.text);
    num sobraGarrafa = double.negativeInfinity;
    var listGarrafas = _garrafasVolumeController.text.split("-");
    listGarrafas.forEach((element) {
      garrafas.add(num.tryParse(element));
    });
    var r = "";
    var r2 = "";
    garrafas.sort((b, a) => a.compareTo(b));

    for (int i = 0; i < garrafas.length; i++) {
      if (volumeGalao - garrafas[i] >= 0) {
        volumeGalao -= garrafas[i];

        r += "${garrafas[i]}L ";
        garrafas[i] = 0;
      }
    }

    if (volumeGalao != 0) {
      for (int i = 0; i < garrafas.length; i++) {
        if (garrafas[i] != 0) {
          if (volumeGalao - garrafas[i] > sobraGarrafa) {
            sobraGarrafa = volumeGalao - garrafas[i];
            r2 = "${garrafas[i]}L ";
          }
        }
      }
    } else {
      sobraGarrafa = 0;
    }
    r += r2;
    print("Foi usado as garrafas de: $r");
    print("Sobrou: ${sobraGarrafa.abs()}L");

    setState(() {
      this.garrafas = "Foi usado as garrafas de: $r";
      sobras = "Sobrou: ${sobraGarrafa.abs()}L";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration:
                      InputDecoration(labelText: 'Informe o volume do Galão:'),
                  controller: _volumeGalaoController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Informe a quantidade de garrafas:'),
                  controller: _qtdGarrafasController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText:
                          "Informe o volume de cada garrafa separado por vírgulas \",\""),
                  controller: _garrafasVolumeController,
                  keyboardType: TextInputType.number,
                ),
              ),
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Encher Galão',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _encherGalao),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    garrafas,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    sobras,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
