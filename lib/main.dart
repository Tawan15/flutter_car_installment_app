import 'package:flutter/material.dart';
// 1. Import ไฟล์หน้า Splash Screen ของคุณ (แก้ชื่อไฟล์ให้ตรงกับที่คุณตั้ง)
import 'views/splash_screen_ui.dart'; 

void main() {
  runApp(const MyCarApp());
}

class MyCarApp extends StatelessWidget {
  const MyCarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // เอาแถบ Debug สีแดงออกเพื่อให้สวยเหมือนแอปจริง
      title: 'Car Installment',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true, // แนะนำให้เปิดไว้สำหรับ Flutter เวอร์ชันใหม่ๆ
      ),
      // 2. กำหนดให้หน้าแรก (home) คือ SplashScreen
      home: SplashScreen(), 
    );
  }
}