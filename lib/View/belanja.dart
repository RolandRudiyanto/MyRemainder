import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts2/View/home.dart';
import 'package:uts2/data/cart.dart';
import 'package:uts2/data/cart_provider.dart';
import 'package:uts2/data/data.dart';
import 'package:uts2/data/data_belanja.dart';
import 'package:uts2/data/database.dart';
import 'package:uts2/menu.dart';

class Belanja extends StatefulWidget {
  final int? idNotes;

  const Belanja({Key? key, this.idNotes}): super(key: key);

  @override
  State<Belanja> createState() => _BelanjaState(idNotes);
}

class _BelanjaState extends State<Belanja> {

  DBHelper? dbHelper;
  late Future<List<Cart>> cartList;
  late Future<List<Data>> dataList;
  final int? idNotes;

  _BelanjaState(this.idNotes);

  final _fromKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
   dbHelper = DBHelper();
    loadCart();
  }

  loadCart() async{
    cartList = dbHelper!.getShoppingItems();
  }
  



  @override
  Widget build(BuildContext context) {
    final cart =  Provider.of<CardProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff97978f),
      appBar: AppBar(
        title: Text("Belanja".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black,width: 10,style: BorderStyle.solid)
              ),
              child: ListView.builder(
                itemCount: belanjalist.length ,
                itemBuilder: (context,index){
                  final belanja = belanjalist[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child:
                        ListTile(
                          leading: Image.asset(belanja.gambarPath,width: 70,height: 70,),
                          title: Text(belanja.nama),
                          subtitle: Text('Harga: \Rp.${belanja.harga}'),
                          trailing: IconButton(onPressed: () async {
                            final int idNotes = widget.idNotes ?? 0;
                            dbHelper!.insertShoppingItem(
                              Cart(
                                  nama_produk: belanja.nama.toString(),
                                  img_produk: belanja.gambarPath.toString(),
                                  harga_produk: belanja.harga.toDouble(),
                                  quantity: 1,
                                  id: idNotes
                              )
                            ).then((value){
                              print('ADD DATA');
                              cart.addTotalPrice(double.parse(belanja.harga.toString()));
                              cart.addCounter();
                            }).onError((error, stackTrace){
                              print(error.toString());
                            });
                          },
                              icon: Icon(Icons.add)),
                        ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height:40,),
          Container(
            width: 150,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black,width: 5,style: BorderStyle.solid)
            ),
            child: ElevatedButton(
                style:ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ))),
                onPressed: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Menu())
                  );
                },
                child:  Text("Save",style: TextStyle(fontSize: 22,color: Colors.black),)
            ),
          )
        ],
      ),
    );
  }
}


