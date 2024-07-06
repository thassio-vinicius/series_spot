import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure([this.message = "Something went wrong"]);

  @override
  List<Object?> get props => [message];
}
