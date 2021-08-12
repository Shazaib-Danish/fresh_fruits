import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/components/rich_text.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('About us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Fresh',
                style: GoogleFonts.blackHanSans(
                  fontSize: 30,
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
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Text(
                    '&',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Transform.rotate(
                      angle: 30 * 3.14 / 270,
                      child: Image.asset(
                        'assets/curve-down-arrow.png',
                        color: Color(0xFF55CB28),
                        width: 30,
                        height: 30,
                      )),
                ],
              ),
              RichTxt(
                fontSize: 30,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text('About us ',style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w900
              ),),
              SizedBox(
                height: 10.0,
              ),
              Text('Fresh & Fruits is the best quality products supplier based in Lahore. We proudly stand head and shoulders above our contemporaries by offering a high degree of reliability while remaining cost-effective.\n\nThe company is specialized in trading of premium quality fresh fruits and vegetables. The company totally understands the requirements of a client. Therefore with fresh & fruits today most limited seasonal fruits and vegetables are available throughout the year. We are committed to delivering the wholesome best tasting and safest products. Our growth continues as we look to offer our customers fresh and innovative products hands-on customer service and fair prices.'),
              Divider(
                thickness: 3.0,
              ),
              Text('Why Fresh & Fruits?',style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),),
              SizedBox(
                height: 20.0
              ),
              Text('- Fresh & Fruits is dedicated to providing you super quality and super fresh fruits and vegetables at your doorsteps. '
                  '\n\n- We seek quality over everything else and deal only in the highest quality products in the market. '
                  '\n\n- We aim at easing your operations by providing a hassle-free alternative towards improving the efficacy of your business. '
                  '\n\n- Fresh & Fruits, we pride ourselves on a delivery service simply put it Swift and products are packed and delivered in such a way that they are not damaged or perished. '
                  '\n\n- We believe in customized care we adapt ourselves according to the needs of the client and provide the best quality service at competitive market rates. '
                  '\n\n- We seek to establish a long-term relationship with the customers by providing them exceptional Customer services'),
            SizedBox(
              height: 30.0,
            ),
              Text('Developed by',style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Colors.grey
              ),),
              Text('Shazaib Danish',style: TextStyle(color: Colors.grey),),
              Text('shazaibdanish4@gmail.com',style: TextStyle(color: Colors.grey),),
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
        ),
      ),
    );
  }
}
