import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';

class MultipartFileConverter implements JsonConverter<MultipartFile?, String?> {
  const MultipartFileConverter();

  @override
  MultipartFile? fromJson(String? json) {
    return null;
  }

  @override
  String? toJson(MultipartFile? object) {
    return object?.filename;
  }
}
