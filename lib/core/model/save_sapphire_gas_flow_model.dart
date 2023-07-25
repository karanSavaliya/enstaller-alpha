class SaveSapphireGasFlow {
  Result? result;
  int? id;
  dynamic exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  int? creationOptions;
  dynamic asyncState;
  bool? isFaulted;

  SaveSapphireGasFlow({
    this.result,
    this.id,
    this.exception,
    this.status,
    this.isCanceled,
    this.isCompleted,
    this.creationOptions,
    this.asyncState,
    this.isFaulted,
  });

  factory SaveSapphireGasFlow.fromJson(Map<String, dynamic> json) {
    return SaveSapphireGasFlow(
      result: Result.fromJson(json['result']),
      id: json['id'],
      exception: json['exception'],
      status: json['status'],
      isCanceled: json['isCanceled'],
      isCompleted: json['isCompleted'],
      creationOptions: json['creationOptions'],
      asyncState: json['asyncState'],
      isFaulted: json['isFaulted'],
    );
  }
}

class Result {
  dynamic content;
  int? statusCode;
  dynamic scope;
  dynamic errors;

  Result({
    this.content,
    this.statusCode,
    this.scope,
    this.errors,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      content: json['content'],
      statusCode: json['statusCode'],
      scope: json['scope'],
      errors: json['errors'],
    );
  }
}