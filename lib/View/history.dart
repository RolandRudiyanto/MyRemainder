import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts2/View/resum.dart';
import 'package:uts2/View/view_screen.dart';
import 'package:uts2/data/data.dart';
import 'package:uts2/View/add_data.dart';
import 'package:uts2/data/database.dart';
import 'package:async/async.dart';
import '../data/cart_provider.dart';
import '../data/database.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  DBHelper? dbHelper;
  late Future<List<Data>> dataList;

  @override
  void initState(){
  super.initState();
  dbHelper = DBHelper();
  loadNotes();
  }

  loadNotes() async{
  dataList = dbHelper!.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff97978f),
        appBar: AppBar(
          title: Text("History".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      body: Container(
        child: FutureBuilder(
            future: dataList,
            builder: (context, AsyncSnapshot<List<Data>> snapshot){
              if(!snapshot.hasData || snapshot.data ==null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.data!.length == 0){
                return Center(
                  child: Text("YOU DON'T HAVE PLAN",style: TextStyle(fontSize: 30,color: Colors.grey),),
                );
              }
              else{
                return SafeArea(
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: snapshot.data?.length,
                      itemBuilder:(context,index){
                        int dataId = snapshot.data![index].id!.toInt();
                        String dataJudul = snapshot.data![index].judul.toString();
                        return Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 140,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget> [
                                        Container(
                                            width: 230,
                                            margin: EdgeInsets.fromLTRB(20, 30, 10, 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget> [
                                                Text(dataJudul.toUpperCase(),style: TextStyle(fontSize: 20,color: Colors.black),textAlign: TextAlign.left,),
                                                Consumer<CardProvider>(builder: (context, value, child){
                                                  return Resum(title: 'Total', value: r'$'+value.getTotalPrice().toStringAsFixed(2));
                                                })
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0,20, 20, 10),
                                      child: Column(
                                        children: [
                                         Dismissible(
                                             key: ValueKey<int>(dataId),
                                             child:  ElevatedButton(
                                                 style: ElevatedButton.styleFrom(primary: Colors.red),
                                                 onPressed: (){
                                                   setState(() {
                                                     dbHelper!.delete(dataId);
                                                     dataList =dbHelper!.getNotes();
                                                     snapshot.data!.remove(snapshot.data![index]);
                                                   });
                                                 },
                                                 child: Row(
                                                   children: [
                                                     Icon(Icons.delete),
                                                     Text("Delete",style: TextStyle(fontSize: 15),)
                                                   ],
                                                 )
                                             ),
                                         ),
                                          ElevatedButton(
                                              onPressed: (){
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context) => ViewScreen())
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.view_day_outlined),
                                                  Text("View",style: TextStyle(fontSize: 15),)
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]
                        );
                      }
                  ),
                );
              }
            }
        )
      )
    );
  }
}
