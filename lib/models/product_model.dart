// class ProductModel {

//   // Field
//   String id, product;


//   // Constructor
//   ProductModel(this.id, this.product);

//   ProductModel.fromJSON(Map<String, dynamic> map){
//     id = map['id'];
//     product = map['producrt'];
//   }
  
// }

class ProductModel {
  int id;
  String producrt;
  String detail;
  String lat;
  String lng;
  String picture;
  String username;
  String createdAt;
  String updatedAt;

  ProductModel(
      {this.id,
      this.producrt,
      this.detail,
      this.lat,
      this.lng,
      this.picture,
      this.username,
      this.createdAt,
      this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    producrt = json['producrt'];
    detail = json['detail'];
    lat = json['lat'];
    lng = json['lng'];
    picture = json['picture'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['producrt'] = this.producrt;
    data['detail'] = this.detail;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['picture'] = this.picture;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

