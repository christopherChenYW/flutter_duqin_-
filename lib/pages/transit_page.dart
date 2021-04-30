import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/index_page.dart';

class TransitPage extends StatefulWidget {
  @override
  _TransitPageState createState() => _TransitPageState();
}

class _TransitPageState extends State<TransitPage> {
  int _currentTime = 3;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      this.setState(() {
        if (_currentTime <= 0) {
          _jumpHomePage();
        } else
          _currentTime--;
      });
    });
  }

  void _jumpHomePage() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return IndexPage(
        initIndex: 0,
      );
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/common/page.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            child: InkWell(
              child: _skipButton(),
              onTap: _jumpHomePage,
            ),
            top: MediaQuery.of(context).padding.top + 10, //获取取上边刘海高度
            right: 20,
          )
        ],
      ),
    );
  }

//跳过按钮
  Widget _skipButton() {
    return Opacity(
      opacity: 0.5,
      child: ClipOval(
        child: Container(
          width: 70,
          height: 70,
          color: Colors.black.withOpacity(0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "跳过",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                "${_currentTime}s",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
