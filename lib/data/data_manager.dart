import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/model_classes.dart';

class ProductManager extends ChangeNotifier {
  List<Fruits> fruitData = [];
  List<Vegetable> vegetableData = [];
  List<VegWithChopping> vegWithChopping = [];
  List<Text> listOfOrderItems = [];
//-----------------------------------------getting fruits---------------------
  void getFruits(List<Fruits> fruits){
    fruitData = fruits;
    notifyListeners();
  }
//------------------------------------------getting vegetables---------------
  void getVegetables(List<Vegetable> vegetable){
    vegetableData = vegetable;
    notifyListeners();
  }
  //------------------------------------------getting vegetables with chopping---
  void getVegWithChopping(List<VegWithChopping> vegetable){
    vegWithChopping = vegetable;
    notifyListeners();
  }

  //---------------------------------------getting search items-------

  void getSearchProducts(String searchKey, int index){
    if(index==0){
      print('Fruit');
      fruitData.forEach((element) {
        if(element.itemEngName.toLowerCase().startsWith(searchKey.toLowerCase()) ||element.itemEngName.startsWith(searchKey.toLowerCase()) ){
          addSearchList(element.imageUrl, element.itemPrice, element.rating, element.reviews, element.itemEngName,);
        }
      });
    }
    else if(index == 1){
      print('Vegetable');
      vegetableData.forEach((element) {
        if(element.itemEngName.toLowerCase().startsWith(searchKey.toLowerCase()) ||element.itemEngName.startsWith(searchKey.toLowerCase()) ){
          addSearchList(element.imageUrl, element.itemPrice, element.rating, element.reviews, element.itemEngName,);
        }
      });
    }
    else{
      print('Chopp Veg');
      vegWithChopping.forEach((element) {
        if(element.itemEngName.toLowerCase().startsWith(searchKey.toLowerCase()) || element.itemEngName.startsWith(searchKey.toLowerCase())){
          addSearchList(element.imageUrl, element.itemPrice, element.rating, element.reviews, element.itemEngName);
        }
      });
    }
  }

  List<SearchFromList> searchProducts = [];

  void addSearchList(String imageUrl, int price, double rating, int reviews, String itemEngName){
    final findFromList = SearchFromList(imageUrl: imageUrl, itemEngName: itemEngName,  itemPrice: price, rating: rating,reviews: reviews);
    searchProducts.add(findFromList);
    notifyListeners();
  }

//---------------------------------------------User will add product to cart--
  List<Orders> ordersData = [];

  void addProduct(String imageUrl, String itemEngName, int price) {
    final order =
        Orders(imageUrl: imageUrl, itemEngName: itemEngName,itemPrice: price);
    ordersData.add(order);
    notifyListeners();
  }
//---------------------------------getting total number of items added to cart--
  int get totalItems {
    return ordersData.length;
  }
//-----------------------------------Removing product from cart----------------
  void deleteProduct(String itemName) {
    ordersData.removeWhere((element) => element.itemEngName == itemName);
    notifyListeners();
  }

  //----------------------------------total price calculated here--------------
  int get totalPrice{
    int total=0;
    for(int i = 0 ; i<ordersData.length; i++){
      total+= ordersData[i].userPrice;
    }
    return total;
  }

  int get totalOfferPrice{
    int total=0;
    for(int i = 0 ; i<ordersData.length; i++){
      total+= ordersData[i].userPrice;
    }
    total = total - 100;
    return total < 0 ? 0 : total;
  }
//------------------------------------getting index which item selected to remove
  late int index;

   void tileIndex(String name){
    index = ordersData.indexWhere((element) => element.itemEngName == name);
  }

  int get itemIndex{
     return index;
  }

//-------------------------------------------user will add price for order of product
  void addPrice(int index, int price){
     ordersData[index].userPrice = price;
     ordersData[index].itemQuantity = price/ordersData[index].itemPrice;
     notifyListeners();
  }
//---------------------------------------getting price that user added in product
  late int controller;

   void getValue(int index){
     controller = ordersData[index].userPrice;
   }

  int get getController{
     return controller;
  }
//-----------------------------checking here is already added to cart or not--------
  late bool isAdded;

   void isAddedToCart(String name){
     if(ordersData.where((element) => element.itemEngName == name).isNotEmpty){
       isAdded = true;
     }
     else{
       isAdded = false;
     }
   }

   bool get isChecked{
     return isAdded;
   }
   //-------------------------------getting order items from firebase

void getOrderItems(Text text){
     listOfOrderItems.add(text);
     notifyListeners();
}

 late User user;

   void addUser(String name, String contact, String address, int customTotalOrder){
    user = User(userName: name, userContact: contact, userAddress: address, customerOrders: customTotalOrder);
    print(' NAME : ${user.userName}');
    print(' CONTACT ${user.userContact}');
    print('ADDRESS ${user.userAddress}');
   }

   User getUser(){
     return user;
   }

   void updateUserTotalOrder(int order){
     user.customerOrders = order;
   }

   int getUserTotalOrder(){
     return user.customerOrders;
   }

   void discountOffer(int offer){

   }

}
