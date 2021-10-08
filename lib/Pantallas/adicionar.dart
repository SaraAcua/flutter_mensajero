import 'package:flutter_mensajero/peticiones/mensajerossqlite.dart';
import 'package:flutter/material.dart';

class AgregarMensajero extends StatefulWidget {
  @override
  _AgregarMensajeroState createState() => _AgregarMensajeroState();
}

class _AgregarMensajeroState extends State<AgregarMensajero> {
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlfoto = TextEditingController();
  TextEditingController controlplaca = TextEditingController();
  TextEditingController controltelefono = TextEditingController();
  TextEditingController controlwhatsapp = TextEditingController();
  TextEditingController controlmoto = TextEditingController();
  bool soat = false;
  bool tecno = false;
  bool activo = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: controlfoto,
                decoration: InputDecoration(labelText: "Foto"),
              ),
              TextField(
                controller: controlplaca,
                decoration: InputDecoration(labelText: "Placa"),
              ),
              TextField(
                controller: controltelefono,
                decoration: InputDecoration(labelText: "Telefono"),
              ),
              TextField(
                controller: controlwhatsapp,
                decoration: InputDecoration(labelText: "WhatsApp"),
              ),
              TextField(
                controller: controlmoto,
                decoration: InputDecoration(labelText: "Moto"),
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
                child: Text("Adicionar Mensajero"),
                onPressed: () {
                  String soattxt = "NO";
                  String tecnotxt = "NO";
                  String activotxt = "NO";
                  soat == true ? soattxt = "SI" : soattxt = "NO";
                  tecno == true ? tecnotxt = "SI" : tecnotxt = "NO";
                  activo == true ? activotxt = "SI" : activotxt = "NO";

                  MensajerosCRUD.guardarMensajero(
                      controlNombre.text,
                      controlfoto.text,
                      controlplaca.text,
                      controltelefono.text,
                      controlwhatsapp.text,
                      controlmoto.text,
                      soattxt,
                      tecnotxt,
                      activotxt);

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
