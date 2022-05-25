// import 'package:google_fonts/google_fonts.dart';
// ignore_for_file: deprecated_member_use

import 'package:as1/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutterapp/screens/';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:as1/screens/change_pass.dart';
import 'package:as1/screens/home.dart';
import 'package:as1/screens/user_details.dart';
import 'package:as1/utils.dart';
import 'package:provider/provider.dart';
import 'package:as1/providers/tab_provider.dart';
import 'package:as1/providers/app_provider.dart';

import '../main.dart';

const p_color = Color(0xFF219653);

class Login extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> with TickerProviderStateMixin {
  final registerkey = GlobalKey<FormState>();
  final loginkey = GlobalKey<FormState>();

  final emailController1 = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  String password = '';
  bool isPasswordVisible = true;
  @override
  void initState() {
    super.initState();

    emailController1.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    TabController _tabController = TabController(length: 2, initialIndex: context.read<TabIndex>().getIndex(), vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Your code goes here.
        context.read<TabIndex>().setIndex(_tabController.index);
        // To get index of current tab use tabController.index
      }
    });
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 80),
              margin: EdgeInsets.only(top: 80, bottom: 40, left: 40, right: 40),
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
                      constraints: BoxConstraints.loose(Size(double.maxFinite, 400)),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            height: 380,
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Form(
                              key: loginkey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  emailField(emailController1),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  passwordField(passwordController1),
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
                                            if (loginkey.currentState!.validate()) {
                                              loginkey.currentState!.save();
                                              signIn();
                                            }
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
                          ),
                          Container(
                            height: 320,
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Form(
                              key: registerkey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  emailField(emailController1),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  passwordField(passwordController1),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  password2Field(passwordController2),
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
                                          if (registerkey.currentState!.validate()) {
                                            registerkey.currentState!.save();
                                            // print('Submitted');
                                            context.read<AppProvider>().setIsNew(true);
                                            //context.read<UserData>().setJson(emailController1.text.trim(), passwordController1.text.trim());
                                            signUp();
                                            // setState(() {});
                                          }

                                          // Perform some action
                                        },
                                        child: Text("REGISTER"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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

  Widget emailField(TextEditingController controller) => TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "name@example.com",
        suffixIcon: controller.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => controller.clear(),
              ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email is required.';
        String pattern = r'\w+@\w+\.\w+';
        if (!RegExp(pattern).hasMatch(value)) return 'Invalid E-mail Address format.';
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done);

  Widget passwordField(TextEditingController controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Password",
          suffixIcon: IconButton(
            icon: isPasswordVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: () => setState(
              () => isPasswordVisible = !isPasswordVisible,
            ),
          ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Password is required.';
          // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
          if (value.length < 6) return "Password must be at least 6 characters";
          return null;
        },
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
      );
  Widget password2Field(TextEditingController controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Confirm Password",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Confirm your password";
          if (value != passwordController1.text) return "Password do not match";
          // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
          if (value.length < 6) return "Password must be at least 6 characters";
          return null;
        },
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );
  Future signIn() async {
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController1.text.trim(),
        password: passwordController1.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future signUp() async {
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController1.text,
            password: passwordController1.text,
          )
          .then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetails(),
                ),
              ));
    } on FirebaseAuthException catch (e) {
      context.read<AppProvider>().setIsNew(false);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

//       Future signIn() async{
// try{
//   await{

//  FirebaseAuth.instance.signInWithEmailAndPassword(
//                                                 email: emailController1.text,
//                                                 password: passwordController1.text,
//                                               );
//   }
//   on FirebaseAuthException catch (e){

//   }
// }
//       }
