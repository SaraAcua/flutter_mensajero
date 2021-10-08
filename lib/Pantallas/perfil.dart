import 'package:flutter/material.dart';
import 'package:flutter_mensajero/peticiones/mensajerossqlite.dart';
import 'editar.dart';

var contextoppal;

// ignore: must_be_immutable
class Perfilmensajero extends StatefulWidget {
  final idperfil;
  late List<Map<String, dynamic>> perfil;
  Perfilmensajero({required this.perfil, this.idperfil});

  @override
  _PerfilmensajeroState createState() => _PerfilmensajeroState();
}

class _PerfilmensajeroState extends State<Perfilmensajero> {
  @override
  Widget build(BuildContext context) {
    contextoppal = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfil',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil Mensajero'),
          actions: [
            IconButton(
                tooltip: 'Editar Mensajero',
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ModificarMensajero(
                                      perfil: widget.perfil,
                                      idperfil: widget.idperfil)))
                      .then((value) => setState(() {
                            widget.perfil = value;
                          }));
                }),
            IconButton(
                tooltip: 'Eliminar Mensajero',
                icon: Icon(Icons.delete),
                onPressed: () async {
                  widget.perfil = widget.perfil.toList();

                  bool result = await confirmarliminar(
                      context, widget.perfil[widget.idperfil]['id']);

                  if (result) {
                    widget.perfil.removeAt(widget.idperfil);
                     Navigator.pop(context, widget.perfil);
                  }
                 
        
                })
          ],
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: Container(
                      height: 100,
                      width: 100,
                      //color: Colors.blue,
                      child: Card(
                        elevation: 2,
                        child: Image.network(
                            widget.perfil[widget.idperfil]['foto']),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              
                              Text(
                                widget.perfil[widget.idperfil]['nombre'],
                                style: TextStyle(fontSize: 20), 
                                
                              ),
                              Text(widget.perfil[widget.idperfil]['moto']),
                              SizedBox(height: 20,),
                              Text('Calificaciones'),
                              SizedBox(height: 20, ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('SOAT'),
                                      CircleAvatar(
                                        child: Text(widget
                                            .perfil[widget.idperfil]['soat']),
                                        backgroundColor:
                                            widget.perfil[widget.idperfil]
                                                        ['soat'] ==
                                                    'NO'
                                                ? Colors.red
                                                : Colors.green,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('TECNOMECANICA'),
                                      CircleAvatar(
                                        child: Text(widget
                                            .perfil[widget.idperfil]['tecno']),
                                        backgroundColor:
                                            widget.perfil[widget.idperfil]
                                                        ['tecno'] ==
                                                    'NO'
                                                ? Colors.red
                                                : Colors.green,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('ACTIVO'),
                                      CircleAvatar(
                                        child: Text(widget
                                            .perfil[widget.idperfil]['activo']),
                                        backgroundColor:
                                            widget.perfil[widget.idperfil]
                                                        ['activo'] ==
                                                    'NO'
                                                ? Colors.red
                                                : Colors.green,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 20, ),
                              Text('Descripcion:'),
                              Text('Mensajero las 24 Horas'),
                              SizedBox(height: 20),
                              SizedBox(height: 20),
                              Text('Verificar Placa:'),
                              SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 50,
                                color: Colors.yellowAccent,
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.perfil[widget.idperfil]['placa'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: 10,),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, widget.perfil);
              },
              child: Text('Regresar'))
        ]),
      ),
    );
  }
}

Future<bool> confirmarliminar(context, ideliminar) async {
  bool result = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('¿Esta seguro de Eliminar?',),
        actions: <Widget>[
          ElevatedButton(
            child: Icon(Icons.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            child: Icon(Icons.check_circle),
            onPressed: () {
              MensajerosCRUD.eliminarMensajero(ideliminar);
              result = true;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );

  return result;
}
