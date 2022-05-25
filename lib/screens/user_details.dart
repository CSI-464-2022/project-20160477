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

class UserDetails extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);
  @override
  State<UserDetails> createState() => _UserDetails();
}

// ignore: camel_case_types
class _UserDetails extends State<UserDetails> {
  // final registerkey = GlobalKey<FormState>();
  final detailskey = GlobalKey<FormState>();
  String? gender = "Other";
  DateTime dob = DateTime(1991, 12, 12);

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController =TextEditingController();
  final idController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final bioController = TextEditingController();


  @override
  void initState() {
    super.initState();
    dobController.text = '${dob.year}/${dob.month}/${dob.day}';
    emailController.addListener(() => setState(() {}));
    surnameController.addListener(() => setState(() {}));
    nameController.addListener(() => setState(() {}));
    idController.addListener(() => setState(() {}));
    // emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // print(email)

    bool isNew = context.read<AppProvider>().getIsNew();
    // User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        leading: !isNew
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  /* Write listener code here */
                },
                child: Icon(
                  Icons.arrow_back, // add custom icons also
                ),
              )
            : Container(width: 0),
        title: Text('Edit your Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Form(
          key: detailskey,
          child: ListView(
            children: [
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                isNew ? "Enter your details" : "Edit your details",
                style: TextStyle(fontSize: 18),
              ),
              // emailField(emailController),
              const SizedBox(
                height: 24,
              ),
              nameField(nameController),
              const SizedBox(
                height: 24,
              ),
              surnameField(surnameController),
              const SizedBox(
                height: 24,
              ),

              IdNoField(idController),
              const SizedBox(
                height: 24,
              ),
              dropDown(),
              const SizedBox(
                height: 24,
              ),
              birthDate(dobController),
              const SizedBox(
                height: 24,
              ),
              bioField(bioController),
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
                      if (detailskey.currentState!.validate()) {
                        detailskey.currentState!.save();
                        context.read<AppProvider>().setIsNew(false);
                        userDetails(isNew, nameController.text, surnameController.text, idController.text, gender!, dobController.text,bioController.text);
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

  Widget emailField(TextEditingController controller, String? init) => TextFormField(
      controller: controller,
      initialValue: init,
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

  Widget nameField(TextEditingController controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Name",
          hintText: "Name",
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.clear(),
                ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Name is required.';

          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      );
  Widget surnameField(TextEditingController controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Surname",
          hintText: "Surname",
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.clear(),
                ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Surname is required.';

          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      );
  Widget birthDate(TextEditingController controller) => TextFormField(
        controller: controller,
        readOnly: true,
        // enable: false,
        decoration: InputDecoration(
          labelText: "DOB.",
          hintText: "DOB",
          suffixIcon: IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: dob,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (newDate == null) return;
              setState(() {
                dob = newDate;
              });
              dobController.text = '${dob.year}/${dob.month}/${dob.day}';
            },
          ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Id No. is required.';

          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      );
  Widget IdNoField(TextEditingController controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Id No.",
          hintText: "Id No.",
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.clear(),
                ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Id No. is required.';
          if (value.length != 9) return "Id number must be 9 characters";
          return null;
        },
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
      );
  Widget bioField(TextEditingController controller) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: "Bio",
      hintText: "Bio",
      suffixIcon: controller.text.isEmpty
          ? Container(width: 0)
          : IconButton(
        icon: Icon(Icons.close),
        onPressed: () => controller.clear(),
      ),
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Bio is required.';

      return null;
    },
    minLines: 2,
    maxLines: 5,
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
  );
  Widget dropDown() {
    final items = [
      "Male",
      "Female",
      "Other"
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text("Gender"),
          value: gender,
          isExpanded: true,
          // iconSize: 36,
          icon: Icon(Icons.arrow_drop_down),
          items: items.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() {
            this.gender = value;
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

  Future<void> userDetails(bool isNew, String name, String surname, String idNo, String gender, String dob,String bio) async {
    //firebase auth instance to get uuid of user
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator()));
    //
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      var email = FirebaseAuth.instance.currentUser?.email;

      final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
      final json = {
        'email':email,
        'name': name,
        'surname': surname,
        'idNo': idNo,
        'gender': gender,
        'dob': dob,
        'bio':'bio'
      };
      await docUser.set(json).then((value) {
        Utils.showSnackBarSuccess("Details Successfully Saved");
        isNew
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              )
            : Navigator.pop(context);
      });
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
