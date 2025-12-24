class PhotoModel {
  final int id;
  final String image;
  final String photographer;
  final String? alt;
  final int? photographerId;

  PhotoModel({
    required this.id,
    required this.image,
    required this.photographer,
    this.alt,
    this.photographerId,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
    id: json['id'],
    image: json['src']['medium'],
    photographer: json['photographer'],
    alt: json['alt'],
    photographerId: json['photographer_id'],
  );

  toJson() {}
}
