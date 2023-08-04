class SaveSapphireElectricityFlow {
  Result? result;
  int? id;
  String? exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  int? creationOptions;
  String? asyncState;
  bool? isFaulted;

  SaveSapphireElectricityFlow(
      {this.result,
        this.id,
        this.exception,
        this.status,
        this.isCanceled,
        this.isCompleted,
        this.creationOptions,
        this.asyncState,
        this.isFaulted});

  SaveSapphireElectricityFlow.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['id'] = this.id;
    data['exception'] = this.exception;
    data['status'] = this.status;
    data['isCanceled'] = this.isCanceled;
    data['isCompleted'] = this.isCompleted;
    data['creationOptions'] = this.creationOptions;
    data['asyncState'] = this.asyncState;
    data['isFaulted'] = this.isFaulted;
    return data;
  }
}

class Result {
  String? content;
  String? statusCode;
  String? scope;
  String? errors;

  Result({this.content, this.statusCode, this.scope, this.errors});

  Result.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    statusCode = json['statusCode'];
    scope = json['scope'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['statusCode'] = this.statusCode;
    data['scope'] = this.scope;
    data['errors'] = this.errors;
    return data;
  }
}