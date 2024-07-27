class RentModel {
  String? Name;
  int? bath;
  int? bed;
  String? description;
  String? location;
  int? price;
  String? imageURL;
  int? space;


  RentModel({ this.Name, this.bath, this.bed,this.description,this.location,this.imageURL, this.price,this.space});

  // receiving data from server
  factory RentModel.fromMap(map) {
    return RentModel(
      Name: map['Name'],
      bath: map['bath'],
      bed: map['bed'],
      description: map['description'],
      location: map['location'],
      imageURL: map['imageURL'],
      space: map['space'],
      price: map['price'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'bath': bath,
      'Name': Name,
      'bed': bed,
      'description':description,
      'location':location,
      'imageURL':imageURL,
      'space':space,
      'price':price,
    };
  }
}