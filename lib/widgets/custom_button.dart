import 'package:flutter/material.dart';
import 'package:providerauth/helpers/style.dart';
import 'package:providerauth/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String msg;
  final Function onTap;

  const CustomButton({Key key, this.msg, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 12),
      child: GestureDetector(
        onTap: onTap ?? null,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(2, 1),
                  blurRadius: 2)
            ],
            color: primary,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: CustomText(
                    text: msg,
                    color: white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
