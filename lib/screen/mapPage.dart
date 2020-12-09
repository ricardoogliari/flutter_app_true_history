import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/model/history.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const platform = const MethodChannel('app/networkdata');

  //é chamada quando o widget entra na widget tree - somente uma vez
  @override
  void initState() {
    super.initState();
    _callNativeCode();
  }

  //tem o mesmo conceito do async await do TypeScript/Rn
  void _callNativeCode() async { //não congele a nossa tela
    try {
      //ele vai fazer uma ação assíncrona, então ela fica preso aqui enquanto não recebe uma resposta
      final String networkData = await platform.invokeMethod("oInterVaiTomarPauDoBocaHojeSeDeusQuiser");
      getHttp(networkData);
    } on PlatformException catch (e) {

    }
  }
  /*void _callNativeCode() { //não congele a nossa tela
    try {
      //ele vai fazer uma ação assíncrona, então ela fica preso aqui enquanto não recebe uma resposta
      platform.invokeMethod("mamaoDoce").then((value) => {
        getHttp(value);
      });

    } on PlatformException catch (e) {

    }
  }*/

  void getHttp(String networkData) async {
    try {
      List<String> parts = networkData.split("|");
      Response response = await Dio().post(
          "https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyBd3ZTgtyvPgew5O9CVFrxilS7MS3d5YR8",
          data: {
            "macAddress": parts[0],
            "signalStrength": parts[1]
          });
      moveMap(response.data["location"]["lat"], response.data["location"]["lng"]);
    } catch (e) {
      print(e);
    }
  }

  void moveMap(double lat, double lng) async{
    CameraPosition _myPosition = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myPosition));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Consumer<HistoryModel>(
        builder: (context, cart, child) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: buildMarkers(cart.histories),
          );
        },
      ),
    );
  }

  Set<Marker> buildMarkers(List<History> histories){
    histories.forEach((history) {
      final marker = Marker(
        markerId: MarkerId(history.title),
        position: LatLng(history.latitude, history.longitude),
        infoWindow: InfoWindow(
          title: history.title,
          snippet: history.description,
        ),
      );
      _markers[history.title] = marker;
    });

    return _markers.values.toSet();
  }

  final Map<String, Marker> _markers = {};


}
