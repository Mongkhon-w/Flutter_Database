import 'package:flutter/material.dart';
import 'package:flutter_database/models/transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  // controller
  final titleController = TextEditingController(); // รับชื่อรายการ
  final amountController = TextEditingController(); // รับตัวเลขจำนวนเงิน

  // สร้าง GlobalKey สำหรับตรวจสอบสถานะของ Form
  // ย้ายมาไว้นอก build เพื่อไม่ให้ถูกสร้างใหม่ทุกครั้งที่ Rebuild
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("แบบฟอร์มบันทึกข้อมูล")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey, // มอบ key ให้กับ Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "ชื่อรายการ"),
                autofocus: true,
                // controller
                controller: titleController,
                // แก้ไข: ใช้ String? และเช็ก null เพื่อรองรับ Null Safety
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return "กรุณาป้อนชื่อรายการ";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "จำนวนเงิน"),
                keyboardType: TextInputType.number,
                // controller
                controller: amountController,
                // เพิ่ม validator สำหรับจำนวนเงิน (ถ้าต้องการ)
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return "กรุณาป้อนจำนวนเงิน";
                  }
                  if (double.tryParse(str) == null) {
                    return "กรุณาป้อนเป็นตัวเลขเท่านั้น";
                  }
                  if (double.parse(str) <= 0) {
                    return "กรุณาป้อนตัวเลขที่มากกว่า 0";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // ทำให้ปุ่มกว้างเต็มจอ
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // สีพื้นหลังปุ่ม
                    foregroundColor: Colors.white, // สีตัวอักษร
                  ),
                  onPressed: () {
                    // แก้ไข: ใช้ ! เพื่อยืนยันว่า currentState ไม่เป็น null
                    if (formKey.currentState!.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;

                      // เตรียมข้อมูล
                      Transactions statement = Transactions(
                        title: title,
                        amount: double.parse(amount),
                        date: DateTime.now(),
                      ); //ocject

                      // เรียก Provider
                      var provider = Provider.of<TransactionProvider>(
                        context,
                        listen: false,
                      );
                      provider.addTransaction(statement);
                      // ถ้าข้อมูลถูกต้อง ให้ทำงานในนี้
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("เพิ่มข้อมูล"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
