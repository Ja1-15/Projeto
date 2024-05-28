import 'dart:convert';
import 'dart:io';
import 'package:apphospital/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Post> local = [];

  Future getLocal() async {
    var response = await http.get(
        Uri.http('sites.otex.com.br', '/api_cnes/api/estabelecimento.php'),
        headers: {HttpHeaders.authorizationHeader: 'admin:admin'});

    var jsonData = jsonDecode(response.body);

    for (var eachlat in jsonData()) {
      final lat = Post(
          latitude: eachlat['latitude'],
          longitude: eachlat['longitude'],
          radius: eachlat['radius']);
      local.add(lat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(-11.1560511, 12.4798572), zoom: 20);
  late GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    var googleMap = GoogleMap(
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: _initialCameraPosition,
      markers: createMarkers(),
    );
    return Scaffold(
      body: googleMap,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  createMarkers() {
    List<Post> mapModel = <Post>[].obs;
    var markers = RxSet<Marker>();
    for (var element in mapModel) {
      markers.add(Marker(
          markerId: MarkerId(element.radius as String),
          position: LatLng(element.latitude, element.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
    }
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
}
