import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:fresh_and_fruits/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerChildren extends StatelessWidget {
  final Widget onPressed;
  final IconData icon;
  final String title;

  const DrawerChildren({
    required this.icon,
    required this.title,
    required this.onPressed,
});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepOrangeAccent,),
            SizedBox(
              width: 10.0,),
            Text(title,style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),)
          ],
        ),
      ),
      onTap: ()async{
        if(title == 'Logout'){
          SharedPreferences loginData;
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
                  await FirebaseAuth.instance.signOut();
                  loginData  = await SharedPreferences.getInstance();
                  loginData.setBool('login', true);
                  loginData.getKeys().remove('userId');
                  Navigator.of(context);
                  Navigator.of(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => onPressed));
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
                  'Are you sure you want to logout?',style: TextStyle(
                color: Colors.grey[600]
              ),));
        }
        else{
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> onPressed,
          ));
        }

      },
    );
  }
}
