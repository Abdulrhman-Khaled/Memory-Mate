import 'package:memory_mate/models/user.dart';

class PatientUser extends User{

  String? job;
  String? diseaseLevel;

  PatientUser({
    this.job,
    this.diseaseLevel,
  });

  PatientUser.fromJson(Map<String, dynamic> json) {
    job = json['job'];
    diseaseLevel = json['disease_level'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job'] = job;
    data['disease_level'] = diseaseLevel;
    return data;
  }
}
