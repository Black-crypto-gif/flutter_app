import 'package:flutter/material.dart';

class Channel1Page extends StatefulWidget {
  @override
  _Channel1PageState createState() => _Channel1PageState();
}

class _Channel1PageState extends State<Channel1Page> {
  bool isPlaying = false;
  double volume = 1.0;
  String currentSong = '';
  int currentListeners = 0;
  String streamingUrl = '';
  String imageUrl = 'http://localhost/static/img/generic_song.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قناة البث المباشر'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFcacaca), Color(0xFFf0f0f0)],
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(-20, -20),
                    blurRadius: 60,
                    color: Color(0xFFbebebe),
                  ),
                  BoxShadow(
                    offset: Offset(20, 20),
                    blurRadius: 60,
                    color: Color(0xFFFFFFFF),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.play_arrow,
                  size: 64,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Currently Playing:',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              currentSong,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Listeners: $currentListeners',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(
                isPlaying ? 'Pause' : 'Play',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Volume',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Slider(
              value: volume,
              min: 0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  volume = value;
                });
                // Adjust the volume logic here
              },
              activeColor: Colors.blueGrey,
              inactiveColor: Colors.grey,
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
      home: Channel1Page(),
    ),
  );
}
