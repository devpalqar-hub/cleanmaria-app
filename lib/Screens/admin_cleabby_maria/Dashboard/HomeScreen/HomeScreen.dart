import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});


  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int indexnum = 0;

  final List<Widget> _pages = <Widget>[
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
              icon: Image.asset("assets/home.png", color: indexnum == 0 ? Color(0xff17A5C6) : Color(0xff9DB2CE), height: 24.h),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/search.png", color: indexnum == 1 ? Color(0xff17A5C6) : Color(0xff9DB2CE), height: 24.h),
              label: "Client",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/shop.png", color: indexnum == 2 ? Color(0xff17A5C6) : Color(0xff9DB2CE), height: 24.h),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/cart.png", color: indexnum == 3 ? Color(0xff17A5C6) : Color(0xff9DB2CE), height: 24.h),
              label: "Chart",
            ),
          ],
          currentIndex: indexnum,
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
   final HomeController HMCtrl = Get.put(HomeController());
  final TextEditingController _fromdatecontroller = TextEditingController();
  final TextEditingController _todatecontroller = TextEditingController();
  String _selectedField = "from";

  Future<void> _selectDate(BuildContext context, TextEditingController controller, String field) async {
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
              padding: EdgeInsets.fromLTRB(16.w, 41.h, 16.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/bname.png", height: 50.h, width: 115.w),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Row(
                      children: [
                        appText.primaryText(text: "Nice day, ${Get.find<HomeController>().userName}", fontSize: 18.sp, fontWeight: FontWeight.w700),
                        Spacer(),
                        appText.primaryText(text: "Last week", fontSize: 11.sp, fontWeight: FontWeight.w400),
                        Icon(Icons.arrow_drop_down_sharp),
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
                      _buildDateField("From date", _fromdatecontroller, "from"),
                      SizedBox(width: 15.w),
                      _buildDateField("To date", _todatecontroller, "to"),
                      SizedBox(width: 12.w),
                      ElevatedButton(
                        onPressed: _setTodayDate,
                        child: Text("Today", style: TextStyle(color: Colors.white)),
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

  Widget _buildDateField(String label, TextEditingController controller, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText.primaryText(text: label, fontSize: 12.sp, fontWeight: FontWeight.w600),
        SizedBox(height: 5.h),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () => _selectDate(context, controller, field),
              icon: Icon(Icons.calendar_month_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
