class AllInterest {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  AllInterest({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllInterest.fromJson(Map<String, dynamic> json) {
    return AllInterest(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
