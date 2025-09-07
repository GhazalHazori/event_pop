class TokenInfo {
  String? accessToken;

  TokenInfo({this.accessToken});

  TokenInfo.fromJson(Map<String, dynamic> json) {
    accessToken = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.accessToken;
    return data;
  }
}
