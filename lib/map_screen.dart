import 'dart:convert';
import 'dart:io';
import 'package:apphospital/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:apphospital/main.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(32.1560511, 21.4798572), zoom: 20);
  late GoogleMapController _googleMapController;

//Nao ta funcionando ainda
//tentando arrumar um jeito de inicializar aesa funcao getlocal(), mas nao consegui
  @override
  Widget build(BuildContext context) {
    List<Post> local = [];
    getLocal() async {
      var response = await http.get(
          Uri.http('sites.otex.com.br', '/api_cnes/api/estabelecimento.php'));
      var jsonData = jsonDecode(response.body);

      local.add(jsonData);

      print(local);
    }

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        markers: {
          //marcador
          Marker(markerId: MarkerId('teste'), position: LatLng(32, 21))
        },
      ), //botao no canto do app, pode por ele pra direcionar a camera pra sua localizaçao depois
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

//Ignora isso
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
}
