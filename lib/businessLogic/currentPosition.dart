import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'currentPosition.g.dart';

class CurrentPosition = CurrentPositionrBase with _$CurrentPosition;

abstract class CurrentPositionrBase with Store {
  @observable
  LatLng latLng;

  @action
  void getCurrentPosition() {
    latLng = LatLng(
        -29.687208,
        -51.1328970);
  }
}