import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class JoinView extends StatelessWidget {
  const JoinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8,
            mainAxisAlignment: .center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: ChatAppColors.indigo,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.message,
                  color: ChatAppColors.white,
                  size: 32,
                ),
              ),
              Text("Join the room"),
              Text(
                "Your email is your identity here-use the same one next time and your history comes back with you.",
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.work)),
              ),
              TextButton(onPressed: () {}, child: Text("Server Settings")),
              ElevatedButton(onPressed: () {}, child: Text("Enter chat room")),
              Text(" No password, no signup "),
            ],
          ),
        ),
      ),
    );
  }
}
