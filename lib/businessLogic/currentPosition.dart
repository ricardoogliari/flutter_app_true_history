import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'currentPosition.g.dart';

class CurrentPosition = CurrentPositionBase with _$CurrentPosition;

abstract class CurrentPositionBase with Store {
  //dado observável
  @observable
  LatLng latLng;

  //uma ação que modifica o dado observável
  @action
  void getCurrentPosition() async{
    Position position = await Geolocator.getLastKnownPosition();
    latLng = LatLng(
        position.latitude,
        position.longitude);
  }

}
