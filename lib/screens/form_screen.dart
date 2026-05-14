import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("แบบฟอร์มบันทึกข้อมูล")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "ชื่อรายการ"),
                autofocus: true,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "จำนวนเงิน"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ), // เพิ่มช่องว่างระหว่าง Text field กับปุ่ม
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // สีพื้นหลังปุ่ม
                  foregroundColor: Colors.white, // สีตัวอักษร
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("เพิ่มข้อมูล"),
              ), // ElevatedButton
            ], // Children ของ Column
          ),
        ),
      ),
    );
  }
}
