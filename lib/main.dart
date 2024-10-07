import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

void botaoON(String endpOn, String ip) async {
  var url = Uri.http(ip, endpOn);
  print(url);
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

void botaoOff(String endpOff, String ip) async {
  var url = Uri.http(ip, endpOff);
  print(url);
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

class botao extends StatelessWidget {
  final String texto;
  final String ip;
  final String endpOn;
  bool validator;
  final String endpOff;

  botao(this.texto, this.ip, this.endpOn, this.validator, this.endpOff);

  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (validator != true) {
            botaoON(endpOn, ip);
            validator = !validator;
          } else {
            botaoOff(endpOff, ip);
            validator = !validator;
          }
        },
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          fixedSize: const Size(150, 90),
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String ip = "";
  bool validacao1 = false;
  bool validacao2 = false;
  bool validacao3 = false;
  bool validacao4 = false;
  bool validacao5 = false;
  bool validacao6 = false;
  bool validacao7 = false;
  bool validacao8 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle da casa"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      ip = val;
                    });
                  },
                  cursorColor: Colors.white,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                    hintText: "digite o ip da ESP32",
                  ),
                ),
              ),
              botao("Porta Garagem", ip, "/garagem/open",
                  validacao1 = false, "/garagem/close"),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  botao("Luz Exterior", ip, "/ledExterior/on", validacao2, "/ledExterior/off"),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  botao("Luz Sala", ip, "/ledSala/on", validacao3, "/ledSala/off")
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  botao("Luz Quarto", ip, "/ledQuarto/on", validacao4, "/ledQuarto/off"),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  botao("Luz Garagem", ip, "/ledGaragem/on", validacao5, "/ledGaragem/off")
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  botao("Fogao", ip, "/ledFogao/on", validacao6, "/ledFogao/off"),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  botao("Televisao", ip, "/ledFogao/off", validacao7, "/ledFogao/off")
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              botao("Ventilador", ip, "/fan/on", validacao8, "/fan/off")

            ],
          ),
        ),
      ),
    );
  }
}
