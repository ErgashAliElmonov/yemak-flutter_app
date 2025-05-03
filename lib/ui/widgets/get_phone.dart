import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/auth_store.dart';

final phoneMaskFormatter = MaskTextInputFormatter(
  mask: '+998 (##) ###-##-##',
  filter: {"#": RegExp(r'[0-9]')},
);

class GetPhone extends StatelessWidget {
  const GetPhone({super.key});

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
            "Telefon raqamingizni kiriting va biz ushbu raqamga SMS orqali tasdiqlash kodi yuboramiz",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              String phone = value
                    .substring(6)
                    .split("-")
                    .join("")
                    .split(" ")
                    .join("")
                    .split(")")
                    .join("");
            
              context.read<AuthStore>().getPhoneNumber(phone);
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
              hintText: "+998 (__) ___-__-__",
              labelText: "Telefon raqami",
            ),
          ),
        ),
      ],
    );
  }
}
