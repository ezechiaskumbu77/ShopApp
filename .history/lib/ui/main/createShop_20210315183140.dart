import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/service/shopService.dart';
import 'package:delivery_owner/ui/widgets/inputForm.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/ui/menu/menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../mixins/geroData.dart';
import 'package:delivery_owner/main.dart';

class CreateShop extends StatefulWidget {
  ShopModel shop;
  final Function(String, Map<String, dynamic>) callback;
  UserModel userL;
  BuildContext ctx;
  // ShopModel shop ;
  CreateShop({Key key, this.callback, this.userL, this.ctx, this.shop})
      : super(key: key);
  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityContoller = TextEditingController();
  TextEditingController adressContoller = TextEditingController();
  TextEditingController descContoller = TextEditingController();
  String _province = '0';
  List<DropdownMenuItem<dynamic>> _villeList = [];
  List<DropdownMenuItem<dynamic>> _communeList = [];
  String _ville = '0';
  String _commune = '0';
  List<Map<String, String>> communeMap = communeDataMap;
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  bool visiblelocation = false;
  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final latController = TextEditingController();
  final longController = TextEditingController();
  @override
  void initState() {
    communeMap.forEach((elm) {
      _communeList.add(DropdownMenuItem(
        child: Text(elm['commune'], style: theme.text12bold),
        value: elm['value'],
      ));

      // print('its execute${elm['commune']}');
    });

    _villeList.add(DropdownMenuItem(
      child: Text('',
          style: TextStyle(
            color: Colors.red,
          )),
      value: '0',
    ));

    _communeList.add(DropdownMenuItem(
      child: Text('',
          style: TextStyle(
            color: Colors.red,
          )),
      value: '0',
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var windowWidth = MediaQuery.of(context).size.width;
    var windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Créer un Depot',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                MyCustomInputBox(
                  label: 'Noms',
                  inputHint: 'Entrez le nom du depot',
                  txtControler: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                MyCustomInputBox(
                  label: 'Capacité',
                  inputHint: 'Entrez la capacité',
                  txtControler: quantityContoller,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Province  :    ',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    DropdownButton(
                        hint: Text('Selectionner une province',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        value: _province,
                        items: provinceDataMap,
                        onChanged: (value) {
                          setState(() {
                            _province = value;
                            if (value == '1009') {
                              // _ville='Kinshasa';
                              if (_villeList.length > 1) {
                                _villeList = [
                                  DropdownMenuItem(
                                    child: Text('',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    value: '0',
                                  )
                                ];
                              }

                              _villeList.add(DropdownMenuItem(
                                child: Text('Kinshasa',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                value: 'Kinshasa',
                              ));
                            } else {
                              _ville = '0';

                              _villeList = [
                                DropdownMenuItem(
                                  child: Text('',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  value: '0',
                                )
                              ];

                              _commune = '0';

                              _communeList = [
                                DropdownMenuItem(
                                  child: Text('',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  value: '0',
                                )
                              ];
                            }
                            //  print('sexe ${_sexe}');
                          });

                          // ville
                        }),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Ville  :    ',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    DropdownButton(
                        value: _ville,
                        items: _villeList,
                        onChanged: (value) {
                          setState(() {
                            _ville = value;

                            if (value == 'Kinshasa') {
                              print('print value $value');
                              //_commune='Kinshasa';

                              if (_communeList.length > 1) {
                                _communeList = [
                                  DropdownMenuItem(
                                    child: Text('',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    value: '0',
                                  )
                                ];
                              }
                              communeMap.forEach((elm) {
                                _communeList.add(DropdownMenuItem(
                                  child: Text(elm['commune'],
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  value: elm['value'],
                                ));

                                // print('its execute${elm['commune']}');
                              });
                            } else {
                              _commune = '0';

                              _communeList = [
                                DropdownMenuItem(
                                  child: Text('',
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  value: '0',
                                )
                              ];
                            }

                            //  print('sexe ${_sexe}');
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Commune :    ',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: DropdownButton(
                          hint: Text('',
                              style: TextStyle(
                                color: Colors.red,
                              )),
                          value: _commune,
                          items: _communeList,
                          onChanged: (value) {
                            setState(() {
                              _commune = value;
                              //  _province = value;

                              //  print('sexe ${_sexe}');
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MyCustomInputBox(
                  label: 'Adresse',
                  inputHint: 'Entrez l\'adresse',
                  txtControler: adressContoller,
                ),
                SizedBox(
                  height: 20,
                ),
                MyCustomInputBox(
                  label: 'Description',
                  inputHint: 'Entrez la Description',
                  txtControler: descContoller,
                ),
                SizedBox(
                  height: 20,
                ),
                btnContinuer(
                    context,
                    nameController.text,
                    quantityContoller.text,
                    adressContoller.text,
                    descContoller.text)
              ],
            ),
            Visibility(visible: visiblelocation, child: locationWidget(context))
          ],
        ),
      ),
    ));
  }

  Widget btnContinuer(BuildContext ctx, String name, String quantite,
      String addresse, String description) {
    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(ctx).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();

          Timer(const Duration(milliseconds: 1000), () async {
            widget.shop.name = name;
            widget.shop.capacity = quantite;
            widget.shop.address = addresse;
            widget.shop.description = description;
            widget.shop.ville = _ville;
            widget.shop.commune = _commune;
            widget.shop.province = _province;

            CreateService serv = CreateService();

            var resp = await serv.create(widget.shop);

            print('see the reponse' + resp.toString());

              setState(() {
                visiblelocation = true;
              });
            // locationWidget(ctx);

            stopLoading();
          });
        } else {
          stopLoading();
        }
      },
      child: Text(
        'Créer',
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      loader: Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child: SpinKitWave(
                size: 16, color: Colors.white, type: SpinKitWaveType.start)),
      ),
      borderRadius: 5.0,
      color: Colors.blueAccent,
    );
  }

  //LOCATION-----------------------------------------------------------
  Widget locationWidget(BuildContext ctx) {
    return Padding(
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
                  )),btnValidate() 
            ]))
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
        ;
  }

  Future<void> _goToShop() async {
    CameraPosition shopGeoPoint = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(double.parse(latController.text),
            double.parse(longController.text)),
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
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
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

Widget btnValidate() {
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
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
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
