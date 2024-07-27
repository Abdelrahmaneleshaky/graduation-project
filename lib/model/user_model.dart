class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phone;
  String? IDnum;
  String? imageURL;
  String? creditcard;
  String? status;
  bool?admin;

  UserModel({this.uid, this.email, this.firstName, this.secondName,this.phone,this.IDnum,this.imageURL, this.creditcard,this.status,this.admin});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      phone: map['phone'],
      IDnum: map['Idnum'],
      imageURL: map['imageURL'],
      creditcard: map['creditcard'],
      status:map['status'],
      admin:map['admin'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phone':phone,
      'Idnum':IDnum,
      'imageURL':imageURL,
      'creditcard':creditcard,
      'status':status,
      'admin':admin,
    };
  }
}