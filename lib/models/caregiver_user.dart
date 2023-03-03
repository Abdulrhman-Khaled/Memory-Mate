class CareGiverUser {
  int? id;
  String? userName;
  String? phoneNumber;
  String? email;
  String? address;
  String? dateOfBirth;
  String? relation;
  String? patientId;
  String? password;
  String? avatar;
  int? age;

  CareGiverUser(
      {this.id,
      this.userName,
      this.phoneNumber,
      this.email,
      this.address,
      this.dateOfBirth,
      this.relation,
      this.patientId,
      this.password,
      this.avatar,
      this.age});

  CareGiverUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    relation = json['relation'];
    patientId = json['patient_id'];
    password = json['password'];
    avatar = json['avatar'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['date_of_birth'] = dateOfBirth;
    data['relation'] = relation;
    data['patient_id'] = patientId;
    data['password'] = password;
    data['avatar'] = avatar;
    data['age'] = age;
    return data;
  }
}
