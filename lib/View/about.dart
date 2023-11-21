import 'package:flutter/material.dart';
import 'package:uts2/menu.dart';

class About extends StatefulWidget {

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff97978f),
      appBar: AppBar(
        title: Text("About".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Menu())
          );
        }, icon: Icon(Icons.keyboard_backspace_sharp)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black, width: 3, style: BorderStyle.solid)
            ),
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text(
                          'Remind Us adalah sebuah aplikasi pintar yang dirancang untuk '
                              'membantu Anda mengelola dan mengatur pengeluaran bulanan '
                              'Anda dengan mudah dan efisien. Dengan fitur-fitur yang '
                              'disediakan, Remind Us membantu Anda menjaga kendali atas '
                              'keuangan pribadi Anda, merencanakan anggaran, dan '
                              'menghindari pemborosan yang tidak perlu. '
                              'Aplikasi ini menjadi teman setia Anda dalam perjalanan '
                              'mencapai stabilitas keuangan.'
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(
                        children: [
                          Text(
                            'Fitur Utama:',
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              '1. Pemantauan Pengeluaran: Remind Us memungkinkan Anda untuk mencatat dan memantau semua transaksi keuangan Anda. Anda dapat dengan cepat dan mudah menginput pengeluaran sehari-hari, baik yang besar maupun kecil.'
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                                '2. Anggaran Bulanan: Anda dapat membuat anggaran bulanan yang sesuai dengan kebutuhan Anda. Aplikasi ini akan memberi tahu Anda ketika Anda mendekati atau melebihi batas anggaran yang telah ditetapkan.'
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                                '3. Analisis Keuangan: Aplikasi ini menyediakan grafik dan laporan yang membantu Anda memahami pola pengeluaran Anda. Anda dapat melihat tren keuangan Anda dari waktu ke waktu.'
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
        ],
      ),
    );
  }
}
