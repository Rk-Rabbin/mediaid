import 'package:flutter/cupertino.dart';

class PrescriptionData {
  final ImageProvider image;
  final String title;
  final String category;
  final String details;

  PrescriptionData({
    required this.image,
    required this.title,
    required this.category,
    required this.details,
  });
}