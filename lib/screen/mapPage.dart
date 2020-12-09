import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_true_history/businessLogic/currentPosition.dart';
import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/model/history.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
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

    autorun(
            (_) {
              moveMap(GetIt.I<CurrentPosition>().latLng);
            });
  }

  void moveMap(LatLng latLng) async{
    CameraPosition _myPosition = CameraPosition(
        target: latLng,
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
            markers: buildMarhers(cart.histories),
          );
        },
      ),
    );
  }

  Set<Marker> buildMarhers(List<History> histories){
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
