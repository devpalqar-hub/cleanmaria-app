

import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/ClientScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HistoryScreen/BookingsScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/StaffScreen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int indexnum = 0;

  final List<Widget> _pages = [
    HomeContent(),
    ClientScreen(),
    BookingsaScreen(),
    StaffScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
      backgroundColor: Colors.white,
        body: _pages[indexnum],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/home.png", color: (indexnum != 0) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/search.png", color: (indexnum != 1) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "Client",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/shop.png", color: (indexnum != 2) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/cart.png", color: (indexnum != 3) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "Chart",
            ),
          ],
          iconSize: 24.w,
          selectedFontSize: 11.sp,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: indexnum,
          unselectedFontSize: 11.sp,
          selectedItemColor: Color(0xff17A5C6),
          unselectedItemColor: Color(0xff9DB2CE),
          selectedLabelStyle: GoogleFonts.lexend(fontWeight: FontWeight.w400, fontSize: 10.sp),
          unselectedLabelStyle: GoogleFonts.lexend(fontWeight: FontWeight.w400, fontSize: 10.sp),
          onTap: (int index) {
            setState(() {
              indexnum = index;
            });
          },
        ),
      ),
    );
  }
}




class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  TextEditingController _fromdatecontroller = TextEditingController();
   TextEditingController _todatecontroller = TextEditingController();
   String _selectedField = "from"; 
    Future<void> _selectDate(BuildContext context, TextEditingController controller,String field) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    setState(() {
      controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
       _selectedField = field;
    });
  }
}
void _setTodayDate() {
    setState(() {
      String today = DateFormat('dd/MM/yyyy').format(DateTime.now());
      if (_selectedField == "from") {
        _fromdatecontroller.text = today;
      } else {
        _todatecontroller.text = today;
      }
    });
  }


  @override
 

  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w,41.h,16.w,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Row(
                        children: [
                          Image.asset("assets/bname.png",
                                        height:50.h,
                                        width:115.w
                                        ),
                                        SizedBox(width:211.w ,),
                          Image.asset("assets/Bell_fill.png",
                                        height:32.h,
                                        width:32.w
                                        ),
                        ],
                      ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Row(
                      children: [
                        appText.primaryText(text: "Nice day, George", fontSize: 18.sp, fontWeight: FontWeight.w700,),
                        Expanded(child: Container()),
                        appText.primaryText(text: "Last week",fontSize: 11.sp, fontWeight: FontWeight.w400,),
                        Icon(Icons.arrow_drop_down_sharp),
                        SizedBox(width: 20.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  OverViewCard(),
                  SizedBox(height: 15.h),
                  appText.primaryText(text: "Performance Analysis", fontSize: 18.sp, fontWeight: FontWeight.w700),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appText.primaryText(text: "From date", fontSize: 12.sp, fontWeight: FontWeight.w600),
                           Container(
  width: 120.w, // Adjust width if needed
  height: 40.h, // Increased height
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(6.w),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: TextField(
    controller: _fromdatecontroller,
    readOnly: true,
     textAlign: TextAlign.center,  // Center align text
    style: TextStyle(fontSize: 10.sp), 
    decoration: InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w), // Adjust padding
      prefixIcon: IconButton(
        onPressed: () => _selectDate(context,_fromdatecontroller,"from"),
        icon: Icon(Icons.calendar_month_outlined, size: 18.sp),
      ),
    ),
  ),
),



                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appText.primaryText(text: "To date", fontSize: 12.sp, fontWeight: FontWeight.w600),
                             Container(
  width: 120.w, // Increased width
  height: 40.h, // Adjusted height
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(6.w),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: TextField(
    controller: _todatecontroller,
    readOnly: true,
    textAlign: TextAlign.center,  // Center align text
    style: TextStyle(fontSize: 10.sp), // Adjust text size
    decoration: InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w), // Adjust padding
      prefixIcon:  IconButton(
          onPressed: () => _selectDate(context,_todatecontroller,"to"),
          icon: Icon(Icons.calendar_month_outlined, size: 18.sp),
        ),
      
    ),
  ),
),

                          
                         


                        ],
                      ),
                      SizedBox(width:12.w),
                      Padding(
                        padding:  EdgeInsets.only(top:20.h),
                        child: GestureDetector(
                          onTap:_setTodayDate,
                          child:  Container(height:26.h ,width:89.w,decoration: BoxDecoration(borderRadius:BorderRadius.circular(5.r) ,color: const Color(0xFF17A5C6),),child: Center(child: Text("Today",style: TextStyle(color:Colors.white ),)),)),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  detailcardScreen(),
                  SizedBox(height: 20.h),
                  LineChartWidget(),
                  appText.primaryText(text: "Cancellation", fontSize: 18.sp, fontWeight: FontWeight.w700),
                  Cancellationcard(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
