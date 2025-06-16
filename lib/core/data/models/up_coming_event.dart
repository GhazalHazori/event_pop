class UpComingEventModel {
  int? id;
  String? name;
  String? description;
  String? image;
  String? date;
  String? interest;
  Location? location;
  int? price;
  int? tickets;
  String? createdAt;
  String? updatedAt;
  String? userId;
  User? user;

  UpComingEventModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.date,
      this.interest,
      this.location,
      this.price,
      this.tickets,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.user});

  UpComingEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
    interest = json['interest'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    price = json['price'];
    tickets = json['tickets'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['date'] = this.date;
    data['interest'] = this.interest;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['price'] = this.price;
    data['tickets'] = this.tickets;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Location {
  Crs? crs;
  String? type;
  List<double>? coordinates;

  Location({this.crs, this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    crs = json['crs'] != null ? new Crs.fromJson(json['crs']) : null;
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.crs != null) {
      data['crs'] = this.crs!.toJson();
    }
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Crs {
  String? type;
  Properties? properties;

  Crs({this.type, this.properties});

  Crs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    return data;
  }
}

class Properties {
  String? name;

  Properties({this.name});

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class User {
  String? id;
  String? name;
  Null? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}