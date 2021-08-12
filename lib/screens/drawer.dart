import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/components/drawer_children.dart';
import 'package:fresh_and_fruits/components/rich_text.dart';
import 'package:fresh_and_fruits/screens/about_us.dart';
import 'package:fresh_and_fruits/screens/cart.dart';
import 'package:fresh_and_fruits/screens/faq.dart';
import 'package:fresh_and_fruits/screens/login_screen.dart';
import 'package:fresh_and_fruits/screens/track_orders/track_order.dart';
import 'package:google_fonts/google_fonts.dart';

class Draawer extends StatelessWidget {
  final String userName;
  final String userContact;
  final String userAddress;

  const Draawer(this.userName, this.userContact, this.userAddress);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
          ),
          child: Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$userName",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '$userContact',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      '$userAddress',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        DrawerChildren(
            icon: Icons.shopping_bag_outlined,
            title: 'My Bag',
            onPressed: UserCart()),
        DrawerChildren(
            icon: Icons.show_chart,
            title: 'Track order',
            onPressed: TrackOrder()),
        DrawerChildren(icon: Icons.help, title: 'FAQ and Policies', onPressed: FAQ()),
        DrawerChildren(
            icon: Icons.info, title: 'About us', onPressed: AboutUs()),
        DrawerChildren(
            icon: Icons.logout, title: 'Logout', onPressed: LoginScreen()),

        Spacer(),
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
        )
      ],
    );
  }
}
