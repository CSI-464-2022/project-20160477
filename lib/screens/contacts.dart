import 'package:as1/main.dart';
import 'package:as1/screens/chat.dart';
import 'package:as1/screens/home.dart';
import 'package:as1/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:as1/providers/app_provider.dart';
import 'login.dart';
import '../widgets/message.dart';
import '../main.dart';

const p_color = Color(0xFF219653);
class Contacts extends StatefulWidget {

  @override
  _contactsState createState() => _contactsState();
}

class _contactsState extends State<Contacts> {


  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();
  final contactController = TextEditingController();
  final contactKey = GlobalKey<FormState>();
  void initState() {
    super.initState();

    contactController.addListener(() => setState(() {}));
  }

  Stream<QuerySnapshot> _contactsStream = FirebaseFirestore.instance
      .collection('contacts')
      .where('uid',isEqualTo:FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
   // context.read
    return StreamBuilder(
      stream: _contactsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          
          return Center(child: Text("something is wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(

            appBar: AppBar(
              title: Text(
                'Contacts',
              ),
              actions: [
              ],
            ),
          body: SingleChildScrollView(

            child: Column(
              children: [
                SizedBox(height: 24),
                Form(
                  key: contactKey,
                  child: Column(
                    children: [
                      Container(
                                    padding:EdgeInsets.all(8),

                                    child: TextFormField(
                                    controller: contactController,
                                    decoration: InputDecoration(
                                      labelText: "Email of Contact",
                                      hintText: "name@example.com",
                                      suffixIcon: contactController.text.isEmpty
                                          ? Container(width: 0)
                                          : IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () => contactController.clear(),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Email of Contact is required.';
                                      String pattern = r'\w+@\w+\.\w+';
                                      if (!RegExp(pattern).hasMatch(value)) return 'Invalid E-mail Address format.';
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done
                                    ),
                                  ),
            RaisedButton(
              color: p_color,
              textColor: Colors.white,
              onPressed: () {
                if (contactKey.currentState!.validate()) {
                  contactKey.currentState!.save();
                  // print('Submitted');

                  //context.read<UserData>().setJson(emailController1.text.trim(), passwordController1.text.trim());
                  addContact(contactController.text);
                  // setState(() {});
                }

                // Perform some action
              },
              child: Text("Add"),
            ),
                    ],
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(top: 15, left: 10,right: 10),

                    decoration: BoxDecoration(
                      border: Border(
                        // top: BorderSide(width: 2.0, color: Colors.grey),
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                    )
                ),
                ListView.builder(

                  itemCount: snapshot.data!.docs.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  itemBuilder: (_, index) {
                    QueryDocumentSnapshot qs = snapshot.data!.docs[index];
                    //Timestamp  = qs['time'];
                    //DateTime d = t.toDate();
                    //print(d.toString());

                    return  contactCard(qs['email'],qs['name']);


                      Text(qs['email']);

                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> addContact( String email) async {
    //firebase auth instance to get uuid of user
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator()));
    //
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      final docUser = FirebaseFirestore.instance.collection('contacts').doc();
      QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo:email).get();
     //print(query.docs[0].get('email'));
      if (query.docs.length==0) {
        Utils.showSnackBarSuccess("${email} is not found");

      }
      else {
        final json = {
          'uid': uid,
          'name':query.docs[0].get('name')+" "+query.docs[0].get('surname'),
          'email':email,
          'timeAdded':DateTime.now().millisecondsSinceEpoch
        };
        await docUser.set(json).then((value) {
          Utils.showSnackBarSuccess("${email} added as a contact");
        }).then((value) =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>Contacts(),
              ),
            )
        );
        //Go to the login screen


      }
      // final json = {
      //   'uid': uid,
      //   'email':email,
      //   'timeAdded':DateTime.now().millisecondsSinceEpoch
      // };
      // await docUser.set(json).then((value) {
      //   Utils.showSnackBarSuccess("${email} added as a contact");


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
  Widget contactCard(String email, String name)=>GestureDetector(
    onTap: () {
     // context.read<AppProvider>().set
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Chat(email: email),
        ),
      );
      // Perform some action
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 2.0, color: Colors.grey),
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
margin: EdgeInsets.only( left: 10,right: 10),
padding: EdgeInsets.all(10),
child: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(email),
      Text(name)
    ],
),
        ),
  );
}