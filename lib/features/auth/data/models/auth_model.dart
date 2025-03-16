import '../../domain/entities/auth_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class Login {
  String? userName;
  String? role;
  String? token;

  Login({
    this.userName,
    this.role,
    this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);

  LoginEntity toLoginEntity() {
    return LoginEntity(
      userName: userName,
      role: role,
      token: token,
    );
  }
}
