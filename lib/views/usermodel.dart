// class UserModel{
//   final String id;
//     final String firstname;
//     final String secondname;
//     final String phone;
//     final String email;
//     final String username;
//     UserModel({required this.id, required this.firstname,required this.secondname,required this.phone,required this.email,required this.username});

// factory UserModel.fromJson(Map<String , dynamic > json){
//   return UserModel(
//   id: json['id']?? '',
//   firstname: json['firstname']?? '',
//   secondname: json['secondname']?? '',
//   phone: json['phone']?? '',
//   email: json['email']?? '',
//   username: json['username']?? '',
 
//   );

// }

// }


class UserModel{
  var id;
    var firstname;
    var secondname;
    var phone;
    var email;
    var username;
    UserModel({
     this.id, 
     this.firstname,
     this.secondname,
     this.phone,
     this.email,
     this.username});

 UserModel.fromJson(Map<String , dynamic > json){
  
  id = json['id'];
  firstname =json['firstname'];
  secondname=json['secondname'];
  phone= json['phone'];
  email= json['email'];
  username = json['username'];

}
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id; // Serialize the 'id' field
    data['firstname'] = firstname;
    data['username'] = username;
    data['secondname'] = secondname;
    data['phone'] = phone;
    data['email'] = email;
    return data;
}

}