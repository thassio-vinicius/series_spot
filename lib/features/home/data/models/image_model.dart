class ImageModel {
  final String medium;
  final String original;

  ImageModel({
    required this.medium,
    required this.original,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      medium: json['medium'],
      original: json['original'],
    );
  }
}
