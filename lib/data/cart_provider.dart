import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts2/data/cart.dart';
import 'package:uts2/data/database.dart';
import 'data.dart';

class CardProvider with ChangeNotifier{

  DBHelper db = DBHelper();

  int _counter =0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get data => _cart;

  Future<List<Cart>> getData () async{
    _cart = db.getShoppingItems();
    return _cart;
  }


  void _setPrefItems() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('card_item', _counter);
    pref.setInt('total_price', _counter);
  }

  void _getPrefItems() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter =  pref.getInt('card_item') ?? 0;
    _totalPrice = pref.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addTotalPrice (double productPrice){
    _totalPrice = _totalPrice +productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removerTotalPrice (double productPrice){
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice (){
    _getPrefItems();
    return _totalPrice;
  }

  void addCounter (){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removerCounter (){
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter (){
    _getPrefItems();
    return _counter;
  }


}