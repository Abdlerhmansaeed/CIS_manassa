import 'package:mansaa_app/core/error_handling/failures/failure.dart';

/// نتيجة كل عملية في طبقة Repository.
/// تحمل إما بيانات ناجحة أو [Failure] مُصنَّف — لا سلاسل نصية خام.
class ApiResult<T> {
  final T? data;
  final Failure? failure;

  ApiResult._({this.data, this.failure});

  ApiResult.success(T data) : this._(data: data);

  ApiResult.failure(Failure failure) : this._(failure: failure);

  bool get isSuccess => data != null;
  bool get isFailure => failure != null;

  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    if (data != null) return onSuccess(data as T);
    return onFailure(failure!);
  }
}
