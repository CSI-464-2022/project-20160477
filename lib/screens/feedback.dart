// import 'package:google_fonts/google_fonts.dart';
// ignore_for_file: deprecated_member_use

import 'package:as1/screens/home.dart';
import 'package:as1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:as1/utils.dart';
import 'package:as1/utils.dart';

import '../main.dart';

// import 'package:flutterapp/screens/';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:as1/utils.dart';
import 'package:provider/provider.dart';
// import 'package:as1/providers/user_provider.dart';
// import '../main.dart';
import 'package:as1/providers/app_provider.dart';

const p_color = Color(0xFF219653);

class UserFeedback extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);
  @override
  State<UserFeedback> createState() => _UserFeedback();
}

// ignore: camel_case_types
class _UserFeedback extends State<UserFeedback> {
  // final registerkey = GlobalKey<FormState>();
  final feedbackkey = GlobalKey<FormState>();
  String? type = "App Bug";

  final typeController = TextEditingController();
  final locationController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    typeController.addListener(() => setState(() {}));
    locationController.addListener(() => setState(() {}));
    descController.addListener(() => setState(() {}));
    // emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // print(email)

    // User? user = FirebaseAuth.instance.currentUser;
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
        title: Text('Feedback'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Form(
          key: feedbackkey,
          child: ListView(
            children: [
              const SizedBox(
                height: 24,
              ),
              Text('Type of Feedback'),
              dropDown(),
              // emailField(emailController),
              const SizedBox(
                height: 24,
              ),
            locationField(locationController),
              const SizedBox(
                height: 24,
              ),
              descField(descController),
              const SizedBox(
                height: 24,
              ),

             // IdNoField(idController),

              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  RaisedButton(
                    color: p_color,
                    textColor: Colors.white,
                    onPressed: () {
                      if (feedbackkey.currentState!.validate()) {
                        feedbackkey.currentState!.save();
                        // signIn();
                        subMitFeedback(locationController.text, descController.text,type!, context);
                        // print("Submitted");
                      }
                    },
                    child: Text("Save"),
                  ),
                  // Container(
                  //   child: isNew
                  //       ? Container(width: 0)
                  //       : FlatButton(
                  //           color: p_color,
                  //           textColor: Colors.white,
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //             // Perform some action
                  //           },
                  //           child: Text("Cancel"),
                  //         ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //
  }

  Widget locationField(TextEditingController controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Location",
          hintText: "Location, type None if there's no location",
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.clear(),
                ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Location is required.';

          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      );
  Widget descField(TextEditingController controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Description",
          hintText: "Description",
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.clear(),
                ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Description is required.';

          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      );


  Widget dropDown() {
    final items = [
      "App Bug",
      "Discrimination",
      "Lack Of Service"
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text("type"),
          value: type,
          isExpanded: true,
          // iconSize: 36,
          icon: Icon(Icons.arrow_drop_down),
          items: items.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() {
            this.type = value;
          }),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Future<void> subMitFeedback( String location, String desc, String type, BuildContext context ) async {
    //firebase auth instance to get uuid of user
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator()));
    //
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      final docUser = FirebaseFirestore.instance.collection('feedback').doc();
      final json = {
        'uid': uid,
        'type':type,
        'location': location,
        'description': desc,
        'timestamp':DateTime.now().millisecondsSinceEpoch
      };
      await docUser.set(json).then((value) {
        Utils.showSnackBarSuccess("Feedback Successfully Submitted");

      }).then((value) =>   Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserFeedback(),
        ),
      ));
    } else {
      return;
      // User logged in
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // FirebaseAuth.instance.currentUser!;

    //now below I am getting an instance of firebaseiestore then getting the user collection
    //now I am creating the document if not already exist and setting the data.
    //  Firebase.instance.collection('Users').document(auth.uid).setData(
    //  {
    //   'displayName': displayName, 'uid': uid
    //  })

    return;
  }
}
