import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts2/View/resum.dart';
import 'package:uts2/data/cart_provider.dart';
import 'package:uts2/data/data_belanja.dart';

import '../data/cart.dart';
import '../data/data.dart';
import '../data/database.dart';
import '../menu.dart';



class EditData extends StatefulWidget {
  const EditData({super.key});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

  DBHelper? dbHelper;
  late Future<List<Cart>> cartList;
  double totalBelanjaan = 0.0;


  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    loadNotes();

  }

  loadNotes() async{
    cartList = dbHelper!.getShoppingItems();
  }




  // Future<void> getTotalShopping() async {
  //   final totalBelanjaan = await dbHelper!.calculateTotalShopping();
  //   setState(() {
  //     this.totalBelanjaan = totalBelanjaan;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    final cart =  Provider.of<CardProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xff97978f),
        appBar: AppBar(
          title: Text("Edit".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,),),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            DataItem(),
            PushItem(cart),
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
        )
    );


  }

  Center PushItem(CardProvider cart) {
    return Center(
            child: Container(
              margin: EdgeInsets.all(20),
              height: 250,
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
                      trailing: IconButton(onPressed: (){
                        dbHelper!.insertShoppingItem(
                            Cart(
                                nama_produk: belanja.nama.toString(),
                                img_produk: belanja.gambarPath.toString(),
                                harga_produk: belanja.harga.toDouble(),
                                quantity: 1,
                                id: index
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
          );
  }

  FutureBuilder<List<Cart>> DataItem() {
    return FutureBuilder(
            future: cartList,
            builder: (context,AsyncSnapshot<List<Cart>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else {
                return Container(
                    margin: EdgeInsets.all(20),
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black,width: 10,style: BorderStyle.solid)
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context,index){
                        int itemId = snapshot.data![index].id_belanja!.toInt();
                        return ListTile(
                          leading: Image.asset(snapshot.data![index].img_produk.toString(),width: 70,height: 70,),
                          title: Text(snapshot.data![index].nama_produk.toString()),
                          subtitle: Text('Harga: \Rp.${snapshot.data![index].harga_produk.toString()}'),
                          trailing: Dismissible(
                            key: ValueKey<int>(itemId),
                            child: IconButton(
                                onPressed:(){
                                  setState(() {
                                    dbHelper!.deleteItem(itemId);
                                    cartList =dbHelper!.getShoppingItems();
                                    snapshot.data!.remove(snapshot.data![index]);
                                  });
                                },
                                icon: Icon(Icons.delete)
                            ),
                          )
                        );
                      },

                    )
                );
              }
            },
          );
  }
}

