import 'package:assignment/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8).copyWith(top: 16, bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: const Center(child: Text("Latitude"))),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: latitudeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter latitude',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8).copyWith(top: 16, bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: const Center(child: Text("Longitude"))),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: longitudeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter longitude',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            NeoPopTiltedButton(
              isFloating: true,
              onTapUp: () {
                if (latitudeController.text.isNotEmpty ||
                    longitudeController.text.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen(
                          latlong:
                              '(${latitudeController.text},${longitudeController.text})',
                          latitude: latitudeController.text,
                          longitude: longitudeController.text,
                        );
                      },
                    ),
                  );
                }
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
      ),
    );
  }
}
