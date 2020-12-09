// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currentPosition.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CurrentPosition on CurrentPositionrBase, Store {
  final _$latLngAtom = Atom(name: 'CurrentPositionrBase.latLng');

  @override
  LatLng get latLng {
    _$latLngAtom.reportRead();
    return super.latLng;
  }

  @override
  set latLng(LatLng value) {
    _$latLngAtom.reportWrite(value, super.latLng, () {
      super.latLng = value;
    });
  }

  final _$CurrentPositionrBaseActionController =
      ActionController(name: 'CurrentPositionrBase');

  @override
  void getCurrentPosition() {
    final _$actionInfo = _$CurrentPositionrBaseActionController.startAction(
        name: 'CurrentPositionrBase.getCurrentPosition');
    try {
      return super.getCurrentPosition();
    } finally {
      _$CurrentPositionrBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
latLng: ${latLng}
    ''';
  }
}
