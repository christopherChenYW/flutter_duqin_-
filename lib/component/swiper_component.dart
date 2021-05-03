import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class SwiperComponent extends StatefulWidget {
  final List swiperList;

  const SwiperComponent({Key? key, required this.swiperList}) : super(key: key);

  @override
  _SwiperComponentState createState() => _SwiperComponentState();
}

class _SwiperComponentState extends State<SwiperComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Swiper(
          duration: 1000,
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return widget.swiperList[index];
          },
          itemCount: 3,
          pagination: new SwiperPagination(alignment: Alignment.bottomRight),
          // control: new SwiperControl(),
          itemWidth: 500.0,
          layout: SwiperLayout.STACK,
        ),
      ),
    );
  }
}
