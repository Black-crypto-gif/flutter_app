import 'package:flutter/material.dart';
import 'Channels/Channel1.dart';
import 'Channels/Channel2.dart';
import 'Channels/channel3.dart';
import 'Channels/channel4.dart';
import 'Channels/channel5.dart';
import 'Others/About.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/channel1': (context) => Channel1Page(),
        '/channel2': (context) => Channel2Page(),
        '/channel3': (context) => Channel3Page(),
        '/channel4': (context) => Channel4Page(),
        '/channel5': (context) => RadioPage(),
        '/about': (context) => AboutPage(),
      },
      theme: ThemeData(
        primaryColor:
            Color(0xFFe0e0e0), // Set the background color for the entire app
        fontFamily: 'Roboto',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اذاعة توحيد'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            // App Title
            Text(
              'Stream App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Slogan
            Text(
              'Your Source for Diverse Music',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Radio Station Title
            Text(
              'اذاعة توحيد',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Featured Channels
            Text(
              'Featured Channels',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              padding: EdgeInsets.all(5.0),
              shrinkWrap: true,
              children: [
                _buildPaddedChannelButton(
                    'Channel 1', '/channel1', Icons.radio),
                _buildPaddedChannelButton(
                    'Channel 2', '/channel2', Icons.radio),
                _buildPaddedChannelButton(
                    'Channel 3', '/channel3', Icons.radio),
                _buildPaddedChannelButton(
                    'Channel 4', '/channel4', Icons.radio),
                _buildPaddedChannelButton(
                    'Radio Page', '/channel5', Icons.radio),
                _buildPaddedChannelButton('About App', '/about', Icons.info),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer items for each channel and about page
            ListTile(
              title: Text('قناة البث المباشر'),
              onTap: () {
                Navigator.pushNamed(context, '/channel1');
              },
            ),
            ListTile(
              title: Text('Channel 2'),
              onTap: () {
                Navigator.pushNamed(context, '/channel2');
              },
            ),
            ListTile(
              title: Text('Channel 3'),
              onTap: () {
                Navigator.pushNamed(context, '/channel3');
              },
            ),
            ListTile(
              title: Text('Channel 4'),
              onTap: () {
                Navigator.pushNamed(context, '/channel4');
              },
            ),
            ListTile(
              title: Text('محطات الراديو'),
              onTap: () {
                Navigator.pushNamed(context, '/channel5');
              },
            ),
            ListTile(
              title: Text('About this App'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddedChannelButton(String label, String route, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(5.0), // Adjust the padding as needed
      child: ChannelButton(label, route, icon),
    );
  }
}

class ChannelButton extends StatelessWidget {
  final String label;
  final String route;
  final IconData icon;

  ChannelButton(this.label, this.route, this.icon);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[300], // Background color
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        // Box Shadow
        elevation: 10,
        shadowColor: Colors.grey[500],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Text
          Positioned(
            top: 20,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Icon
          Positioned(
            bottom: 20,
            child: Icon(
              icon,
              color: Colors.grey[800],
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
