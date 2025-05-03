import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/auth_store.dart';

final phoneMaskFormatter = MaskTextInputFormatter(
  mask: '####',
  filter: {"#": RegExp(r'[0-9]')},
);

class GetCode extends StatelessWidget {
  const GetCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Kirish",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text(
            "Telefon raqamingizga kelgan tasdiqlash kodini kiriting",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              // print(
              //   value
              //       .substring(6)
              //       .split("-")
              //       .join("")
              //       .split(" ")
              //       .join("")
              //       .split(")")
              //       .join(""),
              // );
              context.read<AuthStore>().getCode(value, context);
            },
            keyboardType: TextInputType.phone,
            inputFormatters: [phoneMaskFormatter],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.green),
              ),
              hintText: "----",
              labelText: "Kod",
            ),
          ),
        ),
      ],
    );
  }
}
