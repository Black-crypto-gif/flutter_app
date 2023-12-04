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
        primaryColor: Colors.blue,
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

            // Featured Channels
            Text(
              'Featured Channels',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20.0, // Adjust the spacing between columns
              runSpacing: 20.0, // Adjust the spacing between rows
              children: [
                _buildPaddedChannelButton(
                    'Channel 1', '/channel1', Icons.music_note),
                _buildPaddedChannelButton(
                    'Channel 2', '/channel2', Icons.music_note),
                _buildPaddedChannelButton(
                    'Channel 3', '/channel3', Icons.music_note),
                _buildPaddedChannelButton(
                    'Channel 4', '/channel4', Icons.music_note),
                _buildPaddedChannelButton(
                    'Radio Page', '/channel5', Icons.radio),
              ],
            ),

            SizedBox(height: 20),

            // App Description
            Text(
              'Discover the world of music with Stream App. Explore diverse channels and enjoy a personalized audio experience.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
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
      padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
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
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
