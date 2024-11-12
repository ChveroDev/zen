import 'package:flutter/widgets.dart';
import 'package:zen/mappers/mapper.dart';
import 'package:zen/model/tag.dart';

class TagMapper implements Mapper<Map<String, Object>, Tag> {
  @override
  Tag map(Map<String, dynamic> input) {
    return Tag.fromDatabase(
        input["id"], input["tagName"], Color(input["color"] as int));
  }
}
