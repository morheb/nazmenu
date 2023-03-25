import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final IconData? icon;

  const MyTextField({
    Key? key,
    required this.label,
    required this.obscure,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(size.width / 20, 3, size.width / 20, 0),
        height: size.height / 15,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width / 15)),
        child: TextFormField(
          obscureText: obscure,
          cursorColor: Colors.grey,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(color: Colors.grey),
        ));
  }
}
