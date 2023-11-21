import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts2/View/add_data.dart';
import 'package:uts2/View/belanja.dart';
import 'package:uts2/View/home.dart';
import 'package:uts2/data/cart_provider.dart';
import 'package:uts2/menu.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardProvider(),
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Menu(),
        );
      },
      ),
    );
  }
}
