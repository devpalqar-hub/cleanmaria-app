
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/SearchScreen/searchScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ShopScreen/ShopScreen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DashScreenScreen extends StatefulWidget {
   DashScreenScreen({Key?key}):super(key:key);

  @override
  State<DashScreenScreen> createState() => _DashScreenScreenState();
}

class _DashScreenScreenState extends State<DashScreenScreen> {
  
 int indexnum=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _getBody(indexnum),
      bottomNavigationBar: 
      BottomNavigationBar(
      items: [
      BottomNavigationBarItem(icon:Image.asset("assets/home.png",color:(indexnum!=0)?Color(0xff9DB2CE):Color(0xff17A5C6),
      height: 4.h,
      ) ,
      label: "Home"),
       BottomNavigationBarItem(icon:Image.asset("assets/search.png",color:(indexnum!=1)?Color(0xff9DB2CE):Color(0xff17A5C6),
      height: 4.h,
      ) ,
      label: "Search"),
       BottomNavigationBarItem(icon:Image.asset("assets/shop.png",color:(indexnum!=2)?Color(0xff9DB2CE):Color(0xff17A5C6),
      height: 4.h,
      ) ,
      label: "Shop"),
       BottomNavigationBarItem(icon:Image.asset("assets/cart.png",color:(indexnum!=0)?Color(0xff9DB2CE):Color(0xff17A5C6),
      height: 4.h,
      ) ,
      label: "Cart"),
      
      
      ],
      iconSize: 5.w,
      selectedFontSize: 11.sp,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: indexnum,
      unselectedFontSize: 11.sp,
      selectedItemColor: Color(0xff17A5C6),
      unselectedItemColor:Color(0xff9DB2CE) ,
      selectedLabelStyle: GoogleFonts.lexend(fontWeight: FontWeight.w400,fontSize: 10.sp),
      unselectedLabelStyle: GoogleFonts.lexend(fontWeight: FontWeight.w400,fontSize: 10.sp),
      onTap: (int index){
        setState(() {
          indexnum=index;
        });
      },
      ),
    );
  }
  Widget _getBody(int index){
  switch(index){
    case 0:
      return Homescreen();
     case 1:
      return SearchScreen();
       case 2:
      return Shopscreen();
      default:
         return Container();

  }
 }

}
