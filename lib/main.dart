//import 'dart:html';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:csi494/screens/login.dart';

// import 'https://flutlab.io/root/app/lib/screens/Login.dart';
const p_color = Color(0xFF219653);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: p_color,
            // secondary: const Colors.yellow.shade700,
          ),
        ),
        home: Home());
  }
}

//Login screen
class Login extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> with TickerProviderStateMixin {
  // This widget is the root of your application.
  //const pa
  // bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 80),
              margin: EdgeInsets.only(top: 100, bottom: 40, left: 40, right: 40),
              child: SvgPicture.asset(
                'img/login.svg',
                width: 320,
                height: 192,
              ),
              // Image.asset('img/login.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              child: Card(
                child: Column(
                  children: [
                    // ButtonBar()
                    Container(
                      // height: 48,

                      color: p_color,
                      child: TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white54,
                        labelPadding: EdgeInsets.only(top: 15, bottom: 15),
                        controller: _tabController,
                        tabs: [
                          Text("Login"),
                          Text("Register"),
                        ],
                      ),
                    ),
                    Container(
                      // width: double.maxFinite,
                      // transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                      constraints: BoxConstraints.loose(Size(double.maxFinite, 340)),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            height: 260,
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                emailField(),
                                const SizedBox(
                                  height: 24,
                                ),
                                passwordField(),
                                const SizedBox(
                                  height: 24,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ButtonBar(
                                    // buttonPadding: EdgeInsets.only(bottom: 24),
                                    alignment: MainAxisAlignment.start,
                                    children: [
                                      RaisedButton(
                                        color: p_color,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          // Perform some action
                                        },
                                        child: Text("LOGIN"),
                                      ),
                                      FlatButton(
                                        textColor: p_color,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChangePassword(),
                                            ),
                                          );
                                        },
                                        child: const Text('FORGOT PASSWORD'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 320,
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                emailField(),
                                const SizedBox(
                                  height: 24,
                                ),
                                passwordField(),
                                const SizedBox(
                                  height: 24,
                                ),
                                password2Field(),
                                const SizedBox(
                                  height: 24,
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.start,
                                  children: [
                                    RaisedButton(
                                      color: p_color,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        // Perform some action
                                      },
                                      child: Text("REGISTER"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                  ], // padding: EdgeInsets.only(left: 18, right: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField() => TextField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "name@example.com",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next);

  Widget passwordField() => TextField(
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Password",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );
  Widget password2Field() => TextField(
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Confirm Password",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );
}

//change password
class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 80),
              margin: EdgeInsets.only(top: 40, bottom: 40, left: 40, right: 40),
              child: SvgPicture.asset(
                'img/fg_pass.svg',
                width: 320,
                height: 192,
              ),
              // Image.asset('img/login.png'),
            ),
            Card(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Forgot Pass",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        emailField(),
                        const SizedBox(
                          height: 24,
                        ),
                        passwordField(),
                        const SizedBox(
                          height: 24,
                        ),
                        password2Field(),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    // buttonPadding: EdgeInsets.only(bottom: 24),
                    alignment: MainAxisAlignment.start,
                    children: [
                      RaisedButton(
                        color: p_color,
                        textColor: Colors.white,
                        onPressed: () {
                          // Perform some action
                          Navigator.pop(context);
                        },
                        child: Text("CHANGE"),
                      ),
                      FlatButton(
                        textColor: p_color,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        child: const Text('CANCEL'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField() => TextField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "name@example.com",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next);

  Widget passwordField() => TextField(
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Password",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );
  Widget password2Field() => TextField(
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Confirm Password",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 24),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 124, left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Elliot Kgage",
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 57, bottom: 40, left: 40, right: 0),
                  transform: Matrix4.translationValues(120, 0.0, 0.0),
                  // transform: ,
                  child: SvgPicture.asset(
                    'img/doc.svg',
                    width: 328,
                    height: 237,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What do you need?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    // color: p_color,
                    width: 80,
                    height: 80,
                    // child: Column(
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: TextStyle(fontSize: 25),
//             ),
//           ],
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
