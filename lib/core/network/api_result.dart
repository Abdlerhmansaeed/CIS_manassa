class ApiResult<T> {
  final T? data;
  final String? error;

  ApiResult({this.data, this.error});

  ApiResult.success(T this.data) : error = null;
  ApiResult.failure(String this.error) : data = null;

  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(String error) onFailure,
  }) {
    if (data != null) {
      return onSuccess(data as T);
    } else {
      return onFailure(error!);
    }
  }
}
