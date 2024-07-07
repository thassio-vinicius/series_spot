import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/image_model.dart';

class ImageEntity extends Equatable {
  final String medium;
  final String original;

  const ImageEntity({required this.medium, required this.original});

  factory ImageEntity.fromModel(ImageModel model) {
    return ImageEntity(
      medium: model.medium,
      original: model.original,
    );
  }

  @override
  List<Object> get props => [medium, original];
}
