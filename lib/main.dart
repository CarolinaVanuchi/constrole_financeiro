import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ByteBankApp();
  }
}

class ByteBankApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: ListaTransferencias(),
        ),     
      );
  }
}
class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: Text('Transferências'),
            ),
            body: Column(
              children: [
                ItenTransferencia(Transferencia(100.0, 515)),
                ItenTransferencia(Transferencia(300.0, 545)),
                ItenTransferencia(Transferencia(400.0, 574)),
              ]
            ),
            
         floatingActionButton: FloatingActionButton(
           onPressed: () {
             final Future future = Navigator.push(context, MaterialPageRoute(builder: (context){
               return FormularioTransferencia();
             }));
              future.then((transferenciaCriada){
                debugPrint('$transferenciaCriada');
                debugPrint('AAA');
              });
            },
            child: Icon(Icons.add),
          ),
        );  
  }
}

class ItenTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  ItenTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
              child: 
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text(_transferencia.valor.toString()),
                  subtitle: Text(_transferencia.numeroConta.toString()),
                ),
            ); 
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toStrig() {
    return '$valor e $numeroConta';
  }
}

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController() ;

  _criarTransferencia(BuildContext context) {
      final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
      final double? valor = double.tryParse(_controladorCampoValor.text);
      if (numeroConta != null && valor != null) {
        final transferenciaCriada = Transferencia(valor, numeroConta);
        Navigator.pop(context, transferenciaCriada);
      }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transfência'),),
      body: Column(children: [

        Editor(controlador: _controladorCampoNumeroConta, rotulo: 'Número da Conta', dica: '00000'),
        Editor(controlador:_controladorCampoValor, rotulo:'Valor', dica:'00.00', icone:Icons.monetization_on),

        ElevatedButton(
          onPressed: () {
            _criarTransferencia(context);
          },
          child: Text('Confirmar'))
      ],)
    );
  }


}

class Editor extends StatelessWidget {
  
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext) {
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controlador,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16.0
              ),
              decoration: InputDecoration(
                icon: icone != null ? Icon(icone): null,
                labelText: rotulo,
                hintText: dica
              ),
            ),
        );  
  }
}
