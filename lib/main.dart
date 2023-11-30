import 'package:flutter/material.dart';
import 'Channels/Channel1.dart';
import 'Channels/Channel2.dart';
import 'Channels/channel3.dart';
import 'Channels/channel4.dart';
import 'Channels/channel5.dart';
import 'Others/About.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
        title: Text('Stream App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            _buildRadioChannelsSection(),
            SizedBox(height: 20),
            _buildCategoriesSection(),
            SizedBox(height: 20),
            _buildDynamicContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioChannelsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Our Radio Station',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.0, // Adjust the spacing as needed
            children: [
              CategoryButton('Channel 1', '/channel1', Icons.music_note),
              CategoryButton('Channel 2', '/channel2', Icons.music_note),
              CategoryButton('Channel 3', '/channel3', Icons.music_note),
              CategoryButton('Channel 4', '/channel4', Icons.music_note),
              CategoryButton('Radio Page', '/channel5', Icons.radio),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return CategoryCard('Category $index', '/category$index');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicContentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Dynamic Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Latest Announcement: Welcome to Stream App!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final String route;
  final IconData icon;

  CategoryButton(this.label, this.route, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String route;

  CategoryCard(this.categoryName, this.route);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(categoryName),
          ),
        ),
      ),
    );
  }
}
