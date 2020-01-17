import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungbuilding/utility/my_style.dart';
import 'package:ungbuilding/utility/normal_dialog.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // Field
  File file;
  double lat, lng;
  String name, detail, urlPic, userPost;

  // Method
  @override
  void initState() {
    super.initState();
    findLatLng();
    findUser();
  }

  Future<void> findUser()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userPost = sharedPreferences.getString('User');
  }

  Future<void> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
      print('lat = $lat, lng = $lng');
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {}
  }

  Widget nameForm() {
    return TextField(
      onChanged: (String string) {
        name = string.trim();
      },
      decoration: InputDecoration(
        labelText: 'Name Product :',
        icon: Icon(Icons.android),
      ),
    );
  }

  Widget detailForm() {
    return TextField(
      onChanged: (String string) {
        detail = string.trim();
      },
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

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        position: LatLng(lat, lng),
        markerId: MarkerId('idProduct'),
      ),
    ].toSet();
  }

  Widget contentOfMap() {
    return lat == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : showMap();
  }

  Widget showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        markers: myMarker(),
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController googleMapController) {},
      ),
    );
  }

  Widget addProductButton() {
    return Container(
      child: RaisedButton(
        color: MyStyle().barColor,
        child: Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'Non Choose Picture',
                'Please Click Camera or Gallery');
          } else if (name == null ||
              name.isEmpty ||
              detail == null ||
              detail.isEmpty) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {
            confirmDialog();
          }
        },
      ),
    );
  }

  Widget showTitleAlert() {
    return ListTile(
      leading: Icon(
        Icons.supervisor_account,
        size: 36.0,
        color: MyStyle().mainColor,
      ),
      title: Text(
        'Comfirm Value',
        style: MyStyle().h1TextStyle,
      ),
    );
  }

  Widget showNameAlert() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name = $name',
          style: MyStyle().h2Title,
        ),
      ],
    );
  }

  Widget showDetailAlert() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 230.0,
          child: Text('Detail = $detail'),
        ),
      ],
    );
  }

  Widget showLatAlert() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 230.0,
          child: Text('Latitude = $lat'),
        ),
      ],
    );
  }

  Widget showLngAlert() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 230.0,
          child: Text('Longtitude = $lng'),
        ),
      ],
    );
  }

  Widget showPicAlert() {
    return Container(
      width: 230,
      height: 230.0,
      child: Image.file(
        file,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showNameAlert(),
        mySizeBox(),
        showDetailAlert(),
        showPicAlert(),
        showLatAlert(),
        showLngAlert(),
      ],
    );
  }

  SizedBox mySizeBox() {
    return SizedBox(
      height: 8.0,
    );
  }

  Widget comfirmButton() {
    return FlatButton(
      child: Text('Comfirm'),
      onPressed: () {
        Navigator.of(context).pop();
        uploadImageToServer();
      },
    );
  }

  Future<void> insertValueToServer() async {
    print('urlPic = $urlPic');

    Map<String, dynamic> map = Map();
    map['producrt'] = name;
    map['detail'] = detail;
    map['lat'] = lat.toString();
    map['lng'] = lng.toString();
    map['picture'] = urlPic;
    map['username'] = userPost;

    print('map =======>>>> ${map.toString()}');

    // String string = '{"producrt": "MasterUng666","detail": "detail","lat": "lat","lng": "lng","picture": "picture","user": "user"}';
    // Map<String, dynamic> map = json.decode(string);

    try {

      Response response = await Dio().post(MyConstant().urlInsertProduct, data: map);
    print('response ==========>>>>>> $response');
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      normalDialog(context, 'Cannot Upload', 'Please Try Again');
    }
      
    } catch (e) {
      print('e ========================================>>> ${e.toString()}');
    }


  }

  Future<void> uploadImageToServer() async {
    Random random = Random();
    int i = random.nextInt(10000);
    String nameFile = 'pic$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, nameFile);

      FormData formData = FormData.from(map);

      await Dio()
          .post(MyConstant().urlUploadPic, data: formData)
          .then((response) {
        print('response ==> $response');
        urlPic = '${MyConstant().urlPic}$nameFile';
        insertValueToServer();
      });
    } catch (e) {}
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text(
        'Cancel',
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> confirmDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: showTitleAlert(),
            content: showContent(),
            actions: <Widget>[
              comfirmButton(),
              cancelButton(),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App New Product'),
        backgroundColor: MyStyle().barColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          showPic(),
          showButton(),
          nameForm(),
          detailForm(),
          contentOfMap(),
          addProductButton(),
        ],
      ),
    );
  }
}
