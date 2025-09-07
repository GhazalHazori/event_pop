class FolowingModel {
  String? id;
  String? name;
  String? image;
  String? followersCount;

  FolowingModel({this.id, this.name, this.image, this.followersCount});

  FolowingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    followersCount = json['followersCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['followersCount'] = followersCount;
    return data;
  }
}
