import 'package:flutter/material.dart';
import 'package:helloworld/Others/Chat.dart';

// Import necessary packages and files

class Channel4Page extends StatefulWidget {
  @override
  _Channel4PageState createState() => _Channel4PageState();
}

class _Channel4PageState extends State<Channel4Page> {
  String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel 1'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Existing content of your channel page

              // Add a button to navigate to the chat page
              ElevatedButton(
                onPressed: () async {
                  // Get username using a dialog
                  username = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Enter your username'),
                      content: TextField(
                        onChanged: (value) {
                          username = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, username);
                          },
                          child: Text('Connect'),
                        ),
                      ],
                    ),
                  );

                  if (username != null) {
                    // Navigate to the chat page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(username: username!),
                      ),
                    );
                  }
                },
                child: Text('Join Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
