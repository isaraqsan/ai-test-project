import 'package:gibas/domain/base/model_api.dart';

class LoginResponse extends ModelApi {
  String? accessToken;
  String? tokenType;
  String? expiredAt;

  LoginResponse({
    this.accessToken,
    this.tokenType,
    this.expiredAt,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiredAt = json['expired_at'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expired_at'] = expiredAt;
    return data;
  }
}
