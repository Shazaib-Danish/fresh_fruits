import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/components/rich_text.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6.0,
        backgroundColor: Colors.green,
        title: Text('FAQ and Policies'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text('Ordering',style: TextStyle(
                fontSize: 18,
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.w900,
              ),),
              SizedBox(
                height: 20.0,
              ),
              Text('How can I order?',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(
                height: 10.0,
              ),
              Text('We can make sure you are getting exactly what you want. You can make order via mobile app, phone call, or through whatsapp.'),
              Divider(
                thickness: 3.0,
              ),
              Text('How can I order from mobile app?',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(
                height: 10.0,
              ),
              Text('We trying best to deliver you exact and favourite fruits and vegetables. All fruits and vegetable showing on the main screens choose your favourite one!\n\nSteps\n* Add fruits and vegetables to your bag first.\n* Then open your bag and enter price of every item, how much you want.\n* Then click on Order Now and confirm your order.'),
              Divider(
                thickness: 3.0,
              ),
              Text('How can I order via whatsapp?',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(
                height: 10.0,
              ),
              Text('Just send us your name and home address on given number  \"+923117794702\"  then you will receive list of all available fruits and vegetables with prices, choose your favourite one from list and send us on whatsapp.'),
              Divider(
                thickness: 3.0,
              ),
              Text('Can I change/update order?',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(
                height: 10.0,
              ),
              Text('No, you cannot update or edit your placed order, but you can cancel previous one and can make new order.'),
              Divider(
                thickness: 3.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Payment',style: TextStyle(
                fontSize: 18,
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.w900,
              ),),
              SizedBox(
                height: 20.0,
              ),
              Text('What are the payment methods?',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(
                height: 10.0,
              ),
              Text('Cash on delivery, this method available right now.'),
              Divider(
                thickness: 3.0,
              ),
              SizedBox(height: 20.0),
              Text('Privacy & Policies',style: TextStyle(
                fontSize: 18,
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.w900,
              ),),
              SizedBox(
                height: 20.0,
              ),
              Text('My data is secure?',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(
                height: 10.0,
              ),
              Text('We have made every effort to ensure your privacy and personal details are protected at all times.'),
              Divider(
                thickness: 3.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Fresh',
                      style: GoogleFonts.blackHanSans(
                        fontSize: 20,
                        color: Color(0xFF55CB28),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: 200 * 3.14 / 180,
                          child: Image.asset(
                            'assets/curve-down-arrow.png',
                            color: Color(0xFFA5A5A5),
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Text(
                          '&',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Transform.rotate(
                            angle: 30 * 3.14 / 270,
                            child: Image.asset(
                              'assets/curve-down-arrow.png',
                              color: Color(0xFF55CB28),
                              width: 20,
                              height: 20,
                            )),
                      ],
                    ),
                    RichTxt(
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Copyright © 2021 Fresh & Fruits. All rights reserved.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
