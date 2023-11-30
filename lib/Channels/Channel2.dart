import 'package:flutter/material.dart';

class Channel2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel 1'),
      ),
      body: Center(
        child: Text(
          'Welcome to Channel 1!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
