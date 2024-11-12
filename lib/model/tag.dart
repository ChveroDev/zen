import 'package:flutter/material.dart';

class Tag {
  int? id;
  late String tagName;
  late Color tagColor;

  Tag(this.tagName, this.tagColor);

  Tag.fromDatabase(this.id, this.tagName, this.tagColor);
}
