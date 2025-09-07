class SavedEventModel {
  int ?id;
  String? name;
  String? image;
  String ?date;
  String ?time;

  SavedEventModel({this.id, this.name, this.image, this.date, this.time});

  SavedEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}