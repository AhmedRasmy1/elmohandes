import 'package:elmohandes/features/auth/domain/entities/auth_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class Login {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? token;
  num? expiresIn;

  Login({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.token,
    this.expiresIn,
  });
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);

  LoginEntity toLoginEntity() {
    return LoginEntity(
      email: email,
      token: token,
    );
  }
}
