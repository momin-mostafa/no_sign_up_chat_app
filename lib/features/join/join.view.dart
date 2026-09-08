import 'package:addiits_technology_practical_test/features/chat_room/chat_provider.dart';
import 'package:addiits_technology_practical_test/features/chat_room/chat_room.view.dart';
import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinView extends StatefulWidget {
  const JoinView({super.key});

  @override
  State<JoinView> createState() => _JoinViewState();
}

class _JoinViewState extends State<JoinView> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _joining = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _enterRoom() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _joining = true);

    final user = ChatUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
    );

    try {
      await context.read<ChatProvider>().joinRoom(user);
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ChatRoomView()),
      );
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 160.0, left: 16, right: 16),
          child: Form(
            key: _formKey,
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Your name",
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    hintText: "you@example.com",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return "Enter your email";
                    final emailRegExp = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    );
                    if (!emailRegExp.hasMatch(v)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
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
                  onPressed: _joining ? null : _enterRoom,
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      if (_joining) ...[
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ChatAppColors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Text(_joining ? "Joining…" : "Enter chat room"),
                    ],
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
      ),
    );
  }
}