import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pandas/features/core/controllers/bluetooth_controller.dart';
import 'package:pandas/features/core/controllers/discover_controller.dart';
import 'package:pandas/repository/authentication_repository/authentication_repository.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<StatefulWidget> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  BluetoothState bluetoothState = Get.put(BluetoothState());
  DiscoverController discoverController = Get.put(DiscoverController());
  var _recvdUser;

  @override
  void dispose() {
    bluetoothState.streamSubscription.cancel();
    bluetoothState.nearbyServices.stopBrowsingForPeers();
    bluetoothState.nearbyServices.stopAdvertisingPeer();
    super.dispose();
  }

  @override
  void initState() {
    _recvdUser = discoverController.getUserByEmail(
        AuthenticationRepository.instance.firebaseUser.value?.email);
    super.initState();
  }

  var userCounter = 0;

  void _increaseCounter(int arrayLen) {
    if (userCounter != arrayLen - 1) {
      userCounter++;
    } else {
      userCounter = 0;
    }
  }

  void _decreaseCounter(int arrayLen) async {
    if (userCounter != 0) {
      userCounter--;
    } else {
      userCounter = arrayLen - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
        body: Padding(
          padding: const EdgeInsets.only(
              left: 25.0, right: 25.0, top: 30.0, bottom: 25.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: _recvdUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    Map<String, dynamic> snapshotData =
                        snapshot.data as Map<String, dynamic>;

                    bluetoothState.setUserID(snapshotData["id"]);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(snapshotData["avatar"])),
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.black))),
                        Row(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(70, 70),
                                backgroundColor: Colors.amber,
                                side: const BorderSide(color: Colors.black),
                              ),
                              onPressed: () {
                                Get.toNamed("/message");
                              },
                              child: const Icon(Iconsax.message,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  fixedSize: const Size(70, 70),
                                  backgroundColor: Colors.amber,
                                  side: const BorderSide(color: Colors.black),
                                ),
                                onPressed: () {
                                  Get.toNamed("/profile");
                                },
                                child: const Icon(
                                  Iconsax.profile_circle,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ],
                    );
                  }),
              bluetoothState.obx((state) {
                return Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 30, bottom: 40),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(bluetoothState
                                .recvdUsers[userCounter]["avatar"])),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black)),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${bluetoothState.recvdUsers[userCounter]["name"]}, ${bluetoothState.recvdUsers[userCounter]["gender"]}${DateTime.now().year - int.parse(bluetoothState.recvdUsers[userCounter]["age"].split("-")[0])}",
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.amber),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
              },
                  onEmpty: const Expanded(
                      child: Center(
                    child: Text(
                        "Uh oh! Seems like you are in Advertising Mode or there are no users nearby!. Try switching to Browsing Mode again"),
                  )),
                  onLoading: const Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(70, 70),
                      backgroundColor: Colors.amber,
                      side: const BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _decreaseCounter(bluetoothState.recvdUsers.length);
                      });
                    },
                    child: const Icon(Iconsax.arrow_left4, color: Colors.black),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(70, 70),
                      backgroundColor: Colors.amber,
                      side: const BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _increaseCounter(bluetoothState.recvdUsers.length);
                      });
                    },
                    child:
                        const Icon(Iconsax.arrow_right_14, color: Colors.black),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(70, 70),
                      backgroundColor: Colors.amber,
                      side: const BorderSide(color: Colors.black),
                    ),
                    onPressed: () async {
                      if (await discoverController.isRequested(
                          bluetoothState.userID,
                          bluetoothState.recvdUsers[userCounter]["id"])) {
                        Get.snackbar("Request Sent",
                            "You have already sent a request to this user");
                      } else {
                        await discoverController.createMessageRequest(
                            bluetoothState.userID,
                            bluetoothState.recvdUsers[userCounter]["id"],
                            bluetoothState.recvdUsers[userCounter]["avatar"],
                            bluetoothState.recvdUsers[userCounter]["name"]);
                      }
                    },
                    child: const Icon(Iconsax.message_add, color: Colors.black),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(70, 70),
                      backgroundColor: Colors.amber,
                      side: const BorderSide(color: Colors.black),
                    ),
                    onPressed: () async {
                      bluetoothState.toggleBTMode();
                    },
                    child: const Icon(Iconsax.discover_13, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
