import 'package:series_spot/core/errors/failure.dart';

class GenericFailure extends Failure {
  const GenericFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String? message])
      : super(message ?? "No internet connection");
}

class NoShowsQueryFailure extends Failure {
  const NoShowsQueryFailure([String? message])
      : super(message ?? "No TV Shows for this query");
}
