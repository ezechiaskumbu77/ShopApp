
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget location =(){
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final latController = TextEditingController();
  final longController = TextEditingController();

  Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(children: [
            Padding(
                padding: EdgeInsets.only(left: 10, top: 30),
                child: Row(children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 37,
                    color: Colors.red,
                  ),
                  Text("  Localisation" + " ",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w700)),
                ])),
            SizedBox(height: 18.0),
            longInputField(),
            latInputField(),
            btnViewMaps(),
            SizedBox(height: 21.0),
           Container(
             height: 300,
              child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ))
          ]))
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
Future<void> _goToShop() async {
   CameraPosition shopGeoPoint = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(double.parse(latController.text), double.parse(longController.text)),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(shopGeoPoint));
  }

  Widget btnViewMaps() {
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 25, right: 25),
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: Colors.white),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          // _issued(widget.delivery);
        },
        color: Colors.red,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: Text(
          'LOCALISER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget latInputField() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(' Latitude',
                  style: TextStyle(color: Colors.black, fontSize: 13.0)))),
      //  PhoneNumber TextFormFields
      Padding(
          padding: EdgeInsets.only(left: 17, right: 17, bottom: 20),
          child: Card(
            shape: new RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54),
                borderRadius: new BorderRadius.circular(40.0)),
            shadowColor: Colors.black,
            borderOnForeground: true,
            child: Row(
              children: <Widget>[
                Text("  latitude" + " ",
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700)),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    controller: latController,
                    //  autofocus: true,
                    keyboardType: TextInputType.number,
                    key: Key('EnterPhone-TextFormField'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorMaxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ))
    ]);
  }

  Widget longInputField() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(' Longitude',
                  style: TextStyle(color: Colors.black, fontSize: 13.0)))),
      //  PhoneNumber TextFormFields
      Padding(
          padding: EdgeInsets.only(left: 17, right: 17, bottom: 20),
          child: Card(
            shape: new RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54),
                borderRadius: new BorderRadius.circular(40.0)),
            shadowColor: Colors.black,
            borderOnForeground: true,
            child: Row(
              children: <Widget>[
                Text("  longitude" + " ",
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700)),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    controller: longController,
                    //  autofocus: true,
                    keyboardType: TextInputType.number,
                    key: Key('EnterPhone-TextFormField'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorMaxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ))
    ]);
  }
}
