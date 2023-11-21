import 'package:flutter/material.dart';
import 'package:uts2/View/belanja.dart';
import 'package:uts2/View/home.dart';
import 'package:uts2/data/database.dart';
import 'package:intl/intl.dart';
import 'package:uts2/menu.dart';
import '../data/data.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  final TextEditingController _date = TextEditingController();
  final TextEditingController _judul = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  DBHelper? dbHelper;
  late Future<List<Data>> dataList;
  int? idNotes;

  final _fromKey = GlobalKey<FormState>();

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
  /**/
    return Scaffold(
      backgroundColor: Color(0xff97978f),
      appBar: AppBar(
        title: Text("Add Data".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Menu())
          );
        }, icon: Icon(Icons.keyboard_backspace_sharp)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    body:Padding(
        padding: EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _fromKey,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _date,
                          decoration:InputDecoration(
                              border:OutlineInputBorder(),
                            hintText: "Masukan Tanggal"
                          ),
                          onTap: () async {
                            DateTime? datepiker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050));
                            if (datepiker != null) {
                              String formatDate = DateFormat("dd-MM-yyy").format(datepiker);
                              String year = DateFormat("yyyy").format(datepiker);
                              setState(() {
                                _date.text=formatDate;
                              });
                            }
                            else{
                              _date.text="";
                            }
                          },
                        validator: (value){
                          if(value!.isEmpty){
                            return "Masukan Sesuatu!!!";
                          }
                          return null;
                        },
                      ),
                    ),
                      SizedBox(height: 20,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            controller: _judul,
                            maxLength: 20,
                            keyboardType: TextInputType.multiline,
                            decoration:InputDecoration(
                                border:OutlineInputBorder(),
                                hintText: "Masukan Judul",
                            ),
                            validator: (value){
                            if(value!.isEmpty){
                              return "Masukan Sesuatu!!!";
                              }
                              return null;
                              },
                      ),
                    ),
                      SizedBox(height: 20,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _desc,
                          maxLength: 40,
                          keyboardType: TextInputType.multiline,
                          decoration:const InputDecoration(
                            border:OutlineInputBorder(),
                            hintText: "Masukan Deskripsi",
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Masukan Sesuatu!!!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],),
              ),
              SizedBox(height: 40,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Color(0xff97978f),
                      child: InkWell(
                        onTap: () async {
                          if(_fromKey.currentState!.validate()){
                            final insertedNoteId = await dbHelper!.insertNote(Data(
                              tgl: _date.text,
                              judul: _judul.text,
                              desc: _desc.text,
                            ));
                            setState(() {
                              idNotes = insertedNoteId;
                            });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Belanja(idNotes : idNotes)));
                            _date.clear();
                            _judul.clear();
                            _desc.clear();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black,width: 5,style: BorderStyle.solid),
                          ),
                          child: Text("Next", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],),
        ),
    ),
    );
  }
}
