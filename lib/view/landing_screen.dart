import 'package:crypto_api/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 19, 21, 21),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SizedBox(
                //width: 100,
                height: 300,
                child: RiveAnimation.asset(
                  'assets/redstone_interactive_animation.riv',
                  // fit: BoxFit.cover,
                ),
              ),
              Text(
                'Buy your Crypto Assets now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const HomePage()));
                },
                child: Text('Get Started'),
                style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white)),
              ),
              Spacer(),
              Text(
                'Created by Syahid',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
