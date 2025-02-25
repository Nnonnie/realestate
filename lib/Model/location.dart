// location_model.dart
class EstateLocations {
  final double latitude;
  final double longitude;
  final String? name;

  EstateLocations({
    required this.latitude,
    required this.longitude,
    this.name,
  });

  // Factory method to create LocationModel from a map (simulate JSON parsing from API)
  factory EstateLocations.fromMap(Map<String, dynamic> map) {
    return EstateLocations(
      latitude: map['latitude'],
      longitude: map['longitude'],
      name: map['name'],
    );
  }

  // Method to convert LocationModel to a map (for API calls)
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
    };
  }
}
