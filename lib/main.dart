import 'dart:io';

import 'package:amal1project/my_color.dart';
import 'package:amal1project/pageview.dart';
import 'package:amal1project/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefranc = await SharedPreferences.getInstance();

  bool? desion = _prefranc.getBool("x");
  Widget _screen = (desion == false || desion == null) ? pview() : MyHomePage();
  runApp(MaterialApp(home:pview()));
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum AuthMode { signup, login }

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _x = GlobalKey<ScaffoldState>();
  String str = "";
  List image1 = [
    "images/s1.jpg",
    "images/s2.jpg",
    "images/s3.jpg",
  ];
  int _currentindex = 0;
  int _radiovalue = 0;
  String result = "";
  Color resultcolor = Colors.amber;
  bool js = false;
  bool csharp = false;
  String get txt1 {
    String str = "you selected:\n";
    if (js == true) str += "java script\n";
    if (csharp == true)
      str += "c#\n";
    else
      str += "none";
    return str;
  }

  ThemeMode tm = ThemeMode.light;
  bool _swval = false;
  List<String> letterlist = ["a", "s", "a", "d", "f"];
  String? _selectecdletter;

  final ImagePicker _picker = ImagePicker();
  File? pickredimage;
  fatchpickar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      pickredimage = File(image.path);
    });
  }

  Color currentcolor = Colors.teal;
  void changecolor(Color color) {
    setState(() {
      currentcolor = color;
    });
  }

  final li = List<String>.generate(20, (index) => "item num ${index + 1}");
  static const namelist = [
    "apr",
    "feb",
    "JAn",
    "amal",
    "yasmin",
    "ahmed",
    "shiko",
    "mama",
    "baba"
  ];
  List<Color> colorlist =
      List.generate(namelist.length, (index) => Colors.primaries[index]);

  AuthMode _authMode = AuthMode.login;
  Map<String, String> _authData = {"email": " ", "password": " "};

  final _passcontrollar = TextEditingController();
  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    int i = 0;
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.pink, canvasColor: Colors.white),
        themeMode: tm,
        darkTheme:
            ThemeData(primaryColor: Colors.blue, canvasColor: Colors.teal),
        home: Scaffold(
            key: _x,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                    Expanded(
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add))),
                  ],
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              ],
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.blueGrey,
                  Colors.pinkAccent,
                ])),
              ),
              title: Text(
                "amal",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: signin_login_Form()));
  }

  Center mycolorMethod() {
    return Center(
            child: Mycolor(
              child: Builder(builder: (context) {
                return Text(
                  "Mycolor",
                  style: TextStyle(
                      fontSize: 35,
                      backgroundColor: Mycolor.of(context).color),
                );
              }),
              color: Colors.blue,
            ),
          );
  }

  Center signin_login_Form() {
    return Center(
        child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty || !val.contains("@")) {
                          return "Invalid email";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _authData["email"] = val!;
                        print(_authData["email"]);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passcontrollar,
                      decoration: InputDecoration(labelText: "password"),
                      obscureText: true,
                      validator: (val) {
                        if (val!.isEmpty || val.length <= 5) {
                          return "Invalid password";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _authData["pass"] = val!;
                        print(_authData["pass"]);
                      },
                    ),
                    if (_authMode == AuthMode.signup)
                      TextFormField(
                          enabled: _authMode == AuthMode.signup,
                          decoration:
                              InputDecoration(labelText: "confirm password"),
                          obscureText: true,
                          validator: _authMode == AuthMode.signup
                              ? (val) {
                                  if (val != _passcontrollar.text) {
                                    return "Invalid confirm password";
                                  }
                                  return null;
                                }
                              : null),
                    RaisedButton(
                      onPressed: _submit,
                      child: Text(
                          _authMode == AuthMode.login ? "login" : "signup"),
                    ),
                    FlatButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                            "${_authMode == AuthMode.login ? "sign up" : "login"} insted "))
                  ],
                ),
              ),
            )));
  }

  void _submit() {
    if (_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
  }

  InteractiveViewer zoom() {
    return InteractiveViewer(
        boundaryMargin: EdgeInsets.all(50),
        constrained: false,
        panEnabled: true,
        scaleEnabled: true,
        minScale: 0.3,
        maxScale: 4,
        child: Image.asset(
          "images/s2.jpg",
          fit: BoxFit.cover,
        ));
  }

  Center listwheel(int i) {
    return Center(
        child: ListWheelScrollView(
      itemExtent: 200,
      children: [
        ...namelist.map((String name) {
          return Container(
            decoration: BoxDecoration(color: colorlist[i++]),
            child: Center(
              child: Text(name),
            ),
          );
        })
      ],
    ));
  }

  ListView persentIndicator_circular_linear() {
    return ListView(
      children: [
        CircularPercentIndicator(
          radius: 100,
          lineWidth: 10.0,
          percent: 0.9,
          progressColor: Colors.orange,
          backgroundColor: Colors.grey,
          animation: true,
          animationDuration: 1200,
          header: Text("mackdonal's"),
          center: Icon(Icons.access_time),
          circularStrokeCap: CircularStrokeCap.butt,
        ),
        LinearPercentIndicator(
          width: 200.0,
          lineHeight: 20.0,
          percent: 0.5,
          center: Text("50%"),
          trailing: Icon(Icons.mood),
          leading: Text("happy mood"),
          backgroundColor: Colors.grey,
          progressColor: Colors.pink,
          animation: true,
          animationDuration: 700,
          linearStrokeCap: LinearStrokeCap.roundAll,
        )
      ],
    );
  }

  Future<ListView> swip_dismissible(BuildContext context) async {
    return ListView.builder(
      itemCount: li.length,
      itemBuilder: (ctx, index) {
        final item = li[index];
        return Dismissible(
          child: ListTile(
            title: Center(
              child: Text(item),
            ),
          ),
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              li.removeAt(index);
            });
            Scaffold.of(ctx).showSnackBar(SnackBar(
              content: Text(dir == DismissDirection.startToEnd
                  ? "$item delet"
                  : "$item liked"),
              action: SnackBarAction(
                  label: "undo",
                  onPressed: () {
                    setState(() {
                      li.insert(index, item);
                    });
                  }),
            ));
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.delete),
                Text("delete"),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.green,
            alignment: Alignment.centerRight,
            child: Icon(Icons.thumb_up),
          ),
          confirmDismiss: (DismissDirection dir) async {
            if (dir == DismissDirection.startToEnd) {
              final res = await showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      content: Text("do you want to delete $item"),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("cancel")),
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                li.removeAt(index);
                              });
                              Navigator.of(ctx).pop();
                            },
                            child: Text("delet")),
                      ],
                    );
                  });

              return res;
            } else {
              return true;
            }
          },
        );
      },
    );
  }

  Center colorpicker(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("click me !"),
          color: currentcolor,
          textColor: useWhiteForeground(currentcolor)
              ? Color(0xffffffff)
              : Color(0xff000000),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text("select color"),
                      content: SingleChildScrollView(
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            ColorPicker(
                              pickerColor: currentcolor,
                              onColorChanged: changecolor,
                              enableAlpha: false,
                              displayThumbColor: true,
                              colorPickerWidth: 200,
                              pickerAreaHeightPercent: 0.7,
                              showLabel: true,
                              paletteType: PaletteType.hsv,
                              pickerAreaBorderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(50.0),
                              ),
                            ),
                            RaisedButton(
                                child: Text("close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        ),
                      ));
                });
          }),
    );
  }

  Center slidepicker(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("click me !"),
          color: currentcolor,
          textColor: useWhiteForeground(currentcolor)
              ? Color(0xffffffff)
              : Color(0xff000000),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text("select color"),
                      content: SingleChildScrollView(
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            SlidePicker(
                              pickerColor: currentcolor,
                              onColorChanged: changecolor,
                              enableAlpha: false,
                              displayThumbColor: true,
                              showIndicator: true,
                              indicatorBorderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                            RaisedButton(
                                child: Text("close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        ),
                      ));
                });
          }),
    );
  }

  Center materialpicker(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("click me !"),
          color: currentcolor,
          textColor: useWhiteForeground(currentcolor)
              ? Color(0xffffffff)
              : Color(0xff000000),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text("select color"),
                      content: SingleChildScrollView(
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            MaterialPicker(
                              pickerColor: currentcolor,
                              onColorChanged: changecolor,
                              enableLabel: true,
                            ),
                            RaisedButton(
                                child: Text("close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        ),
                      ));
                });
          }),
    );
  }

  Center blockpicker(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("click me1"),
          color: currentcolor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("select color"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SingleChildScrollView(
                          child: BlockPicker(
                            onColorChanged: changecolor,
                            pickerColor: currentcolor,
                          ),
                        ),
                        RaisedButton(
                            child: Text("close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  );
                });
          }),
    );
  }

  Center photo() {
    return Center(
        child: pickredimage == null ? null : Image.file(pickredimage!));
  }

  Padding marqueeMethod() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.pink[100],
        height: 50,
        child: Marquee(
          text: "simple text",
          blankSpace: 10,
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          // pauseAfterRound: Duration(seconds: 1),
          accelerationDuration: const Duration(microseconds: 50),
        ),
      ),
    );
  }

  ExpansionTile exsample() {
    return ExpansionTile(
        leading: const Icon(Icons.account_circle_rounded),
        title: const Text("account"),
        backgroundColor: Colors.red[100],
        collapsedBackgroundColor: Colors.green[100],
        collapsedIconColor: Colors.amber,
        children: [
          const Divider(
            color: Colors.green,
          ),
          Card(
            color: Colors.teal,
            child: ListTile(
              title: const Text("account1"),
              subtitle: const Text("enter data"),
              onTap: snackbarMethod,
            ),
          )
        ]);
  }

  DropdownButton dropdowenlist() {
    return DropdownButton(
      hint: const Text("selected item"),
      alignment: Alignment.center,
      value: _selectecdletter,
      onChanged: (val) {
        setState(() {
          _selectecdletter = val.toString();
        });
      },
      items: letterlist.toSet().map((values) {
        return DropdownMenuItem(
          value: values,
          child: Text(values),
        );
      }).toList(),
    );
  }

  Center swichthemeMethod() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: Text("light"),
          ),
          Switch(
            value: _swval,
            onChanged: (bool val) {
              setState(() {
                _swval = val;
                if (_swval == false)
                  tm = ThemeMode.light;
                else
                  tm = ThemeMode.dark;
              });
            },
            activeColor: Colors.black,
            inactiveThumbColor: Colors.blue,
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: Text("dark"),
          ),
        ],
      ),
    );
  }

  Padding checkbox_or_checkboxlisttileMethod(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        CheckboxListTile(
          value: js,
          onChanged: (val) {
            setState(() {
              js = val as bool;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text("js"),
        ),
        Row(
          children: [
            Checkbox(
              value: csharp,
              onChanged: (val) => setState(() => csharp = val as bool),
            ),
            Text("c#")
          ],
        ),
        RaisedButton(
            child: Text("Apply now"),
            onPressed: () {
              final ad = AlertDialog(
                title: Text("Thank you for Apply"),
                content: Text(txt1),
              );
              showDialog(context: context, builder: (context) => ad);
            })
      ]),
    );
  }

  RadioListTile<dynamic> RadiolisttileMethod(value, txt, subtext) {
    return RadioListTile(
      value: value,
      groupValue: _radiovalue,
      onChanged: (val) => setState(() {
        _radiovalue = val;
      }),
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text(txt),
      subtitle: Text(subtext),
    );
  }

  Row RadioMethod(int value1) {
    mydialog() {
      final alert = AlertDialog(
        content: Container(
          height: 100,
          child: Column(
            children: [
              Text(
                result,
                style: TextStyle(color: resultcolor),
              ),
              const Divider(
                color: Colors.black,
              ),
              const Text("answer is = 4"),
            ],
          ),
        ),
      );
      showDialog(context: context, builder: (context) => alert);
    }

    return Row(
      children: [
        Radio(
            value: value1,
            groupValue: _radiovalue,
            onChanged: (val) {
              setState(() {
                _radiovalue = val as int;
                result = value1 == 4 ? "Right answer" : "wrong answer";
                resultcolor = value1 == 4 ? Colors.green : Colors.red;
                mydialog();
              });
            }),
        Text("$value1")
      ],
    );
  }

  CarouselSlider way2_To_Do_slider_By_Using_Index() {
    return CarouselSlider.builder(
        itemCount: image1.length,
        itemBuilder: (_, int index, int pageViewIndex) {
          return Container(
            width: double.infinity,
            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(image1[index], fit: BoxFit.fill),
          );
        },
        options: CarouselOptions(
          height: 130,
          initialPage: 1,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 1),
          enableInfiniteScroll: false,
          pauseAutoPlayOnTouch: false,
          reverse: true,
          scrollDirection: Axis.vertical,
        ));
  }

  CarouselSlider way1_To_Do_Slider_With_Map() {
    return CarouselSlider(
        items: image1.map((imageurl) {
          return Container(
            width: double.infinity,
            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(imageurl, fit: BoxFit.fill),
          );
        }).toList(),
        options: CarouselOptions(
            height: 130,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 1),
            onPageChanged: (index, _) {
              setState(() {
                _currentindex = index;
              });
            }));
  }

  Container pointofslider(index) {
    return Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentindex == index ? Colors.pinkAccent : Colors.grey,
        ));
  }

  Column overflow_softwrap_selectabletext() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SelectableText(
          "i am amal yosry",
          showCursor: true,
          cursorColor: Colors.green,
          cursorWidth: 10,
          style: TextStyle(fontSize: 30),
          toolbarOptions: ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        Container(
            color: Colors.yellow,
            width: 200,
            height: 25,
            child: Text(
              ";a;a;;a;a;;a;;adlslldapsdladijdkdksdjccls;askdoaksdksodjsd;akosdkqowkdqkllllllllllllllllllllllllllll",
              overflow: TextOverflow.clip,
            )),
        SizedBox(
          height: 30,
        ),
        Container(
            color: Colors.yellow,
            width: 200,
            height: 25,
            child: Text(
              ";a;a;;a;a;;a;;adlslldapsdladijdkdksdjccls;askdoaksdksodjsd;akosdkqowkdqkllllllllllllllllllllllllllll",
              overflow: TextOverflow.ellipsis,
            )),
        SizedBox(
          height: 30,
        ),
        Container(
            color: Colors.yellow,
            width: 200,
            height: 25,
            child: Text(
              ";a;a;;a;a;;a;;adlslldapsdladijdkdksdjccls;askdoaksdksodjsd;akosdkqowkdqkllllllllllllllllllllllllllll",
              overflow: TextOverflow.fade,
            )),
        SizedBox(
          height: 30,
        ),
        Container(
            color: Colors.yellow,
            width: 200,
            height: 25,
            child: Text(
              ";a;a;;a;a;;a;;adlslldapsdladijdkdksdjccls;askdoaksdksodjsd;akosdkqowkdqkllllllllllllllllllllllllllll",
              overflow: TextOverflow.visible,
            )),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void flushbarMethod(BuildContext context) {
    Flushbar(
      duration: Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("undo!")),
      icon: Icon(
        Icons.info,
        color: Colors.cyanAccent,
      ),
      backgroundColor: Colors.purple,
      title: "ahmed nelaa",
      messageText: Text("amal mobile developer"),
      borderRadius: BorderRadius.circular(30),
      margin: EdgeInsets.all(30),
    ).show(context);
  }

  void snackbarMethod() {
    final sbar = SnackBar(
      content: Text("welcome home"),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.purple[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      action: SnackBarAction(
        label: "undo!",
        onPressed: () => setState(() => str = "flutter demo!"),
      ),
    );

    // ignore: deprecated_member_use
    _x.currentState?.showSnackBar(sbar);
  }

  void alertdiaglog1(BuildContext context) {
    final alert = AlertDialog(
      title: Text("dialog"),
      content: SizedBox(
        height: 170,
        child: Column(
          children: [
            Divider(
              color: Colors.red,
            ),
            Text("amal yosri Ahmed mobile develober"),
            SizedBox(
              height: 30,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("close"),
                    Icon(Icons.ac_unit),
                  ],
                ))
          ],
        ),
      ),
    );
    showDialog(
        builder: (context) => alert,
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.greenAccent[200]?.withOpacity(0.3));
  }

  void showtoast1(BuildContext context) {
    showToast('This is normal toast with animation',
        context: context,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: const StyledToastPosition(
            align: Alignment.bottomCenter, offset: 140.0),
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        backgroundColor: Colors.amberAccent);
  }
}
