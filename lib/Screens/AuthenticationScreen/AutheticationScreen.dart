//import 'package:cleanby_maria/Screens/DashBoardScreen/DashBoardScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/Dashboard/DashboardScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/DashBoardScreen/Controller/DashBoardScreen.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/appTextField.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
           children: [
             SizedBox(height: 141.h,),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 71.w),
               child: Image.asset("assets/bname.png",
               height:103.h,
               width:247.w
               ),
             ),
           SizedBox(height:37.h),
             appText.primaryText(text: "Welcome Black",
              fontSize: 24.sp,
                   fontWeight: FontWeight.w500,
                   color: Color(0xFF000000)),
           SizedBox(height: 40.h),
             Apptextfield.primary(
                     labelText: 'Email*',
                 hintText: 'test@example.com',
                 //controller: busNameController,
                 ),
          
             Apptextfield.primary(
                     labelText: 'Password',
                 hintText: 'Password',
                 //controller: busNameController,
                 ),
           SizedBox(height:20.h),
           Padding(
             padding:  EdgeInsets.fromLTRB(149.w,0,30 .w,0 ),
             child: RichText(
             text: TextSpan(
             children: [
             TextSpan(
             text: "Having issues? ",
             style: TextStyle(
             fontSize: 14.sp,
             fontWeight: FontWeight.w600,
             color: Color(0xFF000000), 
             fontFamily: 'NunitoSans',
                     ),
                   ),
             TextSpan(
             text: "Reset Password",
             style: TextStyle(
             fontSize: 14.sp,
             fontWeight: FontWeight.w600,
             color: Color(0xFF19A4C6), 
                     ),
                   ),
                 ],
               ),
             ),
           ),
      
      
           SizedBox(height: 100.h),
             appButton(text: "Login", onPressed: () {
                       Navigator.pushReplacement(
                                 context,
                        MaterialPageRoute(builder: (context) => Homescreen()),);},
               
               
             isPrimary: true,
            // isLoading: true, 
             ),
             ],
      
         
       ),
    );
  }
}