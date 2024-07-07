import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/self_link_model.dart';

class SelfLinkEntity extends Equatable {
  final String href;

  const SelfLinkEntity({required this.href});

  factory SelfLinkEntity.fromModel(SelfLinkModel model) {
    return SelfLinkEntity(href: model.href);
  }

  @override
  List<Object> get props => [href];
}
