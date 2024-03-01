import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pandas/common_widgets/button.dart';
import 'package:pandas/common_widgets/text_field.dart';
import 'package:pandas/features/core/controllers/bluetooth_controller.dart';
import 'package:pandas/features/messaging/controllers/chat_controller.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ChatController chatController = Get.put(ChatController());

  var userImage = Get.parameters['receiverImage'];
  var receiverName = Get.parameters['receiverName'];
  var receiverId = Get.parameters['receiverId'];
  var senderId = Get.parameters['senderId'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
      body: Container(
          padding:
              const EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DiamondButton(
                      buttonInversion: true,
                      goRoute: "/message",
                      validateFunc: () {
                        return true;
                      },
                    ),
                    Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userImage!)),
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black)))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: chatController.getMessages(receiverId!, senderId!),
                    builder: (ctx, snapshot) {

                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return const  CircularProgressIndicator();
                      }

                      if(kDebugMode){
                        print(snapshot.data?.docs[3]["timestamp"]);
                      }

                      return Expanded(
                        child: ListView(
                          children: snapshot.data?.docs
                              .map<Widget>(_buildMessageItem)
                              .toList() as List<Widget>,
                        ),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          textEditingController:
                              chatController.messageController,
                          placeholderValue: "Message",
                          inputType: TextInputType.text),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () async {
                          if (chatController
                              .messageController.text.isNotEmpty) {
                            await chatController.sendMessage(
                                chatController.messageController.text,
                                receiverId!,
                                senderId!);
                            chatController.messageController.clear();
                          }
                        },
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.amber,
                            fixedSize: const Size(60, 60),
                            side: const BorderSide(color: Colors.black)),
                        icon: const Icon(
                          Iconsax.send_2,
                          color: Colors.black,
                        ))
                  ],
                )
              ])),
    );
  }
}

Widget _buildMessageItem(DocumentSnapshot chatDoc) {
  Map<String, dynamic> data = chatDoc.data() as Map<String, dynamic>;

  var alignment = data['senderId'] == BluetoothState.instance.userID
      ? Alignment.centerRight
      : Alignment.centerLeft;

  return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: alignment,
        child: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['message'], style: const TextStyle(
                fontSize: 16
              ),),
              Text(data["timestamp"].toDate().toString().split(" ")[1].split(".")[0], style: const TextStyle(
                fontSize: 10
              ),)
            ],
          ),
        ),
      ));
}
