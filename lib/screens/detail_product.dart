import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungbuilding/models/product_model.dart';
import 'package:ungbuilding/utility/my_style.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  DetailProduct({Key key, this.productModel}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  // Field
  String nameProduct = '';
  ProductModel myProductModel;
  LatLng latLng;

  // Method
  @override
  void initState() {
    super.initState();
    myProductModel = widget.productModel;
    if (myProductModel != null) {
      nameProduct = myProductModel.producrt;
    }
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Image.network(myProductModel.picture),
    );
  }

  Widget showDetail() {
    return ListTile(
      title: ListTile(
        leading: Icon(Icons.android),
        title: Text('Detail :'),
      ),
      subtitle: Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        child: Text(myProductModel.detail),
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        position: latLng,
        markerId: MarkerId('myID'),
      ),
    ].toSet();
  }

  Widget showMap() {
    double lat = double.parse(myProductModel.lat);
    double lng = double.parse(myProductModel.lng);
    latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: GoogleMap(markers: myMarker(),
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController googleMapController) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().barColor,
        title: Text('$nameProduct'),
      ),
      body: ListView(
        children: <Widget>[
          showImage(),
          showDetail(),
          showMap(),
        ],
      ),
    );
  }
}
