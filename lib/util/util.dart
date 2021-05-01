import 'package:flutter/material.dart';

double toRpx(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.width / 428.0;
}
