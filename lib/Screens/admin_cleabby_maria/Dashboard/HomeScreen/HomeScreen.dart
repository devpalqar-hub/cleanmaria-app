import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/ClientScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HistoryScreen/BookingsScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/StaffScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';

import 'package:cleanby_maria/Src/appText.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Homescreen extends StatefulWidget {
  
  const Homescreen();

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
   late HomeController homeController;
  int indexnum = 0;
   @override
  void initState() {
    super.initState();
    _fetchUserData();
    homeController = HomeController();
  }
 Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString("user_name") ?? "name";
    userEmail.value = prefs.getString("user_email") ?? "email";
  }

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const HomeContent(),
    const ClientScreen(),
    const BookingsaScreen(),
    const StaffScreen(),
  ];
  ValueNotifier<String> userName = ValueNotifier("user_name");
  ValueNotifier<String> userEmail = ValueNotifier("user_email");





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[indexnum],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            _buildBarItem("assets/home.png", "Home", 0),
            _buildBarItem("assets/search.png", "Client", 1),
            _buildBarItem("assets/shop.png", "History", 2),
            _buildBarItem("assets/cart.png", "Staff", 3),
          ],
          currentIndex: indexnum,
          onTap: (index) => setState(() => indexnum = index),
          selectedFontSize: 11.sp,
          unselectedFontSize: 11.sp,
          selectedItemColor: const Color(0xff17A5C6),
          unselectedItemColor: const Color(0xff9DB2CE),
          selectedLabelStyle: GoogleFonts.lexend(fontSize: 10.sp, fontWeight: FontWeight.w400),
          unselectedLabelStyle: GoogleFonts.lexend(fontSize: 10.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        color: indexnum == index ? const Color(0xff17A5C6) : const Color(0xff9DB2CE),
        height: 24.h,
      ),
      label: label,
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  
  final HomeController _controller = HomeController();
  String? selectedRange;
   final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();


  
  @override
  void initState() {
    super.initState();
    fromDateController.text = DateTime.now().toString().split(' ')[0];
    toDateController.text = DateTime.now().toString().split(' ')[0];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 41.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(HomeController()),
            SizedBox(height: 15.h),
            _buildGreetingAndDropdown(),
            SizedBox(height: 15.h),
            OverViewCard(),
            SizedBox(height: 15.h),
            appText.primaryText(
              text: "Performance Analysis",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 15.h),
            _buildDateRangePicker(),
            SizedBox(height: 15.h),
            detailcardScreen(),
            SizedBox(height: 20.h),
            fromDateController.text.isNotEmpty && toDateController.text.isNotEmpty
                ? LineChartWidget(
                    startDate: fromDateController.text,
                    endDate: toDateController.text,
                  )
                : const SizedBox.shrink(),
            SizedBox(height: 15.h),
            appText.primaryText(
              text: "Cancellation",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            Cancellationcard(),
          ],
        ),
      ),
    );
  }

  
  Widget _buildTopBar(HomeController controller) {
  return Row(
    children: [
      Image.asset("assets/bname.png", height: 50.h, width: 115.w),
      const Spacer(),
      GestureDetector(
        onTap: () => _showSettingsDialog(context, controller),
        child: Image.asset("assets/settings.png", height: 24.w, width: 24.w),
      ),
    ],
  );
}




       

  Widget _buildGreetingAndDropdown() {
    return ValueListenableBuilder<String>(
      valueListenable: _controller.userName,
      builder: (context, userName, _) {
        return Row(
          children: [
            appText.primaryText(
              text: "Nice day, $userName",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
           DropdownButton<String>(
  value: selectedRange,
  hint: Text("Select Range", style: TextStyle(fontSize: 10.sp)),
  items: ["Last 7 Days", "This Week", "This Month"].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value, style: TextStyle(fontSize: 10.sp)),
    );
  }).toList(),
  onChanged: (String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedRange = newValue;
      }); // Correct placement of the closing parenthesis for setState
      _controller.setDateRangeFromDropdown(newValue);
      _controller.fetchPerformanceData(); // Fetch when changed
    }
  },
  icon: const Icon(Icons.arrow_drop_down_sharp),
),
SizedBox(width: 20.w),

          ],
        );
      },
    );
  }

  Widget _buildDateRangePicker() {
    return Row(
      children: [
        _buildDateInput("From date", _controller.fromDateController),
        SizedBox(width: 15.w),
        _buildDateInput("To date", _controller.toDateController),
        SizedBox(width: 12.w),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: GestureDetector(
            onTap: () {
              _controller.setTodayDate();
              _controller.setTodayDate();
              _controller.fetchPerformanceData(); 
            },
            child: Container(
              height: 35.h,
              width: 83.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: const Color(0xFF17A5C6),
              ),
              child: Center(
                child: Text("Today", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText.primaryText(text: label, fontSize: 12.sp, fontWeight: FontWeight.w600),
        Container(
          width: 120.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.w),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            readOnly: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:  EdgeInsets.fromLTRB(5.w,5.h,15.w,1.h),
              prefixIcon: IconButton(
                onPressed: () => _controller.selectDate(context, controller),
                icon: Icon(Icons.calendar_month_outlined, size: 18.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  
void _showSettingsDialog(BuildContext context, HomeController controller) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      content: SizedBox(
        width: 323.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "NunitoSans",
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            CircleAvatar(
              radius: 62.w,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 62.w,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15.h),

            /// 🔁 Dynamically display name from ValueNotifier
            ValueListenableBuilder<String>(
              valueListenable: controller.userName,
              builder: (context, name, _) => Text(
                name,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔁 Dynamically display email from ValueNotifier
            ValueListenableBuilder<String>(
              valueListenable: controller.userEmail,
              builder: (context, email, _) => Text(
                email,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 25.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Add your logout logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF19A4C6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}