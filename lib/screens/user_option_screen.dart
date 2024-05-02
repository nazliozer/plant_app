import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/profile_screen.dart';
import 'package:plant_app/screens/user_comments_screen.dart';
import 'package:plant_app/screens/user_favorites_screen.dart';
import 'package:plant_app/screens/user_posts.dart';
import 'package:plant_app/widgets/user_options_card.dart';

class UserOptionScreen extends StatelessWidget {
  String? _name = "Nazli";
  String? _surname = "Ozer";
  String? _username = "nazliozer";
  String? _email = "nazli@gmail.com";
  String? _city = "Ankara";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'User Profile',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: Color(0xFF2B423D)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 35),
        child: ListView(
          padding: EdgeInsets.all(6.0),
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(right: 5, left: 5),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 201, 224, 109),
              ),
              title: Row(
                children: [
                  Text(
                    "$_name $_surname",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF2B423D),
                    ),
                  ),
                  Text("")
                ],
              ),
              subtitle: Text(
                "$_username | $_email | $_city",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF2B423D),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: UserOptionsCard(title: "My Profile Settings")),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPost()),
                  );
                },
                child: UserOptionsCard(title: "My Posts")),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserFavoritesScreen()),
                  );
                },
                child: UserOptionsCard(title: "My Favorite Posts")),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserCommentsScreen()),
                  );
                },
                child: UserOptionsCard(title: "My Comments")),
          ],
        ),
      ),
    );
  }
}