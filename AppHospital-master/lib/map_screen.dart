import 'dart:convert';
import 'dart:io';
import 'package:apphospital/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(32.1560511, 21.4798572), zoom: 20);
  late GoogleMapController _googleMapController;

//Talvez funcione, não consigo testar agora

  @override
  Widget build(BuildContext context) {
    List<Post> local = [];

    Future getLocal() async {
      var response = await http.get(
          Uri.http('sites.otex.com.br', '/api_cnes/api/estabelecimento.php'),
          headers: {HttpHeaders.authorizationHeader: 'admin:admin'});
      var jsonData = jsonDecode(response.body);
      for (var eachlocal in jsonData()) {
        final latlng = Post(
            nome: eachlocal['nome'],
            tipo: eachlocal['tipo'],
            rua: eachlocal['rua'],
            numero: eachlocal['numero'],
            bairro: eachlocal['bairro'],
            cidade: eachlocal['cidade'],
            uf: eachlocal['uf'],
            longitude: eachlocal['longitude'],
            latitude: eachlocal['latitude']);
        local.add(latlng);
      }
    }

    createMarkers() {
      List<Post> mapModel = getLocal().obs as List<Post>;
      var markers = RxSet<Marker>();
      for (var element in mapModel) {
        markers.add(Marker(
            markerId: MarkerId(element.nome),
            position: LatLng(element.latitude, element.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));
      }
      return markers;
    }

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        markers: createMarkers(),
      ), //Botao no canto do app, pode por ele pra direcionar a camera pra sua localizaçao depois
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
