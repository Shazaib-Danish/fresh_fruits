class Fruits {
  final String imageUrl;
  final String itemEngName;
  //final String itemUrduName;
  final int itemPrice;
  final double rating;
  final int reviews;

  Fruits(
      {required this.imageUrl,
      required this.itemEngName,
    //  required this.itemUrduName,
      required this.itemPrice,
      required this.reviews,
      required this.rating});
}

class Vegetable {
  final String imageUrl;
  final String itemEngName;
  //final String itemUrduName;
  final int itemPrice;
  final double rating;
  final int reviews;

  Vegetable(
      {required this.imageUrl,
      required this.itemEngName,
    //  required this.itemUrduName,
      required this.itemPrice,
      required this.rating,
      required this.reviews});
}

class VegWithChopping {
  final String imageUrl;
  final String itemEngName;
 // final String itemUrduName;
  final int itemPrice;
  final double rating;
  final int reviews;

  VegWithChopping(
      {required this.imageUrl,
      required this.itemEngName,
   //   required this.itemUrduName,
      required this.itemPrice,
      required this.rating,
      required this.reviews});
}

class Orders {
  final String imageUrl;
  final String itemEngName;
  //final String itemUrduName;
  final int itemPrice;
  int userPrice;
  double itemQuantity;

  Orders(
      {required this.imageUrl,
      required this.itemEngName,
    //  required this.itemUrduName,
      required this.itemPrice,
      this.userPrice = 0,
      this.itemQuantity = 0.0});
}

class User {
  final String userName;
  final String userContact;
  final String userAddress;
  int customerOrders;

  User(
      {required this.userName,
      required this.userContact,
      required this.userAddress,
      this.customerOrders = 0});
}

class SearchFromList {
  final String imageUrl;
  final String itemEngName;
  //final String itemUrduName;
  final int itemPrice;
  final double rating;
  final int reviews;

  SearchFromList(
      {required this.imageUrl,
      required this.itemEngName,
    //  required this.itemUrduName,
      required this.itemPrice,
      required this.rating,
      required this.reviews});
}
