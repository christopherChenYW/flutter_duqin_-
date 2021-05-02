import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingCircle extends StatefulWidget {
  final bool visible;

  LoadingCircle({Key? key, this.visible = false}) : super(key: key);
  @override
  _LoadingCircleState createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.visible,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: SpinKitFadingCircle(
            color: Colors.grey,
            size: 70,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 2000)),
          ),
        ),
      ),
    );
  }
}
