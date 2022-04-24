import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'splach_screen.dart';

class pview extends StatefulWidget {
  @override
  _pview createState() => _pview();
}

class Data {
  final String title;
  final String descripthion;
  final String imageUrl;
  final IconData iconData;

  Data(
      {required this.title,
      required this.descripthion,
      required this.imageUrl,
      required this.iconData});
}

class _pview extends State<pview> {
  @override
  final List<Data> mydata = [
    Data(
        title: "title1",
        descripthion: "amal yosri developer ad el donya",
        imageUrl: "images/q1.jpg",
        iconData: Icons.account_balance),
    Data(
        title: "title2",
        descripthion: "amal yosri developer ad el donya",
        imageUrl: "images/q2.jpg",
        iconData: Icons.account_tree_outlined),
    Data(
        title: "title3",
        descripthion: "amal yosri developer ad el donya",
        imageUrl: "images/q3.jpg",
        iconData: Icons.adb_sharp),
  ];

  PageController _controller1 = PageController(initialPage: 0);
  int _currentindex = 0;

  // void initState() {
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 3), (timer) {
  //     if (_currentindex < 2) _currentindex++;

  //     _controller1.animateToPage(_currentindex,
  //         duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  //   });
  // }

  final _pageIndexNotifier = ValueNotifier(0);

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: {
        "/a": (context) => MyHomePage(),
        "/b": (context) => Splachscreen(),
      },
      home: Scaffold(
        body: Stack(
          children: [
            Builder(builder: (context) {
              return PageView(
                controller: _controller1,
                children: mydata
                    .map((item) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: ExactAssetImage(item.imageUrl),
                                  fit: BoxFit.cover)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  item.iconData,
                                  size: 170,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  item.title,
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  item.descripthion,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 28),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                onPageChanged: (val) {
                  _pageIndexNotifier.value = val;
                  setState(() {
                    _currentindex = val;

                    // if (_currentindex == 2) {
                    //   Future.delayed(Duration(seconds: 1),
                    //       () => Navigator.of(context).pushNamed("/b"));
                    // }
                  });
                },
              );
            }),
            Align(
              alignment: Alignment(0, 0.65),
              child: PageViewDotIndicator(
                currentItem: _pageIndexNotifier.value,
                count: mydata.length,
                unselectedColor: Colors.black54,
                selectedColor: Colors.red,
              ),
            ),
            // indicator(_currentindex),
            Builder(builder: (ctx) {
              return Align(
                alignment: Alignment(0, 0.97),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                      color: Colors.red,
                      padding: EdgeInsets.all(7),
                      child: Text(
                        "get started !",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      onPressed: () async {
                        Navigator.of(ctx).pushNamed("/b");
                        SharedPreferences _prefranc =
                            await SharedPreferences.getInstance();
                        _prefranc.setBool("x", true);
                      }),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class indicator extends StatelessWidget {
  @override
  final int index;
  final i = 0;
  indicator(this.index);

  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: Alignment(0, 0.68),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildcontainer(0, index == 0 ? Colors.red : Colors.green),
          buildcontainer(1, index == 1 ? Colors.red : Colors.green),
          buildcontainer(2, index == 2 ? Colors.red : Colors.green),
        ],
      ),
    );
  }

  Widget buildcontainer(int i, Color color) {
    return index == i
        ? Icon(Icons.star)
        : Container(
            height: 15,
            width: 15,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          );
  }
}
