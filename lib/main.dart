import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database/models/transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return TransactionProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'แอพบัญชี'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FormScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        // ระบุ Type ที่จะดึงข้อมูลด้วย
        builder: (context, provider, child) {
          var count = provider.transactions.length;
          if (count <= 0) {
            return Center(
              child: Text("ไม่พบข้อมูล", style: TextStyle(fontSize: 30)),
            );
          } else {
            return ListView.builder(
              itemCount: count,
              itemBuilder: (context, int index) {
                // ดึงข้อมูลทีละแถว
                Transactions data = provider.transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      child: FittedBox(child: Text(data.amount.toString())),
                    ),
                    title: Text(data.title),
                    subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
