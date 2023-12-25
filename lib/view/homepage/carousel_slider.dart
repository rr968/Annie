import 'dart:async';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:build/main.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _stopAnimation();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _current = _current == 3 ? _current = 0 : _current + 1;
      });
    });
  }

  void _stopAnimation() {
    _timer?.cancel();
  }

  List<String> imgList = [
    "assets/carousel/carousel1.png",
    "assets/carousel/carousel3.png",
    "assets/carousel/carousel4.png",
    "assets/carousel/carousel2.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Center(
            child: AnimatedSwitcherTranslation.left(
                duration: const Duration(milliseconds: 1000),
                child: _current == 0
                    ? Image.asset(
                        key: const ValueKey(0),
                        imgList[0],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.fill,
                      )
                    : _current == 1
                        ? Image.asset(
                            key: const ValueKey(1),
                            imgList[1],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.fill,
                          )
                        : _current == 2
                            ? Image.asset(
                                key: const ValueKey(2),
                                imgList[2],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                key: const ValueKey(3),
                                imgList[3],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.fill,
                              ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return Container(
              width: 12.0,
              height: 12.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 15),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? pinkcolor
                      : Colors.black.withOpacity(.4)),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
