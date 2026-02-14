import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Regions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.add,
                color: Colors.blue,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}
