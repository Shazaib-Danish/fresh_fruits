import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_status/timeline_status.dart';
import 'package:fresh_and_fruits/data/firebase.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';

class TrackCard extends StatefulWidget {
  final String totalBill;
  final String day;
  final String date;
  final List<Padding> items;
  final int orderStatus;
  final String orderId;

  const TrackCard(
      {required this.day,
      required this.date,
      required this.items,
      required this.totalBill,
      required this.orderStatus,
      required this.orderId});

  @override
  _TrackCardState createState() => _TrackCardState();
}

class _TrackCardState extends State<TrackCard> {
  late SharedPreferences loginData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        type: MaterialType.card,
        elevation: 4.0,
        shadowColor: Colors.deepOrange,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.deepOrangeAccent,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.day,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(widget.date),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'Rs. ${widget.totalBill}',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.blueAccent),
                  ),
                  Spacer(),
                  if (widget.orderStatus == 4) Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Completed',style: TextStyle(color: Colors.white),),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.green
                        ),
                      ) else MaterialButton(
                      minWidth: 20.0,
                      disabledColor: Colors.grey,
                      enableFeedback: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      height: 30.0,
                      color: Colors.red.shade400,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await animated_dialog_box.showInOutDailog(
                            title: Center(child: Text("Warning")),
                            context: context,
                            secondButton: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: Colors.white,
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Colors.green[600]),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                loginData =
                                    await SharedPreferences.getInstance();
                                cancelOrder(loginData.getString('userId'),
                                    widget.orderId, widget.date);
                              },
                            ),
                            firstButton: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: Colors.white,
                              child: Text(
                                'No',
                                style: TextStyle(color: Colors.red[400]),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            icon: Icon(
                              Icons.help_outline,
                              color: Colors.red,
                            ),
                            // IF YOU WANT TO ADD ICON
                            yourWidget: Text(
                                'Do you really want to cancel this order?',style: TextStyle(
                                color: Colors.grey[600]
                            ),));
                      })
                ],
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.items,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TimeLineStatus(
                  currentStepBackground: Colors.deepOrangeAccent,
                  activatedStepBackground: Colors.green,
                  activatedStepNumberTextColor: Colors.green,
                  inActivatedStepBackground: Colors.grey,
                  currentStepNumberTextColor: Colors.deepOrangeAccent,
                  inActivatedStepNumberTextColor: Colors.grey,
                  textSize: 12,
                  pointCircleRadius: 15.0,
                  statuses: [
                    'Placed',
                    'In Process',
                    'On the way',
                    'Completed'
                  ],
                  currentPosition: widget.orderStatus)
            ],
          ),
        ),
      ),
    );
  }
}
