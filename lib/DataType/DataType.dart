class DataTypeG {
  String name;
  String mobile;
  String category;
  String Address;
  String description;
  String image1;
  String image2;
  String image3;
  String image4;


  DataTypeG({this.name, this.mobile, this.category, this.Address,
      this.description, this.image1, this.image2, this.image3, this.image4});

  Map<String, dynamic> tojson() {
    Map<String, dynamic> mydata = {};
    mydata['name'] = name;
    mydata['mobile'] = mobile;
    mydata['category'] = category;
    mydata['Address'] = Address ?? 'i not have  it';
    mydata['description'] = description ?? 'i not have  it';
    mydata['image1'] = image1 ?? '';
    mydata['image2'] = image2 ?? '';
    mydata['image3'] = image3 ?? '';
    mydata['image4'] = image4 ?? '';
    return mydata;
  }

  DataTypeG.fromjson(data) {
    name=data['name'];
    mobile=data['mobile'];
    category=data['category'];
    Address=data['Address'];
    description=data['description'];
    image1=data['image1'];
    image2=data['image2'];
    image3=data['image3'];
    image4=data['image4'];

  }
}
