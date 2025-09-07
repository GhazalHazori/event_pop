class EventModel {
  final int id;
  final int availableSeats;
  final String name;
  final String description;
  final String image;
  final DateTime date;
  final DateTime time;
  final String interest;
  final Location location;
  final int price;
  final int tickets;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  EventModel({
    required this.id,
    required this.availableSeats,
    required this.name,
    required this.description,
    required this.image,
    required this.date,
    required this.time,
    required this.interest,
    required this.location,
    required this.price,
    required this.tickets,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      time: DateTime.parse(
          '${DateTime.now().toIso8601String().split('T')[0]} ${json['time']}'),
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      date: DateTime.parse(json['date']),
      interest: json['interest'],
      location: Location.fromJson(json['location']),
      price: json['price'],
      availableSeats: json['availableSeats'],
      tickets: json['tickets'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'availableSeats': availableSeats,
      'name': name,
      'description': description,
      'image': image,
      'date': date.toIso8601String(),
      'time': time.hour.toString() + ':' + time.minute.toString(),
      'interest': interest,
      'location': location.toJson(),
      'price': price,
      'tickets': tickets,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
