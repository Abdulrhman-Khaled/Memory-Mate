class User {
  
  String? userName;
  String? phoneNumber;
  String? email;
  String? address;
  String? dateOfBirth;
  String? password;
  String? avatar;
  String? userType;

  User(
      {
      this.userName,
      this.phoneNumber,
      this.email,
      this.address,
      this.dateOfBirth,
      this.password,
      this.avatar,
      this.userType
     });

  User.fromJson(Map<String, dynamic> json) {
    
    userName = json['full_name'];
    email = json['email'];
    password = json['password'];
    userType = json['user_type'];
    address = json['address'];
    phoneNumber = json['phone'];
    dateOfBirth = json['date_of_birth'];   
    avatar = json['photo_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['full_name'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['user_type'] = userType;
    data['address'] = address;
    data['phone'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['photo_path'] = avatar;
    return data;
  }
}
