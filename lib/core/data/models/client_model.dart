class Clientmodel {
  String? clientSecret;

  Clientmodel({this.clientSecret});

  Clientmodel.fromJson(Map<String, dynamic> json) {
    clientSecret = json['clientSecret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientSecret'] = this.clientSecret;
    return data;
  }
}