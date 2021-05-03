import 'package:flutter/material.dart';
import 'package:flutter_demo/util/util.dart';

class UserTypeConponment extends StatelessWidget {
  const UserTypeConponment({
    Key? key,
    required String type,
  })  : _type = type,
        super(key: key);

  final String _type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      decoration: BoxDecoration(
          color: colorMap[_type] ?? Colors.green,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        enMap[_type] ?? '未知用户',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}
