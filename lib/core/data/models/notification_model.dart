class NotifictionModel {
  int? id;
  String? sourceType;
  int? sourceId;
  String? userId;
  String? type;
  String? message;
  bool? isRead;
  String? senderId;
  String? createdAt;
  String? updatedAt;

  NotifictionModel({
    this.id,
    this.sourceType,
    this.sourceId,
    this.userId,
    this.type,
    this.message,
    this.isRead,
    this.senderId,
    this.createdAt,
    this.updatedAt,
  });

  NotifictionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sourceType = json['sourceType'];
    sourceId = json['sourceId'];
    userId = json['userId'];
    type = json['type'];
    message = json['message'];
    isRead = json['isRead'];
    senderId = json['senderId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sourceType'] = this.sourceType;
    data['sourceId'] = this.sourceId;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['message'] = this.message;
    data['isRead'] = this.isRead;
    data['senderId'] = this.senderId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
