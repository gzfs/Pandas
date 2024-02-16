import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<StatefulWidget> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                  )
                ],
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.amber),
                child: const Column(
                  children: [],
                ),
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.only(right: 0),
                          fixedSize: const Size(70, 60),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                          backgroundColor: Colors.amber,
                          side: const BorderSide(color: Colors.black)),
                      child: const Center(
                          child: Icon(
                            Iconsax.arrow_left4,
                            size: 30.0,
                            color: Colors.black,
                          ))),
                  OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.only(right: 0),
                          fixedSize: const Size(70, 60),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          backgroundColor: Colors.amber,
                          side: const BorderSide(color: Colors.black)),
                      child: const Center(
                          child: Icon(
                        Iconsax.arrow_right_1,
                        size: 30.0,
                        color: Colors.black,
                      ))),
                ],
              )
            ],
          ),
        ));
  }
}
