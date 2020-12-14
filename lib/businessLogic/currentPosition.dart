import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'currentPosition.g.dart';

class CurrentPosition = CurrentPositionrBase with _$CurrentPosition;

abstract class CurrentPositionrBase with Store {
  @observable
  LatLng latLng;

  @action
  void getCurrentPosition() async{
    Position position = await Geolocator.getLastKnownPosition();
    latLng = LatLng(
        position.latitude,
        position.longitude);
  }
}
