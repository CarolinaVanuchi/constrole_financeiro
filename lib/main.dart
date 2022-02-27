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
          body: FormularioTransferencia(),
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
              // Add your onPressed code here!
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transfência'),),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _controladorCampoNumeroConta,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              labelText: 'Numero da conta',
              hintText: '0000'
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _controladorCampoValor,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              icon: Icon(Icons.monetization_on),
              labelText: 'Valor',
              hintText: '00.00'
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () {
            debugPrint('Clicou');

            final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
            final double? valor = double.tryParse(_controladorCampoValor.text);
            if (numeroConta != null && valor != null) {
              final transferenciaCriada = Transferencia(valor, numeroConta);
              debugPrint('$transferenciaCriada');
            }
          },
          child: Text('Confirmar'))
      ],)
    );
  }
}


