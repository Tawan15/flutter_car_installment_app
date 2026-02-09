import 'package:flutter/material.dart';
import 'dart:async';

// สมมติว่าเป็นหน้าหลักหลังจากโหลดเสร็จ
import 'car_installment_ui.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ⏳ ตั้งเวลา 3 วินาที แล้วย้ายหน้า
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CarInstallmentUi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // สีเขียวตามรูป
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ส่วนของรูปภาพ (อย่าลืมเพิ่มไฟล์ใน pubspec.yaml)
            Image.asset(
              'assets/images/car.png',
              width: 250,
            ),
            SizedBox(height: 30),

            // ข้อความหัวข้อ
            Text(
              'Car Installment',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'คำนวณค่างวดรถยนต์',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),

            SizedBox(height: 50),

            // ตัว Loading วงกลม
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),

            SizedBox(height: 50),

            // ส่วนท้าย
            Text(
              'Created by Tawan DTI-SAU',
              style: TextStyle(color: Colors.white60),
            ),
            Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}
