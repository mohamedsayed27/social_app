import 'package:flutter/material.dart';

Widget defaultFormField(
    {TextEditingController? controller,
    String? hint,
    String? label,
    Function? onChange,
    Function? onSubmit,
      IconButton? suffixIcon,
      IconData? prefixIcon,
      Function? onTab,
      bool? obscure,
    Function? validate}) {
  return TextFormField(
    controller: controller,
    obscureText:obscure! ,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: Icon(prefixIcon),
      hintText: hint,
      label: Text(label!),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    onChanged: (text) {
      onChange!();
    },
    validator: (v) {
       return validate!(v);
    },
    onFieldSubmitted: (s) {
      onSubmit!();
    },
  );
}

Widget specialButton({
  Function? onPress,
  String? text,
}) {
  return SizedBox(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
        onPressed: () {
        onPress!();
    },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
      ),
        child: Text(text!)
    ),
  );
}
