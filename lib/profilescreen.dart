import 'dart:math';

import 'package:assignment/result.dart';
import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';

import 'assets.dart';

enum DisplayScreen { profileScreen, viewScreen }

class ProfileScreen extends StatefulWidget {
  final String latlong;
  final String latitude;
  final String longitude;
  const ProfileScreen({
    super.key,
    required this.latlong,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();

  DisplayScreen display = ResultProvider.instance.storedProfile.isEmpty
      ? DisplayScreen.profileScreen
      : DisplayScreen.viewScreen;
  String name = "";
  String imageStr = "";
  String langitude = "";
  String latitude = "";

  bool islaoding = true;

  @override
  void initState() {
    super.initState();
    checkScreen();
  }

  void checkScreen() {
    Future.delayed(const Duration(milliseconds: 200), () {
      var resultProvider = ResultProvider.instance.storedProfile;
      try {
        var isContain = resultProvider
            .firstWhere((entry) => entry["latlong"] == widget.latlong);
        if (isContain != null) {
          setState(() {
            display = DisplayScreen.viewScreen;

            name = isContain['data']['name'];
            imageStr = isContain['data']['image'];
            langitude = isContain['data']['latitude'];
            latitude = isContain['data']['longitude'];
            islaoding = false;
          });
        }
      } catch (e) {
        setState(() {
          display = DisplayScreen.profileScreen;
          islaoding = false;
        });
      }
    });
  }

  String _getRandomImage() {
    final randomIndex = Random().nextInt(images.length);
    return images[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: islaoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (display == DisplayScreen.profileScreen)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8)
                            .copyWith(top: 16, bottom: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: const Center(
                                child: Text("Name"),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.70,
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Enter Your Name',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(12.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      NeoPopTiltedButton(
                        isFloating: true,
                        onTapUp: () {
                          ResultProvider.instance.storedProfile.add({
                            "latlong": widget.latlong,
                            "data": {
                              "name": nameController.text,
                              "latitude": widget.latitude,
                              "longitude": widget.longitude,
                              "image": _getRandomImage(),
                            }
                          });

                          checkScreen();
                        },
                        decoration: const NeoPopTiltedButtonDecoration(
                          color: Color(0xFFED4D41),
                          plunkColor: Color(0xFFED4D41),
                          shadowColor: Color.fromRGBO(36, 36, 36, 1),
                          showShimmer: true,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 100.0,
                            vertical: 15,
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (display == DisplayScreen.viewScreen)
                  Column(
                    children: [
                      Image.asset(imageStr),
                      Center(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 50,
                              ),
                              child: const Text(
                                "Name : ",
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 100),
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            child: const Text(
                              "Latitude : ",
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 70),
                            child: Text(
                              latitude,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            child: const Text(
                              "Longitude : ",
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            child: Text(
                              langitude,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              ],
            ),
    );
  }
}
