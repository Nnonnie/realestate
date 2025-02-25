class Address {
  final String? street;
  final String? city;
  final String? country;

  Address({
    this.street,
    this.city,
    this.country,
  });

  // Factory method to create an Address object from the API response
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['address']['road'] ?? 'Unknown',
      city: json['address']['city'] ?? 'Unknown',
      country: json['address']['country'] ?? 'Unknown',
    );
  }
}
