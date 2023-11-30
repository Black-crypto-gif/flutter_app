import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حول التطبيق'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About this App',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to the Stream App, where music meets innovation and every beat tells a story. Immerse yourself in a symphony of sounds and explore the future of musical experiences.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Crafted with passion by:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Chris 1 - The Melody Maestro',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Chris 2 - The Harmony Hunter',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Chris 3 - The Rhythm Rockstar',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Join us on this musical journey and discover the perfect blend of technology and tunes!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.network(
                      'https://img.icons8.com/material-rounded/48/000000/facebook.png'),
                  onPressed: () {
                    // Add your Facebook profile link
                  },
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: Image.network(
                      'https://img.icons8.com/material-rounded/48/000000/twitter.png'),
                  onPressed: () {
                    // Add your Twitter profile link
                  },
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: Image.network(
                      'https://img.icons8.com/material-rounded/48/000000/instagram-new.png'),
                  onPressed: () {
                    // Add your Instagram profile link
                  },
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Follow us on social media for the latest updates and exclusive content!',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: AboutPage(),
    ),
  );
}
