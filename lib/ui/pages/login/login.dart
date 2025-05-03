import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/auth_store.dart';
import 'package:yemak_app/ui/widgets/get_code.dart';
import 'package:yemak_app/ui/widgets/get_phone.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kirish")),
      body: Center(
        child: Consumer<AuthStore>(
          builder: (context, value, child) {
            if (value.isNum) {
              return GetCode();
            } else {
              return GetPhone();
            }
          },
        ),
      ),
    );
  }
}
