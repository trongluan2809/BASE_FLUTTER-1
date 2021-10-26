class ErrorModel {
  int code;
  String message;

  ErrorModel(this.message, {this.code = 0});

  @override
  String toString() {
    return 'code: $code \n'
        'message: $message';
  }
}
