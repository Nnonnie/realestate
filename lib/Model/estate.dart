class Estate {
  final String image;
  final String location;

  Estate({required this.image, required this.location});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'location': location,
    };
  }

  static Estate fromMap(Map<String, dynamic> map) {
    return Estate(
      image: map['image'],
      location: map['location'],
    );
  }
}
