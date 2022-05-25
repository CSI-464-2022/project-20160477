import 'package:as1/main.dart';
import 'package:as1/screens/change_pass.dart';
import 'package:as1/screens/user_details.dart';
import 'package:as1/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

const p_color = Color(0xFF219653);

class Profile extends StatefulWidget {
  // Profile({Key key}) : super(key: key);

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const double divide = .40;
    //var assetsImage = new AssetImage('img/pro2.png'); //<- Creates an object that fetches an image.
    // var pro = new Image(image: assetsImage, fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            /* Write listener code here */
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
        title: Text('Profile'),
      ),
      body: Container(
        // padding: EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              // padding: EdgeInsets.only(left: 0, right: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * .35,
                    height: width * .35,
                    child: SvgPicture.asset(
                      'img/pp.svg',
                      width: 320,
                      height: 192,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(200),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Elliot Kgage',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'Male',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          '12/04/94',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            buttonPadding: EdgeInsets.zero,
                            children: [
                              RaisedButton(
                                color: p_color,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserDetails(),
                                    ),
                                  );
                                },
                                child: Text("Edit"),
                              ),
                              FlatButton(
                                textColor: p_color,
                                onPressed: () {
                                  logout();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Login(),
                                  //   ),
                                  // );
                                },
                                child: const Text('Logout'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Your Jabs',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(color: p_color, width: 1.5),
                    ),
                    width: width * divide,
                    height: width * (divide * .70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          // fit: ,
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              child: Text(
                                'Jab 1',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Icon(
                                Icons.check_circle,
                                color: p_color,
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            '12/04/22',
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 8,
                          ),
                          child: Text(
                            'Gabs DTMH',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: width * divide,
                    height: width * (divide * .70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Text(
                            'Jab 2',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            'None',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 25, left: 12, top: 25),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.5, color: Colors.grey),
                  bottom: BorderSide(width: 1.5, color: Colors.grey),
                ),
              ),
              margin: EdgeInsets.only(top: 60, left: 18, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  FlatButton(
                    // padding: EdgeInsets.zero,
                    textColor: p_color,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePassword(),
                        ),
                      );
                    },
                    child: const Text('Edit',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 25, left: 12, top: 25),
              decoration: BoxDecoration(
                border: Border(
                  // top: BorderSide(width: 2.0, color: Colors.grey),
                  bottom: BorderSide(width: 1.5, color: Colors.grey),
                ),
              ),
              margin: EdgeInsets.only(top: 0, left: 18, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Verify Vaccination",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  FlatButton(
                    // padding: EdgeInsets.zero,
                    textColor: p_color,
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Login(),
                      //   ),
                      // );
                    },
                    child: const Text('Verify',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future logout() async {
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signOut().then((value) => Utils.showSnackBarSuccess('Successfully Logged out'));
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
