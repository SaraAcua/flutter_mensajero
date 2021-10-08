// ignore_for_file: prefer_const_constructors

import 'package:flutter_mensajero/Pantallas/perfil.dart';
import 'package:flutter_mensajero/peticiones/mensajerossqlite.dart';
import 'package:flutter/material.dart';
import 'adicionar.dart';

class ListaMensajeros extends StatefulWidget {
  ListaMensajeros({required this.title});
  final String title;

  @override
  _ListaMensajerosState createState() => _ListaMensajerosState();
}

class _ListaMensajerosState extends State<ListaMensajeros> {
  List<Map<String, dynamic>> _listamensajeros = [];
  bool _cargando = true;

  void _listarmensajero() async {
    final data = await MensajerosCRUD.listarMensajeros();
    setState(() {
      _listamensajeros = data;
      _cargando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _listarmensajero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listados Mensajeros'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Mensajero',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AgregarMensajero())).then((value) {
                  setState(() {
                    _listarmensajero();
                    // getInfo(context);
                  });
                });
              })
        ],
      ),

      body: _cargando
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount:
                  _listamensajeros.length == 0 ? 0 : _listamensajeros.length,
              itemBuilder: (context, posicion) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Perfilmensajero(
                                perfil: _listamensajeros, idperfil: posicion)));
                  },
                  leading: Container(
                    padding: EdgeInsets.all(5.0),
                    width: 50,
                    height: 50,
                    child: Image.network(_listamensajeros[posicion]['foto']),
                  ),
                  title: Text(_listamensajeros[posicion]['nombre']),
                  subtitle: Text(_listamensajeros[posicion]['moto']),
                  trailing: Container(
                    width: 80,
                    height: 40,
                    color: Colors.yellowAccent,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(_listamensajeros[posicion]['placa']),
                  ),
                );
              }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _listarmensajero();
            // getInfo(context);
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



