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
       
  
       body: SingleChildScrollView(
         child: Column(
           children: [
             Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Padding(
              padding: EdgeInsets.only(left: 14.w,top:41.h ),
              child: SizedBox(
                width: 115.w,
                height: 50.h,
                child:Image.asset("assets/bname.png",fit: BoxFit.fill,),
              ),
                     ),
                     Expanded(child: Container()),
             Icon(Icons.notifications,color: Colors.lightBlue,),
                     SizedBox(width: 6.w,)
              ],
             ),
              Padding(
           padding: EdgeInsets.only(left: 20.w),
           child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   
            children: [
              SizedBox(height: 15.h,),
               Padding(
                 padding:EdgeInsets.only(left: 10.w),
                 child: Row(
                  children: [
                    Text(
                      "Nice day,George",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "NunitoSans",
                        color: Colors.black,
                      ),
                    ),
                    Expanded(child: Container()),
                     appText.primaryText(text: "Last week",fontWeight: FontWeight.w400,fontSize: 11.sp),
                     Icon(Icons.arrow_drop_down),
                     SizedBox(width: 20.w,)
                          
                  ],
                             ),
               ),
                SizedBox(height: 15.h,),
              OverViewCard(),
               SizedBox(height: 15.h,),
              Text(
                      "Performance Analysis",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "NunitoSans",
                        color: Colors.black,
                      ),
                    ),  SizedBox(height: 15.h,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text( "From date",style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700 ,fontFamily: "NunitoSans")),
                        Container(width: 99.w,height: 28.h,
                          decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(6.w),border: Border.all(color: Colors.grey.shade100)
                              ),
                         child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 11.w,height: 20.h,child: Icon(Icons.calendar_month_outlined,size: 15.sp,),),
                            SizedBox(width: 8.w,)
                            ,Text( "22/10/2022",style:TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w600 ,fontFamily: "NunitoSans")),
                       ],
                         ),
                        )
                  ],
                ),
                 SizedBox(width: 15.w,),
                  Column(
                  children: [
                      Text( "From date",style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700 ,fontFamily: "NunitoSans")),
                       Container(width: 99.w,height: 28.h,
                        decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(6.w),border: Border.all(color: Colors.grey.shade100)
                              ),
                         child: Row(
                          children: [
                            SizedBox(width: 11.w,height: 20.h,child: Icon(Icons.calendar_month_outlined,size: 15.sp),),  SizedBox(width: 8.w,)
                            ,  Text( "22/10/2022",style:TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w600 ,fontFamily: "NunitoSans")),
                     
                          ],
                         ),
                        )
                  ],
                ),
 SizedBox(width: 35.w,),
                          
                Container(width:89.w,height: 26.h,
                decoration: BoxDecoration( color: Colors.blueAccent,borderRadius: BorderRadius.circular(6.w) ),
               
                alignment: Alignment.center,
                child:Text("Today",style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700 ,fontFamily: "NunitoSans",color: Colors.white),),),
                  
              ],
             ),
               SizedBox(height: 15.h,),
             detailcardScreen(),
              SizedBox(height: 15.h,),
             LineChartWidget(),
           Text("Cancellation",style:TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700 ,fontFamily: "NunitoSans",color: Colors.black),),
                    Cancellationcard(),
            ],
           ),
         ),
           ],
         ),
         
        
       ),
      
      ),
    );
  }
}