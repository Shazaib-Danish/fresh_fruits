import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/components/reusable_cart.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/data/firebase.dart';
import 'package:fresh_and_fruits/data/model_classes.dart';
import 'package:fresh_and_fruits/screens/products.dart';
import 'package:fresh_and_fruits/screens/track_orders/track_order.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';

class UserCart extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  Future<bool> back(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Products(),
        ));
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => back(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _key,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 80, left: 15.0, right: 15.0, top: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Products(),
                                  ));
                            },
                          ),
                          Spacer(),
                          Text(
                            'My B🍏g',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Consumer<ProductManager>(
                            builder: (context, orderItem, child) {
                              if (orderItem.ordersData.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/fruit_gif.gif',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                      ),
                                      Text('Add items first to your bag'),
                                    ],
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    itemCount: orderItem.ordersData.length,
                                    itemBuilder: (context, index) {
                                      return ReusableCart(
                                        imageUrl: orderItem
                                            .ordersData[index].imageUrl,
                                        engName: orderItem
                                            .ordersData[index].itemEngName,
                                        // urduName: orderItem
                                        //     .ordersData[index].itemUrduName,
                                        price: orderItem
                                            .ordersData[index].itemPrice,
                                      );
                                    });
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0),
                        )),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Rs. ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${Provider.of<ProductManager>(context).totalPrice}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        MaterialButton(
                          elevation: 10.0,
                          splashColor: Colors.deepOrange,
                          height: 50.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          color: Colors.white,
                          child: Text(
                            'Order Now',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w900),
                          ),
                          onPressed: () async {
                            final orderCheck = Provider.of<ProductManager>(
                                    context,
                                    listen: false)
                                .ordersData;
                            if (orderCheck.isNotEmpty) {
                              if (_key.currentState!.validate()) {
                                List<Orders> items =
                                    Provider.of<ProductManager>(context,
                                            listen: false)
                                        .ordersData;
                                int ordersItems = Provider.of<ProductManager>(
                                        context,
                                        listen: false)
                                    .totalItems;
                                List<dynamic> order = [];
                                for (int i = 0; i < ordersItems; i++) {
                                  String name =
                                      '${items[i].itemEngName} :'
                                      ' ${items[i].itemQuantity.toStringAsFixed(2)} : Rs.${items[i].userPrice}';
                                  order.add(name);
                                }

                                await animated_dialog_box.showRotatedAlert(
                                    title: Center(child: Text("Your Order")),
                                    // IF YOU WANT TO ADD
                                    context: context,
                                    secondButton: MaterialButton(
                                      // FIRST BUTTON IS REQUIRED
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        'Confirm',
                                        style:
                                            TextStyle(color: Colors.green[600]),
                                      ),
                                      onPressed: () {
                                        postOrder(context).then((_) {
                                          int totalOrder =
                                              Provider.of<ProductManager>(
                                                      context, listen: false)
                                                  .getUserTotalOrder();
                                          totalOrder++;
                                          Provider.of<ProductManager>(context, listen: false)
                                              .updateUserTotalOrder(totalOrder);
                                          Provider.of<ProductManager>(context,
                                                  listen: false).ordersData.clear();
                                          final _user =
                                              Provider.of<ProductManager>(
                                                      context,
                                                      listen: false)
                                                  .getUser();
                                          updateTotalOrders(
                                                  totalOrder, _user.userContact)
                                              .then((value) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TrackOrder(),
                                                ));
                                          });
                                        });
                                      },
                                    ),
                                    firstButton: MaterialButton(
                                      // OPTIONAL BUTTON
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        'Cancel',
                                        style:
                                            TextStyle(color: Colors.red[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    icon: Icon(
                                      Icons.description,
                                      color: Colors.blue,
                                    ),
                                    // IF YOU WANT TO ADD ICON
                                    yourWidget: Container(
                                        child: Column(
                                            children: List.generate(
                                                order.length, (index) {
                                      int totalCustomerOrders =
                                          Provider.of<ProductManager>(context, listen: false)
                                              .getUserTotalOrder();
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              // Expanded(
                                              //     child: Text(
                                              //         '${items[index].itemEngName} | ${items[index].itemUrduName}')),
                                              Expanded(
                                                child: Text(
                                                    '  ${items[index].itemQuantity.toStringAsFixed(2)}/Kg '),
                                              ),
                                              Text(
                                                  'Rs. ${items[index].userPrice}'),
                                            ],
                                          ),
                                          order.length == index + 1
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Divider(
                                                        thickness: 3.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    totalCustomerOrders == 0
                                                        ? Text(
                                                            'Discount Rs. 100',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                                color:
                                                                    Colors.red),
                                                          )
                                                        : Text(''),
                                                    Text(
                                                        totalCustomerOrders == 0
                                                            ? 'Total Payment:   ${Provider.of<ProductManager>(context, listen: false).totalOfferPrice}'
                                                            : 'Total Payment:   ${Provider.of<ProductManager>(context, listen: false).totalPrice}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color:
                                                                Colors.blue)),
                                                  ],
                                                )
                                              : Divider(
                                                  thickness: 2.0,
                                                ),
                                        ],
                                      );
                                    }))));
                                //postOrder(context);
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
