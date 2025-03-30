import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/CartScreen/Cartscreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/SearchScreen/searchScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ShopScreen/ShopScreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int indexNum = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            if (indexNum == 0)
              Expanded(child:Homescreen())
            else if (indexNum == 1)
              Expanded(child: SearchScreen())
            else if (indexNum == 2)
              Expanded(child: Shopscreen())
            else if (indexNum == 3)
              Expanded(child: CartScreen())
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width:68.sp ,
                  height: 45.sp,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/home_icon.png",
                        color:
                            (indexNum != 0) ? Color(0xff5E5F60) : Color(0xFF19A4C6),
                       
                      ),
                       Text("Home",style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400 ,fontFamily: "SFProText",color: (indexNum != 0) ? Color(0xff5E5F60) : Color(0xFF19A4C6)),),
            
                    ],
                  ),
                ),
                label:"Home",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width:68.sp ,
                  height: 45.sp,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/search_icon.png",
                        color:
                            (indexNum != 1) ? Color(0xff5E5F60) : Color(0xFF19A4C6),
                       
                      ),
                       Text("Search",style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400 ,fontFamily: "SFProText",color: (indexNum != 1) ? Color(0xff5E5F60) : Color(0xFF19A4C6)),),
            
                    ],
                  ),
                ),
                label:"Home",
              ),
             BottomNavigationBarItem(
                icon: SizedBox(
                  width:68.sp ,
                  height: 45.sp,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/shop_icon.png",
                        color:
                            (indexNum != 2) ? Color(0xff5E5F60) : Color(0xFF19A4C6),
                       
                      ),
                       Text("Shop",style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400 ,fontFamily: "SFProText",color: (indexNum != 2) ? Color(0xff5E5F60) : Color(0xFF19A4C6)),),
            
                    ],
                  ),
                ),
                label:"Home",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width:68.sp ,
                  height: 45.sp,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/cart_icon.png",
                        color:
                            (indexNum != 3) ? Color(0xff5E5F60) : Color(0xFF19A4C6),
                       
                      ),
                       Text("Cart",style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400 ,fontFamily: "SFProText",color: (indexNum != 3) ? Color(0xff5E5F60) : Color(0xFF19A4C6)),),
            
                    ],
                  ),
                ),
                label:"Home",
              ),
            ],
            iconSize: 40,
            selectedFontSize: 10,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: indexNum,
            onTap: (int index) {
              setState(() {
                indexNum = index;
              });
            }),
      ),
    );
  }
}