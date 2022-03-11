class Result<T> {
  Result._();

  factory Result.error(String message, {T? data}) = ErrorResult;

  factory Result.success(T data) = SuccessResult;

  factory Result.loading({T? data}) = LoadingResult;
}

class ErrorResult<T> extends Result<T> {
  final String message;
  final T? data;

  ErrorResult(this.message, {this.data}) : super._();
}

class SuccessResult<T> extends Result<T> {
  final T data;

  SuccessResult(this.data) : super._();
}

class LoadingResult<T> extends Result<T> {
  final T? data;

  LoadingResult({this.data}) : super._();
}
