import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';
import 'package:pandas/repository/user_repository/user_repository.dart';

enum BluetoothMode { advertising, browsing }

class BluetoothState extends GetxController with StateMixin {
  static BluetoothState get instance => Get.find();
  String? userID;

  final NearbyService nearbyServices = NearbyService();
  List<Device> discoveredDevices = [];
  List<Map<String, dynamic>> recvdUsers = [];
  late StreamSubscription streamSubscription;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  BluetoothMode bluetoothMode = BluetoothMode.browsing;
  late Rx<bool> isEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    change(recvdUsers, status: RxStatus.empty());
  }

  void toggleBTMode() {
    if (bluetoothMode == BluetoothMode.advertising) {
      serviceInit(bluetoothMode);
      Get.snackbar("Success", "Switched to Advertising Mode",
          backgroundColor: Colors.amber);
      bluetoothMode = BluetoothMode.browsing;
    } else {
      serviceInit(bluetoothMode);
      Get.snackbar("Success", "Switched to Browsing Mode",
          backgroundColor: Colors.amber);
      bluetoothMode = BluetoothMode.advertising;
    }
  }

  setUserID(String id) {
    userID = id;
  }

  Future<void> serviceInit(BluetoothMode bluetoothMode) async {
    if (userID != null) {
      await nearbyServices.init(
          serviceType: "mpconn",
          deviceName: userID,
          strategy: Strategy.P2P_CLUSTER,
          callback: (isRunning) async {
            if (isRunning) {
              if (bluetoothMode == BluetoothMode.advertising) {
                if (recvdUsers.isEmpty) {
                  change(recvdUsers, status: RxStatus.empty());
                }
                await nearbyServices.stopBrowsingForPeers();
                await nearbyServices.startAdvertisingPeer();
              } else {
                change(recvdUsers, status: RxStatus.loading());
                await nearbyServices.stopAdvertisingPeer();
                await nearbyServices.startBrowsingForPeers();
              }
            }
          });
    }

    streamSubscription =
        nearbyServices.stateChangedSubscription(callback: (devicesList) async {
      if (kDebugMode) {
        print("Discovered: $devicesList");
      }
      discoveredDevices.clear();
      discoveredDevices.addAll(devicesList);
      for (var element in devicesList) {
        if (element.deviceId != userID) {
          var recvdUser =
              await UserRepository.instance.getUserById(element.deviceName);
          if (kDebugMode) {
            print("Recvd User: $recvdUser");
          }
          if (!recvdUsers.any((elem) {
            return elem["id"] == recvdUser["id"];
          })) {
            recvdUsers.add(recvdUser);
          }
        }
      }
      isEmpty.value = false;
      if (recvdUsers.isEmpty) {
        change(recvdUsers, status: RxStatus.empty());
      } else {
        change(recvdUsers, status: RxStatus.success());
      }
    });
  }
}
