import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Channel3Page extends StatefulWidget {
  @override
  _Channel3PageState createState() => _Channel3PageState();
}

class _Channel3PageState extends State<Channel3Page> {
  late String listenUrl;
  late int currentListeners;
  late String nowPlayingTitle;
  late String nowPlayingArt;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    late int listeners; // Declare a local variable

    final response =
        await http.get(Uri.parse('http://localhost/api/nowplaying/1'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));

      final station = data['station'];
      listenUrl = station['listen_url'];

      // Initialize the local variable
      listeners = data['listeners']['current'];

      nowPlayingTitle =
          utf8.decode(data['now_playing']['song']['title'].codeUnits);
      nowPlayingArt = data['now_playing']['song']['art'];

      // Assign the local variable to the late variable
      currentListeners = listeners;

      setState(() {});
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current Listeners: ${currentListeners ?? 0}'),
            SizedBox(height: 20),
            Image.network(nowPlayingArt),
            SizedBox(height: 20),
            Text('Now Playing: $nowPlayingTitle'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Play Radio: $listenUrl');
              },
              child: Text('Play Radio'),
            ),
          ],
        ),
      ),
    );
  }
}
