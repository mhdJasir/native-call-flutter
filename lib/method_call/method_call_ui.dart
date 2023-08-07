import 'package:flutter/material.dart';
import 'package:train/method_call/BiometricAuth.dart';
import 'package:train/method_call/method_channel_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _repository = PlatformRepository();
  String colorResult = "0xFFCA2C92";

  authenticate() async {
    BiometricAuth auth = BiometricAuth.instance;
    if (await auth.canAuthenticate == Auth.canAuthenticate) {
      auth.authenticate(
        details: BiometricDetails(
          title: "Jasir",
          subTitle: "Testinggggggggg",
          description: "This is a test",
          passwordButtonName: "Helloo",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse(colorResult)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      FlutterLogo(
                        size: 30,
                      ),
                      Text(
                        "Flutter",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      authenticate();
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.kayaking_outlined),
                      Text(
                        "Kotlin",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    authenticate();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
