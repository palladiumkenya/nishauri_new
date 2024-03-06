import 'package:flutter/material.dart';
import 'package:nishauri/src/features/chatbot/data/models/message.dart';
import 'package:nishauri/src/features/chatbot/data/repository/ChatbotRepository.dart';
import 'package:nishauri/src/features/chatbot/data/services/ChatbotService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatbotRepository _repository =
  ChatbotRepository(ChatbotService("https://ushauriapi.kenyahmis.org/nishauri/chat"));

  List<Message> _messages = [];
  bool _isBotTyping = false;

  Widget _buildMessage(Message message) {
    IconData userIcon = message.isSentByUser ? Icons.person : Icons.computer;
    Color iconColor = message.isSentByUser ? Colors.blue : Colors.grey;
    return Align(
      alignment: message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: message.isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          message.isSentByUser ? SizedBox() : Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              userIcon,
              color: iconColor,
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                color: message.isSentByUser ? Colors.lightBlueAccent : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(message.isSentByUser ? 8.0 : 0.0),
                  topRight: Radius.circular(message.isSentByUser ? 0.0 : 8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message.text,
                style: TextStyle(color: message.isSentByUser ? Colors.white : Colors.black),
              ),
            ),
          ),
          message.isSentByUser ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              userIcon,
              color: iconColor,
            ),
          ) : SizedBox(),
        ],
      ),
    );
  }

  void _handleSubmit(String text) async {
    if (text.isEmpty) return;
    _textController.clear();
    Message message = Message(text: text, isSentByUser: true);
    setState(() {
      _messages.add(message);
      _isBotTyping = true; // Bot starts typing when user sends a message
    });

    // Send message to the chatbot service
    try {
      final response = await _repository.sendMessage(message);
      if (response != null && response.text != null) {
        setState(() {
          _messages.add(Message(text: response.text, isSentByUser: false));
          _isBotTyping = false; // Bot stops typing after receiving a response
        });
      } else {
        setState(() {
          _messages.add(const Message(text: 'Failed to receive response from the server', isSentByUser: false));
          _isBotTyping = false; // Bot stops typing on failure to receive response
        });
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Failed to send message: $e');
      setState(() {
        _messages.add(const Message(text: 'Failed to send message..', isSentByUser: false));
        _isBotTyping = false; // Bot stops typing on failure to send message
      });
    }
  }


  // void _handleSubmit(String text) async {
  //   if (text.isEmpty) return;
  //   _textController.clear();
  //   Message message = Message(text: text, isSentByUser: true);
  //   setState(() {
  //     _messages.add(message);
  //   });
  //
  //   // Set bot typing indicator
  //   setState(() {
  //     _isBotTyping = true;
  //   });
  //
  //   // Send message to the chatbot service
  //   try {
  //     final response = await _repository.sendMessage(message);
  //     if (response != null && response.text != null) {
  //       setState(() {
  //         _messages.add(Message(text: response.text, isSentByUser: false));
  //         _isBotTyping = false; // Disable bot typing indicator after receiving response
  //       });
  //     } else {
  //       setState(() {
  //         _messages.add(Message(text: 'Failed to receive response from the server', isSentByUser: false));
  //         _isBotTyping = false; // Disable bot typing indicator on failure
  //       });
  //     }
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   } catch (e) {
  //     print('Failed to send message: $e');
  //     setState(() {
  //       _messages.add(Message(text: 'Failed to send message: $e', isSentByUser: false));
  //       _isBotTyping = false; // Disable bot typing indicator on failure
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Chat With HCW'),
      ),
      body: Column(
        children: <Widget>[
          const Divider(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          _isBotTyping ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(), // Bot typing indicator
          ) : _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    String hintText = _isBotTyping ? 'Bot is typing...' : 'Enter your message...';

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmit(_textController.text),
          ),
        ],
      ),
    );
  }


// Widget _buildComposer() {
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     decoration: BoxDecoration(
  //       border: Border(
  //         top: BorderSide(color: Theme.of(context).dividerColor),
  //       ),
  //     ),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: TextField(
  //             controller: _textController,
  //             onSubmitted: _handleSubmit,
  //             decoration: const InputDecoration.collapsed(
  //               hintText: 'Enter your message...',
  //             ),
  //           ),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.send),
  //           onPressed: () => _handleSubmit(_textController.text),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
