import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:provider/provider.dart';
import 'model_classes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

 FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//--------------------------getting fruits items from firebase
void getFruit(BuildContext context) async {
  List<Fruits> _fruits = [];
  final products = await _firebaseFirestore.collectionGroup('Fruits').get();
  for (var product in products.docs) {
    _fruits.add(Fruits(
      imageUrl: product['productImageUrl'],
      itemEngName: product['productEngName'] ,
     // itemUrduName: product['productUrduName'],
      itemPrice: int.parse(product['productPrice']),
      rating: double.parse(product['rating'].toString()),
      reviews: int.parse(product['reviews'].toString()),
    ));
  }
  Provider.of<ProductManager>(context, listen: false).getFruits(_fruits);
}

//-----------------------------getting vegetable items from firebase---------

void getVegetable(BuildContext context) async {
  List<Vegetable> _vegetable = [];
  final products = await _firebaseFirestore.collectionGroup('Vegetables').get();
  for (var product in products.docs) {
    _vegetable.add(Vegetable(
      imageUrl: product['productImageUrl'],
      itemEngName: product['productEngName'] ,
     // itemUrduName: product['productUrduName'],
      itemPrice: int.parse(product['productPrice']),
      rating: double.parse(product['rating'].toString()),
      reviews: int.parse(product['reviews'].toString()),
    ));
  }
  Provider.of<ProductManager>(context, listen: false).getVegetables(_vegetable);
}
//-----------------------------------------------------getting chopping vegetables-----
void getVegWithChopping(BuildContext context) async {
  List<VegWithChopping> _vegWithChopping = [];
  final products = await _firebaseFirestore.collectionGroup('VegWithChopping').get();
  for (var product in products.docs) {
    _vegWithChopping.add(VegWithChopping(
      imageUrl: product['productImageUrl'],
      itemEngName: product['productEngName'] ,
     // itemUrduName: product['productUrduName'],
      itemPrice: int.parse(product['productPrice']),
      rating: double.parse(product['rating'].toString()),
      reviews: int.parse(product['reviews'].toString()),
    ));
  }
  Provider.of<ProductManager>(context, listen: false).getVegWithChopping(_vegWithChopping);
}


late SharedPreferences loginData;
//--------------------------------Customer uploading their order -------------

Future postOrder(BuildContext context) async {
  List<dynamic> order = [];

  final key = Uuid();
  var uuid = key.v1();

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);

  final user = Provider.of<ProductManager>(context, listen: false).getUser();

  order.add(user.userName);
  order.add(user.userContact);
  order.add(user.userAddress);
  order.add(Provider.of<ProductManager>(context, listen: false).totalPrice);

  int ordersItems =
      Provider.of<ProductManager>(context, listen: false).totalItems;
  List<Orders> items =
      Provider.of<ProductManager>(context, listen: false).ordersData;

//----------------------------------Converting Order items to Strings--------
  for (int i = 0; i < ordersItems; i++) {
    String name = '${items[i].itemEngName} ---- '
        'Kg. ${items[i].itemQuantity.toStringAsFixed(2)} ---- Rs. ${items[i].userPrice}';
    order.add(name);
  }

// something like 2013-04-20

  await _firebaseFirestore.collection('Orders').doc(uuid).set({
    'orderId': uuid,
    'orderDate' : formatted,
    'orderData': order,
    'orderStatus' : 'Placed',

  });
}

void cancelOrder(String? userId, String? orderId, String? todayDate) async {
  await _firebaseFirestore
      .collection("Orders")
      .where('orderId', isEqualTo: orderId)
      .where('orderData', arrayContains: userId)
      .get()
      .then((value) {
    value.docs.forEach((element) async {
      await _firebaseFirestore.collection('Orders').doc(element.id).delete();
    });
  });
}

Future updateTotalOrders(int order, String userId)async{
  await _firebaseFirestore.collection('Users').doc(userId).update({
    'totalOrder': order,
  });
}
