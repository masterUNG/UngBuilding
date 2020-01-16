import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungbuilding/utility/my_style.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // Field
  File file;
  double lat, lng;

  // Method
  Widget nameForm() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Name Product :',
        icon: Icon(Icons.android),
      ),
    );
  }

  Widget detailForm() {
    return TextField(
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Detail Product :',
        icon: Icon(Icons.details),
      ),
    );
  }

  Widget cameraButton() {
    return OutlineButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(Icons.add_a_photo),
      label: Text('Camera'),
      onPressed: () {
        cameraAndGallery(ImageSource.camera);
      },
    );
  }

  Future<void> cameraAndGallery(ImageSource imageSource) async {
    await ImagePicker.pickImage(
      source: imageSource,
      maxWidth: 800.0,
      maxHeight: 800.0,
    ).then((response) {
      setState(() {
        file = response;
      });
    });
  }

  Widget galleryButton() {
    return OutlineButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(Icons.add_photo_alternate),
      label: Text('Gallery'),
      onPressed: () {
        cameraAndGallery(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showPic() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: file == null ? Image.asset('images/pic.png') : Image.file(file),
    );
  }

  Widget showMap() {
    if (lat == null) {
      lat = 13.673499;
      lng = 100.606896;
    }

    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController googleMapController) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App New Product'),
        backgroundColor: MyStyle().mainColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          showPic(),
          showButton(),
          nameForm(),
          detailForm(),
          showMap(),
        ],
      ),
    );
  }
}
