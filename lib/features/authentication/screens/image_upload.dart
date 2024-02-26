import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pandas/common_widgets/button.dart';
import 'package:pandas/features/authentication/controllers/signup_controller.dart';
import 'package:pandas/features/authentication/models/user_model.dart';
import 'package:uuid/uuid.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DiamondButton(
                  buttonInversion: true,
                  validateFunc: () {
                    return true;
                  },
                  goRoute: "/register",
                )
              ],
            ),
            signUpController.obx((state) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30, top: 30),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(signUpController.imageUrls[0])),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                      child: IconButton(
                    icon: const Icon(Iconsax.picture_frame),
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all(80.0),
                    ),
                    onPressed: () async {
                      var imagePicker = await ImagePicker().pickImage(
                          source: ImageSource.gallery, imageQuality: 70);

                      if (imagePicker != null) {
                        await signUpController.imageUpload(
                            "Users/Images/Profile/", imagePicker);
                      }
                    },
                    color: Colors.amber,
                  )),
                ),
              );
            },
                onEmpty: Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 30),
                    decoration: const BoxDecoration(
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.amber, width: 2)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                        child: IconButton(
                      icon: const Icon(Iconsax.picture_frame),
                      style: ButtonStyle(
                        iconSize: MaterialStateProperty.all(80.0),
                      ),
                      onPressed: () async {
                        var imagePicker = await ImagePicker().pickImage(
                            source: ImageSource.gallery, imageQuality: 70);

                        if (imagePicker != null) {
                          await signUpController.imageUpload(
                              "Users/Images/Profile/", imagePicker);
                        }
                      },
                      color: Colors.amber,
                    )),
                  ),
                )),
            DiamondButton(
              buttonInversion: false,
              validateFunc: () {
                var userModel = UserModel(
                    id: const Uuid().v4(),
                    name: signUpController.fullName.text,
                    email: signUpController.userEmail.text,
                    phone: signUpController.phoneNumber.text,
                    age: signUpController.userDOB.text,
                    gender: signUpController.initialGenderValue.value,
                    avatar: signUpController.imageUrls[0],
                    images: [signUpController.imageUrls[0]]);

                signUpController.createUser(userModel);
                signUpController.registerUser(signUpController.userEmail.text,
                    signUpController.userPassword.text);

                return true;
              },
              goRoute: "/discover",
            )
          ],
        ),
      ),
    );
  }
}
