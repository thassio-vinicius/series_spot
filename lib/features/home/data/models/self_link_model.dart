class SelfLinkModel {
  final String href;

  SelfLinkModel({required this.href});

  factory SelfLinkModel.fromJson(Map<String, dynamic> json) {
    return SelfLinkModel(
      href: json['href'],
    );
  }
}
