import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const p_color = Color(0xFF219653);

class Info extends StatefulWidget {
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with TickerProviderStateMixin {
  // const Info({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('prevention').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // log(snapshot.data.docs.map((e) => log(e));
          return CircularProgressIndicator();
        }
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                /* Write listener code here */
              },
              child: Icon(
                Icons.menu, // add custom icons also
              ),
            ),
            title: Text('Information'),
          ),
          body: Column(
            children: [
              Container(
                // height: 48,

                color: Colors.white,
                child: TabBar(
                  indicatorColor: p_color,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  labelPadding: EdgeInsets.only(top: 15, bottom: 15),
                  controller: _tabController,
                  tabs: [
                    Text("COVID-19"),
                    Text("PREVENTION"),
                    Text("VACCINES"),
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
                    Center(
                      child: Text('Content 1'),
                    ),
                    Center(
                      child: Text('Content 2'),
                    ),
                    Center(
                      child: Text('Content 3'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
