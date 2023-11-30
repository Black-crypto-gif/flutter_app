import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';

class RadioPage extends StatefulWidget {
  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double volume = 50; // Initial volume value
  bool isLiked = false;
  List<Map<String, dynamic>> radios = [];
  Map<String, dynamic>? selectedRadio;
  int currentRadioIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchRadios(); // Fetch the list of radios
  }

  @override
  void dispose() {
    audioPlayer
        .dispose(); // Dispose of the audioPlayer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchRadios() async {
    try {
      final response =
          await Dio().get('https://mp3quran.net/api/v3/radios?language=ar');
      if (response.statusCode == 200) {
        final dynamic data = response.data;

        if (data is Map<String, dynamic>) {
          setState(() {
            radios = List<Map<String, dynamic>>.from(data['radios'] ?? []);
            selectedRadio = radios.isNotEmpty ? radios.first : null;
          });
        }
      } else {
        throw Exception(
            'Failed to fetch radios. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching radios: $e');
      if (e is DioError) {
        print('DioError details: ${e.message}, ${e.response?.data}');
      }
    }
  }

  Future<void> playPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      if (selectedRadio != null) {
        await audioPlayer.stop(); // Stop the current sound
        await audioPlayer.play(selectedRadio!['url'] as String);
        audioPlayer.setVolume(volume / 100);
      }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void switchRadio(int index) {
    setState(() {
      currentRadioIndex = index;
      selectedRadio = radios[index];
      isPlaying = false; // Pause when switching radios
      playPause();
    });
  }

  void playNext() {
    if (currentRadioIndex < radios.length - 1) {
      switchRadio(currentRadioIndex + 1);
    }
  }

  void playPrevious() {
    if (currentRadioIndex > 0) {
      switchRadio(currentRadioIndex - 1);
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('محطات الراديو'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1567201864585-6baec9110dac?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (selectedRadio != null)
                  Column(
                    children: [
                      Text(
                        selectedRadio!['name'] ?? 'Radio Name',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'بث مباشر',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: playPrevious,
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 36,
                        color: Colors.blue,
                      ),
                      onPressed: playPause,
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: playNext,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Volume',
                  style: TextStyle(fontSize: 18),
                ),
                Slider(
                  value: volume,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      volume = value;
                    });
                    if (isPlaying) {
                      audioPlayer.setVolume(volume / 100);
                    }
                    // Add logic for adjusting volume
                    print('Volume: $volume');
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Radios',
                  style: TextStyle(fontSize: 18),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: radios.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(radios[index]['name'] ?? 'Radio Name'),
                        onTap: () {
                          switchRadio(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: RadioPage(),
    ),
  );
}
