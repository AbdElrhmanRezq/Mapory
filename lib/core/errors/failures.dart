import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ServerFailure("Request to server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout in connection with server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout in connection with server");
      case DioExceptionType.badResponse:
        {
          final statusCode = dioError.response?.statusCode;
          if (statusCode != null) {
            switch (statusCode) {
              case 400:
                return ServerFailure("Bad request");
              case 401:
                return ServerFailure("Unauthorized request");
              case 403:
                return ServerFailure("Forbidden request");
              case 404:
                return ServerFailure("Not found");
              case 500:
                return ServerFailure("Internal server error");
              default:
                return ServerFailure(
                  "Received invalid status code: $statusCode",
                );
            }
          } else {
            return ServerFailure("Received invalid response from server");
          }
        }
      default:
        return ServerFailure("Unexpected error occurred");
    }
  }
}
