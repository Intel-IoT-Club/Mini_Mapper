import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
   ConfirmButton({super.key,this.color = const Color.fromRGBO(61, 141, 122, 1),required this.onTap});

  Color color;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 61,
        width: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "Confirm",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}