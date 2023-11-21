import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts2/View/resum.dart';
import 'package:uts2/data/cart_provider.dart';
import 'package:uts2/menu.dart';

import '../data/cart.dart';
import '../data/data.dart';
import '../data/database.dart';



class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

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
    return Scaffold(
        backgroundColor: Color(0xff97978f),
        appBar: AppBar(
          title: Text("View".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,),),
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
          FutureBuilder(
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
                      height: 500,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black,width: 10,style: BorderStyle.solid)
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          leading: Image.asset(snapshot.data![index].img_produk.toString(),width: 70,height: 70,),
                          title: Text(snapshot.data![index].nama_produk.toString()),
                          subtitle: Text('Harga: \Rp.${snapshot.data![index].harga_produk.toString()}'),
                          trailing: Checkbox(
                            value: snapshot.data![index].complete,
                            onChanged: (selected){
                              snapshot.data![index].complete = selected!;
                            },
                          ),
                        );
                      },

                    )
                  );
                }
              },
              ),
          Consumer<CardProvider>(builder: (context, value, child){
            return Resum(title: 'Total', value: r'$'+value.getTotalPrice().toStringAsFixed(2));
          })
        ],
      )
    );


  }
}

