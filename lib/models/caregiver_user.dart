import 'package:memory_mate/models/user.dart';

class CareGiverUser extends User{
  
  String? relation;
  String? patientId;

  CareGiverUser(
      {
      this.relation,
      this.patientId,
      });

  CareGiverUser.fromJson(Map<String, dynamic> json) {
    
    relation = json['relation'];
    patientId = json['patient_id'];
    
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
  
    data['relation'] = relation;
    data['patient_id'] = patientId;
    
    return data;
  }
}
