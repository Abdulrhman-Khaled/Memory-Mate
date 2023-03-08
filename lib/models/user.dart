class User {
  int? id;
  String? userName;
  String? phoneNumber;
  String? email;
  String? address;
  String? dateOfBirth;
  String? password;
  String? avatar;
  String? userType;

  User(
      {this.id,
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
    id = json['id'];
    userName = json['username'];
    phoneNumber = json['phone'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    password = json['password'];
    avatar = json['avatar'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = userName;
    data['phone'] = phoneNumber;
    data['email'] = email;
data['address'] = address;
    data['date_of_birth'] = dateOfBirth;
    data['password'] = password;
    data['avatar'] = avatar;
    data['user_type'] = userType;
    return data;
  }
}
