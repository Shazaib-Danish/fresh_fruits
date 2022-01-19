import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/data/firebase.dart';
import 'package:fresh_and_fruits/screens/products/fruits_screen.dart';
import 'package:fresh_and_fruits/screens/products/search_products.dart';
import 'package:fresh_and_fruits/screens/products/veg_with_chopping.dart';
import 'package:fresh_and_fruits/screens/products/vegetales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'drawer.dart';


class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> with SingleTickerProviderStateMixin{
  int selectedIndex = 0;
  bool isSearching = false;
  bool showDialogue = false;
  TextEditingController textController = TextEditingController(text: "");

  Future<bool> exit() {
    SystemNavigator.pop();
    return Future.value(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textController.addListener(() {
      if (textController.text.isNotEmpty) {
        Provider.of<ProductManager>(context, listen: false)
            .searchProducts
            .clear();
        setState(() {
          isSearching = true;
        });
        if (selectedIndex == 0) {
          Provider.of<ProductManager>(context, listen: false)
              .getSearchProducts(textController.text, selectedIndex);
        } else if (selectedIndex == 1) {
          Provider.of<ProductManager>(context, listen: false)
              .getSearchProducts(textController.text, selectedIndex);
        } else {
          Provider.of<ProductManager>(context, listen: false)
              .getSearchProducts(textController.text, selectedIndex);
        }
      } else {
        setState(() {
          isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getFruit(context);
    getVegetable(context);
    getVegWithChopping(context);
    return WillPopScope(
      onWillPop: ()=> exit(),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Status')
              .doc('store')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.deepOrangeAccent))),
              );
            } else{
              if ((snapshot.data as dynamic)['status'] == 'Closed') {
                Future.delayed(
                    Duration.zero,
                        () {
                      setState(() {
                        showDialogue = true;
                      });
                    });
              } else {
                Future.delayed(
                    Duration.zero,
                        (){
                      setState(() {
                        showDialogue = false;
                      });
                    });
              }
              return AbsorbPointer(
                absorbing: showDialogue,
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.green[700]),
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                      actions: [
                        AnimSearchBar(
                          helpText: 'Search',
                          width: MediaQuery.of(context).size.width * 0.7,
                          rtl: true,
                          textController: textController,
                          onSuffixTap: () {
                            setState(() {
                              textController.clear();
                            });
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Badge(
                            position: BadgePosition.topStart(top: -2, start: 3),
                            badgeColor: Colors.orangeAccent,
                            badgeContent: Text(
                              '${Provider.of<ProductManager>(context).ordersData.length}',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.bag_fill,
                                size: 30.0,
                                color: Colors.green[600],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserCart(),
                                    ));
                              },
                            ))
                      ],
                      title: showDialogue ? Row(
                        children: [
                          Text('Closed!',style: TextStyle(
                            color: Colors.red[600],
                          ),),
                          Text('(9AM - 9PM)',style: TextStyle(
                            fontSize: 10,
                            color: Colors.red[600]
                          ),)
                        ],
                      ) : Row(
                        children: [
                          Text('Open',style: TextStyle(
                            color: Colors.green,
                          ),),
                          Text('(9AM - 9PM)',style: TextStyle(
                              fontSize: 10,
                              color: Colors.green
                          ),)
                        ],
                      ),
                      bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.orangeAccent,
                        indicatorWeight: 3.0,
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Fruits',
                              style: GoogleFonts.meriendaOne(
                                color: Colors.red[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Vegetables',
                              style: GoogleFonts.meriendaOne(
                                color: Colors.green[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Chop Vegetables',
                              style: GoogleFonts.meriendaOne(
                                color: Colors.green[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                        onTap: (index) {
                          if (index == 0) {
                            setState(() {
                              selectedIndex = index;
                            });
                          } else if (index == 1) {
                            setState(() {
                              selectedIndex = index;
                            });
                          } else {
                            setState(() {
                              selectedIndex = index;
                            });
                          }
                          setState(() {
                            textController.clear();
                          });
                        },
                      ),
                    ),
                    drawer: Container(
                      color: Colors.white,
                      child: Drawer(
                        child: Draawer(
                            Provider.of<ProductManager>(context).user.userName,
                            Provider.of<ProductManager>(context).user.userContact,
                            Provider.of<ProductManager>(context).user.userAddress),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              isSearching
                                  ? SearchProducts(
                                shadowColor: (Colors.red[300])!,
                                buttonColor: (Colors.red[800])!,
                              )
                                  : Fruits(),
                              isSearching
                                  ? SearchProducts(
                                shadowColor: (Colors.green[300])!,
                                buttonColor: (Colors.green[800])!,
                              )
                                  : Vegetable(),
                              isSearching
                                  ? SearchProducts(
                                shadowColor: (Colors.green[300])!,
                                buttonColor: (Colors.green[800])!,
                              )
                                  : VegWithChopping(),
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
