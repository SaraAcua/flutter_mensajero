// ignore_for_file: prefer_const_constructors

import 'package:flutter_mensajero/peticiones/mensajerossqlite.dart';
import 'package:flutter/material.dart';

class ModificarMensajero extends StatefulWidget {
  final idperfil;
  final List<Map<String, dynamic>> perfil;
  ModificarMensajero({required this.perfil, this.idperfil});

  @override
  _ModificarMensajeroState createState() => _ModificarMensajeroState();
}

class _ModificarMensajeroState extends State<ModificarMensajero> {
  late List<Map<String, dynamic>> perfiles = [];
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlfoto = TextEditingController();
  TextEditingController controlplaca = TextEditingController();
  TextEditingController controltelefono = TextEditingController();
  TextEditingController controlwhatsapp = TextEditingController();
  TextEditingController controlmoto = TextEditingController();

  bool soat = false;
  bool tecno = false;
  bool activo = false;
  late String soattxt;
  late String tecnotxt;
  late String activotxt;

  @override
  void initState() {
    this.perfiles = widget.perfil.toList();
    controlNombre =
        TextEditingController(text: widget.perfil[widget.idperfil]['nombre']);
    controlfoto =
        TextEditingController(text: widget.perfil[widget.idperfil]['foto']);
    controlplaca =
        TextEditingController(text: widget.perfil[widget.idperfil]['placa']);
    controltelefono =
        TextEditingController(text: widget.perfil[widget.idperfil]['telefono']);
    controlwhatsapp =
        TextEditingController(text: widget.perfil[widget.idperfil]['whatsapp']);
    controlmoto =
        TextEditingController(text: widget.perfil[widget.idperfil]['moto']);

    soattxt = widget.perfil[widget.idperfil]['soat'];
    tecnotxt = widget.perfil[widget.idperfil]['tecno'];
    activotxt = widget.perfil[widget.idperfil]['activo'];

    widget.perfil[widget.idperfil]['soat'] == 'SI' ? soat = true : soat = false;
    widget.perfil[widget.idperfil]['tecno'] == 'SI'
        ? tecno = true
        : tecno = false;
    widget.perfil[widget.idperfil]['activo'] == 'SI'
        ? activo = true
        : activo = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text("Adicionar Mensajero"), 
        
      ), 
      body: Container(
        
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: controlNombre,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                               icon: Icon(Icons.supervised_user_circle_rounded , color: Colors.black),
                                labelText: 'Nombre : ',
                              ),
              ),
              TextField(
                controller: controlfoto,
                decoration: InputDecoration(
                               icon: Icon(Icons.photo_camera , color: Colors.black),
                                labelText: 'Foto : ',
                              ),
                
              ),
              TextField(
                controller: controlplaca,
                   decoration: InputDecoration(
                               icon: Icon(Icons.offline_pin, color: Colors.black),
                                labelText: 'Placa : ',
                              ),
              ),
              TextField(
               
                controller: controltelefono,
                 keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                               icon: Icon(Icons.phone, color: Colors.black),
                                labelText: 'Telefono : ',
                              ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: controlwhatsapp,
                
               decoration: InputDecoration(
                               icon: Icon(Icons.phone_android, color: Colors.black),
                                labelText: 'Whatsaap : ',),
              ),
              TextField(
                 keyboardType: TextInputType.number,
                controller: controlmoto,
                decoration: InputDecoration( icon: Icon(Icons.motorcycle, color: Colors.black),
                                labelText: 'Whatsaap : ',
                              ),
              ),
              SwitchListTile(
                title: Text('Soat Vigente?'),
                value: soat,
                onChanged: (bool value) {
                  setState(() {
                    soat = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Tecnomecanica Vigente?'),
                value: tecno,
                onChanged: (bool value) {
                  setState(() {
                    tecno = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Activo ?'),
                value: activo,
                onChanged: (bool value) {
                  setState(() {
                    activo = value;
                  });
                },
              ),
              ElevatedButton(
                child: Text("Modificar Mensajero"),
                onPressed: () {
                  soat == true ? soattxt = "SI" : soattxt = "NO";
                  tecno == true ? tecnotxt = "SI" : tecnotxt = "NO";
                  activo == true ? activotxt = "SI" : activotxt = "NO";

                  MensajerosCRUD.actualizarMensajero(
                      widget.perfil[widget.idperfil]['id'],
                      controlNombre.text,
                      controlfoto.text,
                      controlplaca.text,
                      controltelefono.text,
                      controlwhatsapp.text,
                      controlmoto.text,
                      soattxt,
                      tecnotxt,
                      activotxt);

                  int idPerfil = perfiles.removeAt(widget.idperfil)['id'];
                  perfiles.insert(widget.idperfil, {
                    'id': idPerfil,
                    'nombre': controlNombre.text,
                    'foto': controlfoto.text,
                    'placa': controlplaca.text,
                    'telefono': controltelefono.text,
                    'whatsapp': controlwhatsapp.text,
                    'moto': controlmoto.text,
                    'soat': soattxt,
                    'tecno': tecnotxt,
                    'activo': activotxt,
                    'createdAt': DateTime.now().toString()
                  });

                  Navigator.pop(context, perfiles);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}