import 'package:elmohandes/features/invoice/domain/entities/pay_partial_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_partial.g.dart';

@JsonSerializable()
class PayPartialModel {
  String? message;

  PayPartialModel({this.message});

  PayPartialEntity toPayPartialEntity() {
    return PayPartialEntity(message: message);
  }
}
