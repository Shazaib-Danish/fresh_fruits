import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/track_orders/track_card.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../products.dart';

class TrackOrder extends StatefulWidget {
  @override
  _TrakOrderState createState() => _TrakOrderState();
}

class _TrakOrderState extends State<TrackOrder> {

  late SharedPreferences loginData;
  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  late String currentUserContact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserContact = Provider.of<ProductManager>(context, listen: false).user.userContact;

  }

  Future<bool> back(BuildContext context){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Products(),
        ));
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final todayDate = getDate();

    return WillPopScope(
      onWillPop: ()=> back(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () async{
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Products(),
                          ));
                    }),
                SizedBox(
                  height: 10.0,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Orders')
                        .where('orderData', arrayContains: '$currentUserContact')
                        .where('orderDate', isEqualTo: '$todayDate')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: LoadingIndicator(
                              colors: [
                                Colors.green,
                                Colors.deepOrangeAccent
                              ],
                                indicatorType: Indicator.orbit,
                                color: Colors.deepOrangeAccent ),
                          ),
                        );
                      } else {
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/fruit_gif.gif',
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  height: MediaQuery.of(context).size.height * 0.3,),
                                Text('No Order Placed yet!\n Choose your favourite fruits and vegetables\nand make a order.',
                                textAlign: TextAlign.center,style: TextStyle(
                                    color: Colors.grey,
                                  ),),
                              ],
                            ),
                          );
                        } else {
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    'Current 🍅rders',
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Column(
                                    children: snapshot.data!.docs.map((data) {
                                      List<Padding> items = [];
                                      int length = data['orderData'].length;
                                      for (int i = 4; i < length; i++) {
                                        items.add( Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text('${data['orderData'][i]}'),
                                        ));
                                      }
                                        return TrackCard(
                                          date: todayDate,
                                          day: 'Today',
                                          items: items,
                                          totalBill:
                                              data['orderData'][3].toString(),
                                          orderStatus: data['orderStatus'] == 'In Process'
                                              ? 1 : data['orderStatus'] == 'On the way'
                                              ? 2 : data['orderStatus'] == 'Completed'? 4: 0,
                                          orderId: data['orderId'],
                                        );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
