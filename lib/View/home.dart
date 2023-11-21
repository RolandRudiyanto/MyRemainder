import 'package:flutter/material.dart';
import 'package:uts2/View/about.dart';
import 'package:uts2/View/add_data.dart';
import 'package:uts2/View/edit_data.dart';
import 'package:uts2/View/view_screen.dart';
import 'package:uts2/data/data.dart';
import 'package:uts2/data/database.dart';
import 'package:async/async.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
          title: Text("Home".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,),),
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => About())
            );
          }, icon: Icon(Icons.info_outline)),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 400,
              child: datanote(),
            ),
            _addbutton()
          ],
        )
      // datanote()


    );
  }

  Container _addbutton() {
    return Container(
      child:Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Color(0xffd6cfc7),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black,width: 5,style: BorderStyle.solid),
            ),
            width: 300,
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Container(
              width: 230,
              child:
              Text("Tahun: 2023",style: TextStyle(fontSize: 15),textAlign: TextAlign.left,),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Container(
            width: 230,
            child:
            Text("Rp.2000000",style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
          ),
        ],
      ),
    ),
    FloatingActionButton(
    backgroundColor: Color(0xff1a1a1a),
    child: Icon(Icons.add,),
    onPressed: (){
    Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => AddData())
    );
    })
    ],
    ),
    );
  }

  SafeArea datanote() {
    return SafeArea(
      child:Container(
        child: FutureBuilder(
            future: dataList,
            builder: (context,AsyncSnapshot<List<Data>> snapshot) {
              if(!snapshot.hasData || snapshot.data ==null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.data!.length == 0){
                return SafeArea(
                    child:Column(
                        children: [
                    Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.black,width: 5,style: BorderStyle.solid),
                    ),
                    child: Center(
                      child: Container(
                        child: Text("TIDAK ADA DATA!",style: TextStyle(fontSize: 25,),textAlign: TextAlign.left,),
                      ),
                    )
                ),
              ]
              ),
              );
              }
              else{
                return SafeArea(
                    child: PageView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder:(context,index){
                          String dataJudul = snapshot.data![index].judul.toString();
                          String dataDesc = snapshot.data![index].desc.toString();
                          String dataTgl = snapshot.data![index].tgl.toString();
                          return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  height: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(color: Colors.black,width: 5,style: BorderStyle.solid),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget> [
                                      Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0)),
                                      Container(
                                        width: 350,
                                        child: Text(dataTgl.toUpperCase(),style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.left,),
                                      ),
                                      Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                      Container(
                                          width: 350,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget> [
                                              Text(dataJudul.toUpperCase(),style: TextStyle(fontSize: 25,color: Colors.black),textAlign: TextAlign.left,),
                                              Text(dataDesc,style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.left,),
                                            ],
                                          )
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(padding: const EdgeInsets.fromLTRB(17.5, 0, 0, 0)),
                                          Container(
                                            width: 100,
                                            child: ElevatedButton(onPressed: (){
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context) => EditData())
                                              );
                                            },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.edit),
                                                    Text("Edit"),
                                                  ],
                                                )
                                            ),
                                          ),
                                          Padding(padding: const EdgeInsets.fromLTRB(15, 0, 0, 0)),
                                          Container(
                                            width: 100,
                                            child: ElevatedButton(onPressed: (){
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context) => ViewScreen())
                                              );
                                            },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.view_agenda_outlined),
                                                    Text("View"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ],
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
        ),
      )
    );
  }


}
