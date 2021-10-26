abstract class BaseResponse {
  bool? isSuccess;
  String? message;
  dynamic data;
}

class DataResponse implements BaseResponse {
  @override
  dynamic data;
  @override
  bool? isSuccess;

  @override
  String? message;

  DataResponse(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    if (isSuccess ?? false) {
      data = json['data'];
    }
    message = json['message'];
  }

  @override
  String toString() {
    return 'isSuccess: $isSuccess \n'
        'message: $message';
  }
}
