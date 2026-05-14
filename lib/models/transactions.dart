class Transactions {
  String title; // แนะนำให้ใส่ final ถ้าค่านั้นไม่เปลี่ยนหลังจากสร้าง object
  double amount;
  DateTime date;

  // เพิ่มคำว่า required เพื่อบอกว่าต้องส่งค่าเหล่านี้มาตอนสร้าง Object นะ
  Transactions({required this.title, required this.amount, required this.date});
}
