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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green[900],
          textTheme: ButtonTextTheme.primary
        )
      ),
        home: ListaTransferencias(),
      );
  }
}
class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: Text('Transferências'),
            ),
            body: ListView.builder(
              itemCount: widget._transferencias.length,
              itemBuilder: (context, indice) {
                final transferencia = widget._transferencias[indice];
                return ItenTransferencia(transferencia);
              },
              
            ),
            
         floatingActionButton: FloatingActionButton(
           onPressed: () {
             final Future future = Navigator.push(context, MaterialPageRoute(builder: (context){
               return FormularioTransferencia();
             }));
              future.then((transferenciaRecebida){
                debugPrint('Float');
                debugPrint(transferenciaRecebida);
                if (transferenciaRecebida != null) {
                  setState(() {
                    widget._transferencias.add(transferenciaRecebida);
                  });
                }
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
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}

class FormularioTransferencia extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController() ;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transfência'),),
      body: SingleChildScrollView (
        child: Column(children: [

        Editor(controlador: _controladorCampoNumeroConta, rotulo: 'Número da Conta', dica: '00000'),
        Editor(controlador:_controladorCampoValor, rotulo:'Valor', dica:'00.00', icone:Icons.monetization_on),

        ElevatedButton(
          onPressed: () {
            _criarTransferencia(context);
          },
          child: Text('Confirmar'))
      ],)
      )
       
    );
  }

  _criarTransferencia(BuildContext context) {
      final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
      final double? valor = double.tryParse(_controladorCampoValor.text);
      if (numeroConta != null && valor != null) {
        final transferenciaCriada = Transferencia(valor, numeroConta);
        debugPrint('aa');
        debugPrint('$transferenciaCriada');
        Navigator.pop(context, transferenciaCriada);
      }
  } 
}

class Editor extends StatelessWidget {
  
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
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
