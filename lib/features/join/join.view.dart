import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class JoinView extends StatelessWidget {
  const JoinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 160.0, left: 16, right: 16),
          child: Column(
            spacing: 12,
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: ChatAppColors.indigo,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Icon(
                  Icons.message,
                  color: ChatAppColors.white,
                  size: 32,
                ),
              ),
              Text(
                "Join the room",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Your email is your identity here-use the same one next time and your history comes back with you.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: .center,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.work)),
              ),
              Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_rounded),
                  Text(
                    "Server Settings",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: .center,
                  children: [Text("Enter chat room")],
                ),
              ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    size: 12,
                    color: ChatAppColors.green,
                  ),
                  Text(" No password, no signup "),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
