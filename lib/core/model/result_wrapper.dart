class Result<T> {
  Result._();

  factory Result.error(String message, {T? data}) = ErrorResult;

  factory Result.success(T data) = SuccessResult;

  factory Result.loading({T? data}) = LoadingResult;

  R when<R>({
    required R Function(SuccessResult<T>) success,
    required R Function(LoadingResult<T>) loading,
    required R Function(ErrorResult<T>) error,
  }) {
    if (this is SuccessResult<T>) {
      return success(this as SuccessResult<T>);
    }

    if (this is LoadingResult<T>) {
      return loading(this as LoadingResult<T>);
    }

    return error(this as ErrorResult<T>);
  }
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
