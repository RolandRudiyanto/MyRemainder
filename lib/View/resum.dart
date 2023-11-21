import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Resum extends StatelessWidget {
  final String title, value;
  const Resum({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.subtitle2,),
              Text(value.toString(), style: Theme.of(context).textTheme.subtitle2,),
            ],
          ),
      ),
    );
  }
}
