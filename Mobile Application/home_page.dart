import 'package:flutter/material.dart';
import 'package:leaf_loom/my_plants.dart';


class HomePage extends StatelessWidget {
  final String username;
  HomePage({required this.username});
  @override
  Widget build(BuildContext context) {
    print('home page: $username');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Color(0xFF588C7E),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'website');
                    },
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'LeafLoom',
                      style: TextStyle(
                        fontFamily: 'Livvic',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ProfileDropdown(),
                ],
              ),
            ),
            Container(
              color: Color(0xFFC1E1C1),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    title: 'My Plants',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPlantsPage(username: username)),
                      );
                    },
                  ),
                  NavItem(
                    title: 'Resources',
                    dropdownItems: ['Articles', 'Tutorial videos'],
                  ),
                  NavItem(
                    title: 'Tasks',
                    dropdownItems: ['Monthly', 'Weekly', 'Daily'],
                  ),
                  NavItem(
                    title: 'Community',
                    dropdownItems: ['Forums', 'Events'],
                  ),
                  NavItem(
                    title: 'Upload Media',
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFC1E1C1),
              child: Column(
                children: [
                  BoxSection(
                    title: 'Welcome to LeafLoom!',
                    content:
                    'Discover a world of gardening with our feature-rich software. Manage your plants, connect with fellow gardeners, explore resources, and more.',
                  ),
                  BoxSection(
                    title: 'My Plants',
                    content:
                    'Keep track of all your plants in one place. Add, edit, and delete plants from your personal database.',
                  ),
                  BoxSection(
                    title: 'Community',
                    content:
                    'Connect with other passionate gardeners, share experiences, and seek advice within the gardening community.',
                  ),
                  BoxSection(
                    title: 'Resources',
                    content:
                    'Explore a rich library of gardening resources including articles, videos, and tips to enhance your gardening knowledge.',
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFF588C7E),
              padding: EdgeInsets.all(20),
              child: Text(
                'Contact Us: support@gardeningmadeeasy.com | Phone: +91 9846263749',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final List<String>? dropdownItems;
  final VoidCallback? onPressed;

  NavItem({required this.title, this.dropdownItems, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Use GestureDetector only if onPressed is provided
    if (onPressed != null) {
      return GestureDetector(
        onTap: onPressed,
        child: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      // Otherwise, return PopupMenuButton
      return PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return dropdownItems!.map((String item) {
            return PopupMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList();
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      );
    }
  }
}


class BoxSection extends StatelessWidget {
  final String title;
  final String content;

  BoxSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'My Journal',
            child: Text('My Journal'),
          ),
          PopupMenuItem(
            value: 'Wishlist',
            child: Text('Wishlist'),
          ),
          PopupMenuItem(
            value: 'Logout',
            child: Text('Logout'),
          ),
        ];
      },
      onSelected: (String value) {
        // Handle item selection
      },
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
