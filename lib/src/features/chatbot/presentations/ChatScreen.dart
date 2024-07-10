import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/custom_icons.dart';
import 'package:nishauri/src/features/chatbot/data/models/message.dart';
import 'package:nishauri/src/features/chatbot/data/repository/ChatbotRepository.dart';
import 'package:nishauri/src/features/chatbot/data/services/ChatbotService.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

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
      child: const Text('Nuru is typing...'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ChatScreen extends ConsumerStatefulWidget {
  final Function(int chatsCount)? onChatsChange;
  const ChatScreen({Key? key, this.onChatsChange}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatbotRepository _repository = ChatbotRepository(ChatbotService());
  var currentUser = "";
  bool _isBotTyping = false;
  var consent = false;
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _fetchUserData(context, ref));
    final userAsyncValue = AsyncValue.data(userProvider);
    _messages = [
      Message(
        question:
            "Hi $currentUser 👋 \nWelcome to Nuru \nHow can I assist you today?",
        isSentByUser: false,
      ),
    ];
    debugPrint("Current User: $currentUser");
  }

  Widget _buildMessage(Message message) {
    IconData userIcon = message.isSentByUser ? Icons.person : CustomIcons.robot;
    Color iconColor = message.isSentByUser ? Colors.blue : Colors.grey;
    return Align(
      alignment:
          message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: message.isSentByUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          message.isSentByUser
              ? const SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.SPACING),
                  child: Icon(
                    userIcon,
                    color: iconColor,
                  ),
                ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                color: message.isSentByUser
                    ? Colors.lightBlueAccent
                    : Colors.grey[Constants.TIME_OUT],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(message.isSentByUser
                      ? Constants.SPACING
                      : Constants.SIDE_SPACE),
                  topRight: Radius.circular(message.isSentByUser
                      ? Constants.SIDE_SPACE
                      : Constants.SPACING),
                  bottomLeft: const Radius.circular(Constants.SPACING),
                  bottomRight: const Radius.circular(Constants.SPACING),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message.question,
                style: TextStyle(
                    color: message.isSentByUser ? Colors.white : Colors.black),
              ),
            ),
          ),
          message.isSentByUser
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.SPACING),
                  child: Icon(
                    userIcon,
                    color: iconColor,
                  ),
                )
              : const SizedBox(),
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
          _isBotTyping =
              false; // Bot stops typing on failure to receive response
        });
      }
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    } catch (e) {
      setState(() {
        _messages.add(const Message(
            question: 'Failed to send message to Nuru..', isSentByUser: false));
        _isBotTyping = false; // Bot stops typing on failure to send message
      });
    } finally {
      widget.onChatsChange != null
          ? widget.onChatsChange!(_messages.length)
          : null;
    }
  }

  // function that Fetch user data
  void _fetchUserData(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userAsyncValue = ref.watch(userProvider);
      userAsyncValue.when(
        data: (user) {
          debugPrint("User data: ${user.firstName}");
          setState(() {
            currentUser = user.firstName as String;
            _messages = [
              Message(
                question:
                    "Hi $currentUser 👋 \nWelcome to Nuru \nHow can I assist you today?",
                isSentByUser: false,
              ),
            ];
          });
        },
        loading: () {
          debugPrint("Loading user data...");
        },
        error: (error, stackTrace) {
          debugPrint("Error loading user data: $error");
        },
      );
    });
  }

  // Shows consent Dialog
  void _showConsentDialog(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Nuru Consent'),
          content: const Text(
              'Nuru is a chatbot that can assist you with your health queries. Do you consent to use Nuru?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ref
                    .read(settingsNotifierProvider.notifier)
                    .updateSettings(firstNuruAccess: false);
                setState(() {
                  consent = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(settingsNotifierProvider.notifier)
                    .updateSettings(firstNuruAccess: false);
                setState(() {
                  consent = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = getOrientationAwareScreenSize(context);
    final theme = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        final settings = ref.watch(settingsNotifierProvider);
        if (settings.firstNuruAccess) {
          debugPrint("Nuru first time use: ${settings.firstNuruAccess}");
          // ref.read(settingsNotifierProvider.notifier).updateSettings(
          //     firstNuruAccess: false);
          // Open alert dialog to request user for consent
          _showConsentDialog(context, ref);
        } else {
          debugPrint("Nuru first time use: ${settings.firstNuruAccess}");
        }
        return Scaffold(
          // appBar: AppBar(
          //   title: const Text('Chat with Nuru'),
          // ),
          body: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    "assets/images/rect-bg.svg",
                    semanticsLabel: "Doctors",
                    fit: BoxFit.contain,
                    height: size.width * 0.55,
                    width: size.width * 0.55,
                  )),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(Constants.SPACING),
                      child: Row(
                        children: [
                          Text('Chat with Nuru 🤖',
                              style: theme.textTheme.headlineLarge),
                          const SizedBox(width: Constants.SPACING),
                          // const FaIcon(FontAwesomeIcons.robot),
                          // Check if user has given consent to use Nuru
                          consent
                              ? TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Revoke Consent'),
                                              content: const Text(
                                                  'Are you sure you want to revoke your consent to using the personalized version of Nuru?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() =>
                                                        (consent = false));
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('No'),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: const Text("Revoke consent"))
                              : TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Give Consent'),
                                              content: const Text(
                                                  'Do you consent to use Nuru with personalized responses?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    setState(
                                                        () => (consent = true));
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('No'),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: const Text("Give consent"))
                        ],
                      ),
                    ),
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
                        ? Padding(
                            padding: const EdgeInsets.all(Constants.SPACING),
                            child: TypingAnimation(), // Bot typing indicator
                          )
                        : _buildComposer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildComposer() {
    String hintText = _isBotTyping ? 'Nuru is typing...' : 'Chat with Nuru...';

    return Container(
      padding: const EdgeInsets.all(Constants.SPACING),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.ROUNDNESS * 6),
        ),
        child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmit,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            hintText: hintText,
            suffixIcon: Wrap(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/Send.svg",
                  ),
                  onPressed: () => _handleSubmit(_textController.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
