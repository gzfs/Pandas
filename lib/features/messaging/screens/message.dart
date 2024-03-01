import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pandas/common_widgets/button.dart';
import 'package:pandas/features/core/controllers/bluetooth_controller.dart';
import 'package:pandas/features/core/controllers/discover_controller.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<StatefulWidget> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  DiscoverController discoverController = Get.put(DiscoverController());
  late Stream userFriends;

  @override
  void initState() {
    userFriends =
        discoverController.getMessages(BluetoothState.instance.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 35),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              DiamondButton(
                buttonInversion: true,
                goRoute: "/discover",
                validateFunc: () {
                  return true;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                child: SvgPicture.asset("assets/Chat.svg"),
              ),
              const SizedBox(
                width: 35,
              )
            ]),
            StreamBuilder(
                stream: userFriends,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error");
                  }
                  return snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return messageTile(
                                  snapshot.data.docs[index]["receiverId"],
                                  snapshot.data.docs[index]["senderId"],
                                    snapshot.data.docs[index]["status"]
                                );
                              }),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                }),
          ],
        ),
      ),
    );
  }

  Widget messageTile(String receiverID, String senderId, String reqStatus) {
    
    var receiverUser = discoverController.getUserByID(receiverID);
    var senderUser = discoverController.getUserByID(senderId);
    
    return FutureBuilder(future: (senderId == BluetoothState.instance.userID) ? receiverUser : senderUser, builder: (ctx, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      }

      Map<String, dynamic> snapshotData =
      snapshot.data as Map<String, dynamic>;

      return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.amber,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(snapshotData["avatar"])),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black))),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                snapshotData["name"],
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Urbanist",
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.amber,
                fixedSize: const Size(70, 70)
              ),
              onPressed: (reqStatus != "pending")
                  ? () {
                Get.toNamed("/message_screen", parameters: {
                  "receiverId": receiverID,
                  "receiverName": snapshotData["name"],
                  "receiverImage": snapshotData["avatar"],
                  "senderId": senderId,
                });
              }
                  : () async {
                if(senderId != BluetoothState.instance.userID){
                  await discoverController.acceptRequest(
                      receiverID, BluetoothState.instance.userID);
                  Get.toNamed("/message_screen", parameters: {
                    "receiverId": receiverID,
                    "receiverName": snapshotData["name"],
                    "receiverImage": snapshotData["avatar"],
                    "senderId": senderId,
                  });
                }
              },
              child: (reqStatus != "pending") ? const Icon(Iconsax.message) : const Icon(Iconsax.tick_circle),
            ),
          ],
        ),
      );
    });
  }
}
