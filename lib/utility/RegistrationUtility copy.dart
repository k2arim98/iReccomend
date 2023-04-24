
import 'package:flutter/material.dart';
import 'package:irecommend/utility/constant.dart';



Widget regtextformfield(
    String hintText, Icon prefixIcon, TextEditingController regEmail) {
  return TextFormField(
    controller: regEmail,
    
    style: TextStyle(color: Style.black),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Style.grey),
      prefixIcon: prefixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Style.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(color: Style.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(width: 1, color: Style.grey),
      ),
    ),
  );
}


Widget reg_email_textformfield(
    String hintText, Icon prefixIcon, TextEditingController regEmail) {
  return TextFormField(
    controller: regEmail,
    validator: (value) {
      if (value!.isEmpty) {
        return "PLease Enter Your Email";
      }
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return "Please enter a valid email address";
      } else {
        return null;
      }
    },
    style: TextStyle(color: Style.black),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Style.grey),
      prefixIcon: prefixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Style.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(color: Style.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(width: 1, color: Style.grey),
      ),
    ),
  );
}

Widget reg_password_textFormField(
    String hintText, TextEditingController regPassword) {
  return TextFormField(
    controller: regPassword,
    validator: (value) {
      if (value!.isEmpty) {
        return "PLease Enter Your Password";
      }
      if (!RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(value)) {
        return "Please enter a valid Password";
      } else {
        return null;
      }
    },
    obscureText: true,
    style: TextStyle(color: Style.black),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Style.grey),
      prefixIcon: Icon(
        Icons.lock,
        color: Style.grey,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Style.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(color: Style.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(width: 1, color: Style.grey),
      ),
    ),
  );
}

Widget reg_re_password_textFormField(
    String hintText, TextEditingController regRePassword) {
  return TextFormField(
    controller: regRePassword,
    validator: (value) {
      if (value!.isEmpty) {
        return "PLease Enter Your Password";
      }
      if (!RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(value)) {
        return "Please enter a valid Password";
      } else {
        return null;
      }
    },
    obscureText: true,
    style: TextStyle(color: Style.black),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Style.grey),
      prefixIcon: Icon(
        Icons.lock,
        color: Style.grey,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Style.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(color: Style.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(width: 1, color: Style.grey),
      ),
    ),
  );
}

Widget reg_phone_number(TextEditingController phoneNum) {
  return TextFormField(
    controller: phoneNum,
    validator: (value) {
      if (value!.isEmpty) {
        return "PLease Enter Your Password";
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.number,
    style: TextStyle(color: Style.black),
    decoration: InputDecoration(
      hintText: 'Enter Phone Number',
      hintStyle: TextStyle(color: Style.grey),
      prefixIcon: Icon(
        Icons.phone,
        color: Style.grey,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Style.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(color: Style.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(width: 1, color: Style.grey),
      ),
    ),
  );
}
