import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Índice de Massa Corporal',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Índice de Massa Corporal'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pesoCtrl = TextEditingController();
  var alturaCtrl = TextEditingController();
  String info = "Informe os seus dados.";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void reset() {
    pesoCtrl.clear();
    alturaCtrl.clear();
    setState(() {
      info = "Informe os seus dados.";
    });
  }

  void calculate() {
    double peso = double.parse(pesoCtrl.text);

    // ! Convertendo de centrímetros para metros

    double altura = (double.parse(alturaCtrl.text) / 100);
    double imc = peso / (altura * altura);

    setState(() {
      if (imc < 18.6) {
        info = "Abaixo do peso! Seu índice é de: ${imc.toStringAsPrecision(2)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        info = "Ótimo! Seu índice é de: ${imc.toStringAsPrecision(2)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        info = "Acima do peso! Seu índice é de: ${imc.toStringAsPrecision(2)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        info = "Obesidade I! Seu índice é de: ${imc.toStringAsPrecision(2)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        info = "Obesidade II! Seu índice é de: ${imc.toStringAsPrecision(2)}";
      } else if (imc >= 40) {
        info = "Obesidade III! Seu índice é de: ${imc.toStringAsPrecision(2)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reset,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.deepPurple,
              ),
              TextFormField(
                controller: pesoCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso em quilogramas",
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe o seu peso";
                  }
                },
              ),
              TextFormField(
                controller: alturaCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura em centímetros",
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe a sua altura.";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
