import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homescreen extends StatefulWidget {
   Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: AppBar(
      
      leading:  Padding(
        padding:  EdgeInsets.all(8.w),
        child: SizedBox(
          width: 135.w,
          height: 50.h,
          child:Image.asset("assets/bname.png",fit: BoxFit.fill,),
        ),
      ),
      
     actions: [
      Icon(Icons.notifications,color: Colors.lightBlue,)
     ],
     )),
     body: Column(
      children: [
         Row(
          children: [
            appText.primaryText(text: "Nice day,George"),
            Expanded(child: Container()),
             appText.primaryText(text: "Last week"),
             Icon(Icons.arrow_drop_down),
             SizedBox(width: 20.w,)
     
          ],
        ),
        OverViewCard(),
        appText.primaryText(text: "Performance Analysis"),
       Row(
        children: [
          Column(
            children: [
               appText.primaryText(text: "From date"),
                  Container(width: 99.w,height: 28.h,
                   child: Row(
                    children: [
                      SizedBox(width: 11.w,height: 20.h,child: Icon(Icons.calendar_month_outlined),)
                      ,appText.primaryText(text: "22/10/2022"),
                    ],
                   ),
                  )
            ],
          ),
            Column(
            children: [
               appText.primaryText(text: "From date"),
                  Container(width: 99.w,height: 28.h,
                   child: Row(
                    children: [
                      SizedBox(width: 11.w,height: 20.h,child: Icon(Icons.calendar_month_outlined),)
                      ,appText.primaryText(text: "22/10/2022"),
                    ],
                   ),
                  )
            ],
          ),
          Container(width:100.w,height: 40.h,
          decoration: BoxDecoration( color: Colors.blueAccent,borderRadius: BorderRadius.circular(6.w) ),
         
          alignment: Alignment.center,
          child:Text("Today",style: TextStyle(color: Colors.white, ),),)
            
        ],
       ),
       detailcardScreen(),
      //  LineChartWidget(),
       appText.primaryText(text: "Cancellation"),
      //  Cancellationcard(),
      ],
     ),
    
    );
  }
}