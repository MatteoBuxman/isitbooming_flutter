class Location {
  final String name;
  final bool isTemporary;
  final String locationUUID;

  Location({
    required this.name,
    required this.isTemporary,
    required this.locationUUID,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      isTemporary: json['isTemporary'] == 'true',
      locationUUID: json['locationUUID'],
    );
  }
}