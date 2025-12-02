import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:gibas/features/auth/model/login_request.dart';
import 'package:gibas/features/auth/model/login_response.dart';

class AuthRepository extends Repository {
  Future<DataResult<LoginResponse>> login(LoginRequest body) async {
    return await dioService.post(
      url: Endpoint.login,
      body: body.toJson(),
      loading: true,
      fromJsonT: (data) => LoginResponse.fromJson(data),
    );
  }
    Future<DataResult<Auth>> profile() async {
    return await dioService.get(
      url: Endpoint.profile,
      loading: true,
      fromJsonT: (data) => Auth.fromJson(data),
    );
  }
}
