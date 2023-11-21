import 'package:flutter/material.dart';
import 'package:uts2/View/history.dart';
import 'package:uts2/View/home.dart';


class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedItem=0;
  static List<Widget> _page=<Widget>[
    Home(),
    History()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _page.elementAt(_selectedItem),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1a1a1a),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Color(0xffd6cfc7),
              icon: Icon(Icons.home,color: Color(0xffd6cfc7),),
              label: "Home",
          ),
          BottomNavigationBarItem(
              backgroundColor: Color(0xffd6cfc7),
              icon: Icon(Icons.history,color: Color(0xffd6cfc7),),
              label: "History"l
          ),
        ],
        currentIndex: _selecte-l\dItem,
        onTap: (setValue){
          setState(() {
            _selectedItem=setValue;
          });
        },
      ),
    );
  }
}