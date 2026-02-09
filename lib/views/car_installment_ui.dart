import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // อย่าลืมติดตั้งแพ็กเกจ intl ใน pubspec.yaml

class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  // 1. ตัวควบคุมสำหรับช่องกรอก
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _interestCtrl = TextEditingController();

  // 2. ตัวแปรเก็บค่าจาก Radio และ Dropdown
  int _selectedDownPayment = 10;
  int _selectedMonth = 24;
  String _totalResult = "0.00";

  final List<int> _monthOptions = [24, 36, 48, 60, 72];

  // --- ฟังก์ชันคำนวณ (The Logic) ---
  void _calculateInstallment() {
    // Validate: เช็คว่ากรอกข้อมูลครบหรือยัง
    if (_priceCtrl.text.isEmpty || _interestCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('กรุณากรอกราคารถและอัตราดอกเบี้ยให้ครบถ้วน!')),
      );
      return;
    }

    double carPrice = double.parse(_priceCtrl.text);
    double interestRate = double.parse(_interestCtrl.text);

    // สูตรที่ 1: ยอดจัด = ราคารถ - (ราคารถ * เงินดาวน์ / 100)
    double financeAmount = carPrice - (carPrice * _selectedDownPayment / 100);

    // สูตรที่ 2: ดอกเบี้ยทั้งหมด = (ยอดจัด * ดอกเบี้ย% * จำนวนปี)
    double totalInterest =
        (financeAmount * (interestRate / 100)) * (_selectedMonth / 12);

    // สูตรที่ 3: ค่างวดต่อเดือน = (ยอดจัด + ดอกเบี้ยทั้งหมด) / จำนวนเดือน
    double monthlyPayment = (financeAmount + totalInterest) / _selectedMonth;

    setState(() {
      // Challenge: ใส่เครื่องหมาย , คั่นหลักพันด้วย NumberFormat
      var formatter = NumberFormat('#,###.00');
      _totalResult = formatter.format(monthlyPayment);
    });
  }

  // --- ฟังก์ชันยกเลิก (Reset) ---
  void _resetForm() {
    setState(() {
      _priceCtrl.clear();
      _interestCtrl.clear();
      _selectedDownPayment = 10;
      _selectedMonth = 24;
      _totalResult = "0.00";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('CI Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('คำนวณค่างวดรถ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            Container(
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/showroom.png',
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel("ราคารถ (บาท)"),
            TextField(
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: '0.00', border: OutlineInputBorder())),

            _buildLabel("จำนวนเงินดาวน์ (%)"),
            // RadioGroup Challenge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [10, 20, 30, 40, 50]
                  .map((val) => Row(
                        children: [
                          Radio(
                              value: val,
                              groupValue: _selectedDownPayment,
                              onChanged: (int? value) => setState(
                                  () => _selectedDownPayment = value!)),
                          Text('$val'),
                        ],
                      ))
                  .toList(),
            ),

            _buildLabel("ระยะเวลาผ่อน (เดือน)"),
            // DropdownButton Challenge
            DropdownButtonFormField<int>(
              value: _selectedMonth,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _monthOptions
                  .map((m) =>
                      DropdownMenuItem(value: m, child: Text('$m เดือน')))
                  .toList(),
              onChanged: (val) => setState(() => _selectedMonth = val!),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            _buildLabel("อัตราดอกเบี้ย (%/ปี)"),
            TextField(
                controller: _interestCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: '0.00', border: OutlineInputBorder())),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateInstallment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                          double.infinity, 60), // 👈 ปรับความสูงที่นี่
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // 👈 ปรับขนาดตัวอักษร
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('คำนวณ'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                          double.infinity, 60), // 👈 ปรับความสูงที่นี่
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // 👈 ปรับขนาดตัวอักษร
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('ยกเลิก'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // ผลลัพธ์
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Text('ค่างวดรถต่อเดือนเป็นเงิน',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_totalResult,
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  const Text('บาทต่อเดือน'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)));
}
