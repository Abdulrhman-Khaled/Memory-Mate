class Memories {
  String? address;
  String? date;
  String? content;
  String? image;
  int? id;

  Memories({this.address, this.date, this.content, this.image,this.id});

  Memories.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    date = json['date'];
    content = json['content'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['date'] = date;
    data['content'] = content;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}
