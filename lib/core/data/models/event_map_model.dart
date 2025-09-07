class PlaceModel {
  int? id;
  String? name;
  String? interest;
  Coordinates? coordinates;

  PlaceModel({this.id, this.name, this.interest, this.coordinates});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    interest = json['interest'];
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['interest'] = interest;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    return data;
  }
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  // هنا لأنه الداتا تجي كمصفوفة [lat, lng]
  Coordinates.fromJson(dynamic json) {
    if (json is List && json.length >= 2) {
      lat = (json[0] as num).toDouble();
      lng = (json[1] as num).toDouble();
    }
  }

  List<dynamic> toJson() {
    return [lat, lng];
  }
}
