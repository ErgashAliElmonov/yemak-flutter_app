import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yemak_app/utils/functions.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
 void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    bool hasToken = await Storage().isTokenExists();
    if (!hasToken) {
      // ignore: use_build_context_synchronously
      context.go("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Profile")));
  }
}
