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
      CameraPosition(target: LatLng(-11.1560511, 12.4798572), zoom: 20);
  late GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    List<Post> local = [];
    getLocal() async {
      var response = await http.get(
          Uri.http('sites.otex.com.br', '/api_cnes/api/estabelecimento.php'),
          headers: {HttpHeaders.authorizationHeader: 'admin:admin'});
      var jsonData = jsonDecode(response.body);

      local.add(jsonData);

      print(local);
    }

    var marker = Marker(
        markerId: MarkerId('teste'),
        position: LatLng(32, 12),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

    var googleMap = const GoogleMap(
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: _initialCameraPosition,
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

  createMarkers() {}

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
}
