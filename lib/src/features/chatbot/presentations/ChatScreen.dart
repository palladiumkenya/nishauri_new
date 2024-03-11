import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nishauri/custom_icons.dart';
import 'package:nishauri/src/features/chatbot/data/models/message.dart';
import 'package:nishauri/src/features/chatbot/data/repository/ChatbotRepository.dart';
import 'package:nishauri/src/features/chatbot/data/services/ChatbotService.dart';
import 'package:nishauri/src/utils/constants.dart';

class TypingAnimation extends StatefulWidget {
  @override
  _TypingAnimationState createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: const Text('NishauriBot is typing...'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatbotRepository _repository = ChatbotRepository(ChatbotService());

  final List<Message> _messages = [];
  bool _isBotTyping = false;

  Widget _buildMessage(Message message) {
    IconData userIcon = message.isSentByUser ? Icons.person : CustomIcons.robot;
    Color iconColor = message.isSentByUser ? Colors.blue : Colors.grey;
    return Align(
      alignment: message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: message.isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          message.isSentByUser ? const SizedBox() : Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.SPACING),
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
                color: message.isSentByUser ? Colors.lightBlueAccent : Colors.grey[Constants.TIME_OUT],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(message.isSentByUser ? Constants.SPACING : Constants.SIDE_SPACE),
                  topRight: Radius.circular(message.isSentByUser ? Constants.SIDE_SPACE : Constants.SPACING),
                  bottomLeft: const Radius.circular(Constants.SPACING),
                  bottomRight: const Radius.circular(Constants.SPACING),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message.question,
                style: TextStyle(color: message.isSentByUser ? Colors.white : Colors.black),
              ),
            ),
          ),
          message.isSentByUser ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.SPACING),
            child: Icon(
              userIcon,
              color: iconColor,
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }

  void _handleSubmit(String text) async {
    if (text.isEmpty) return;
    _textController.clear();
    Message message = Message(question: text, isSentByUser: true);
    setState(() {
      _messages.add(message);
      _isBotTyping = true; // Bot starts typing when user sends a message
    });

    // Send message to the chatbot service
    try {
      final response = await _repository.sendMessage(message);
      if (response != null && response.msg != null) {
        print(response.msg);
        setState(() {
          _messages.add(Message(question: response.msg, isSentByUser: false));
          _isBotTyping = false; // Bot stops typing after receiving a response
        });
      } else {
        setState(() {
          _messages.add(const Message(
              question: 'Failed to receive response from the server',
              isSentByUser: false));
          _isBotTyping = false; // Bot stops typing on failure to receive response
        });
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Failed to send message: $e');
      setState(() {
        _messages.add(const Message(
            question: 'Failed to send message..', isSentByUser: false));
        _isBotTyping = false; // Bot stops typing on failure to send message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Nishauri Bot'),
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
          _isBotTyping
              ?  Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: TypingAnimation(), // Bot typing indicator
          )
              : _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    String hintText = _isBotTyping ? 'Bot is typing...' : 'Enter your message...';

    return Container(
      padding: const EdgeInsets.all(Constants.SPACING),
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
}
