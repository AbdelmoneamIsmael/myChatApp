import 'package:flutter/material.dart';
import 'package:messanger_app/model/user_model.dart';
import 'package:messanger_app/screens/chat_Screen/chat/chat_screen.dart';

class ChatBuilder extends StatelessWidget {
  const ChatBuilder({super.key, required this.user});
  final UserInformation user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(user: user),
            ));
      },
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.image),
              backgroundColor: Colors.black,
              radius: 23,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.name}  ',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Hello Abdelmoneam ! ',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
