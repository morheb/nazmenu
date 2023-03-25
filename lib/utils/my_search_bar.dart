import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 25,
      child: TextField(
          onTap: () {},
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(size.width / 15),
                  borderSide: BorderSide.none),
              hintText: 'search for clothes'.tr,
              hintStyle:
                  TextStyle(color: myMainColor, fontSize: size.width / 40),
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: myMainColor)),
    );
  }
}
