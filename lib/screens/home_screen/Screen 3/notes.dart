import 'package:flutter/material.dart';
import 'package:project_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.all(getScreenWidth(10)),
                  height: 150,
                  color: Colors.grey[700],
                );
              });
        });
  }
}
