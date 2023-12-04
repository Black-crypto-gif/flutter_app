import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Channel2Page extends StatefulWidget {
  @override
  _Channel2PageState createState() => _Channel2PageState();
}

class _Channel2PageState extends State<Channel2Page> {
  bool isPlaying = false;
  double volume = 1.0;
  String currentSong = '';
  int currentListeners = 0;
  String streamingUrl = '';
  String imageUrl = 'http://localhost/static/img/generic_song.jpg';
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost/api/stations'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final station = data.first;
          setState(() {
            currentSong = station['name'];
            currentListeners = station['mounts'][0]['listeners']['current'];
            streamingUrl = station['listen_url'];
            imageUrl = 'http://localhost/static/img/generic_song.jpg';
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.COMPLETED) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  void _playPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(streamingUrl);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

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
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              height: 200, // Set the height based on your preference
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
              onPressed: _playPause,
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
                audioPlayer.setVolume(volume);
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
      home: Channel2Page(),
    ),
  );
}
