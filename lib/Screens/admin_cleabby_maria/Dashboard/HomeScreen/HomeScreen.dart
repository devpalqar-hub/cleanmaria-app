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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: AppBar(
        
        leading:  Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: SizedBox(
            width: 115.w,
            height: 50.h,
            child:Image.asset("assets/bname.png",fit: BoxFit.fill,),
          ),
        ),
        
       actions: [
        Icon(Icons.notifications,color: Colors.lightBlue,),
        SizedBox(width: 6.w,)
       ],
       )),
       body: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.only(left: 20.w),
           child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   
            children: [
              SizedBox(height: 15.h,),
               Padding(
                 padding:EdgeInsets.only(left: 10.w),
                 child: Row(
                  children: [
                    appText.primaryText(text: "Nice day,George",fontSize: 18.sp,fontWeight: FontWeight.w700 ),
                    Expanded(child: Container()),
                     appText.primaryText(text: "Last week"),
                     Icon(Icons.arrow_drop_down),
                     SizedBox(width: 20.w,)
                          
                  ],
                             ),
               ),
                SizedBox(height: 15.h,),
              OverViewCard(),
               SizedBox(height: 15.h,),
              appText.primaryText(text: "Performance Analysis",fontSize: 18.sp,fontWeight: FontWeight.w700 ),
                SizedBox(height: 15.h,),
             Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     appText.primaryText(text: "From date",fontSize: 12.sp,fontWeight: FontWeight.w600 ),
                        Container(width: 110.w,height: 28.h,
                          decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(6.w),border: Border.all(color: Colors.grey.shade100)
                              ),
                         child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 11.w,height: 20.h,child: Icon(Icons.calendar_month_outlined),),
                            SizedBox(width: 15.w,)
                            ,appText.primaryText(text: "22/10/2022",fontSize: 10.sp,fontWeight: FontWeight.w500 ),
                          ],
                         ),
                        )
                  ],
                ),
                 SizedBox(width: 15.w,),
                  Column(
                  children: [
                     appText.primaryText(text: "To date",fontSize: 12.sp,fontWeight: FontWeight.w600 ),
                        Container(width: 100.w,height: 28.h,
                        decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(6.w),border: Border.all(color: Colors.grey.shade100)
                              ),
                         child: Row(
                          children: [
                            SizedBox(width: 11.w,height: 20.h,child: Icon(Icons.calendar_month_outlined),),  SizedBox(width: 15.w,)
                            ,appText.primaryText(text: "22/10/2022",fontSize: 10.sp,fontWeight: FontWeight.w500 ),
                          ],
                         ),
                        )
                  ],
                ),
 SizedBox(width: 35.w,),
                          
                Container(width:100.w,height: 40.h,
                decoration: BoxDecoration( color: Colors.blueAccent,borderRadius: BorderRadius.circular(6.w) ),
               
                alignment: Alignment.center,
                child:Text("Today",style: TextStyle(color: Colors.white, ),),)
                  
              ],
             ),
               SizedBox(height: 15.h,),
             detailcardScreen(),
              SizedBox(height: 15.h,),
             LineChartWidget(),
             appText.primaryText(text: "Cancellation",fontSize: 18.sp,fontWeight: FontWeight.w700 ),
             Cancellationcard(),
            ],
           ),
         ),
       ),
      
      ),
    );
  }
}