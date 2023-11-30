import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String username;

  ChatPage({required this.username});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();

    // Connect to the socket server
    socket = IO.io('YOUR_SOCKET_SERVER_URL', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    // Listen for incoming messages
    socket.on('message', (data) {
      setState(() {
        messages.add(data);
      });
    });
  }

  @override
  void dispose() {
    socket.dispose(); // Disconnect the socket when the widget is disposed
    super.dispose();
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      socket.emit('message', message);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    sendMessage(messageController.text);
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
