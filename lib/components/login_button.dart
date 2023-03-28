import 'package:flutter/material.dart';
import 'package:hrm_1c/utils/styles.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function()? onTapFunction;
  final bool enabled;

  const LoginButton({
    this.text = "",
    this.onTapFunction,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        if(enabled==false){
          return;
        }
        if(onTapFunction!=null){
          onTapFunction!.call();
        }
      },
      child: Container(
        width: double.infinity,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: enabled? HRMColorStyles.lightBlueColor:Colors.grey.shade500,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4)
            ]),
        child: Text(
          text,
          style: HRMTextStyles.btnText,
        ),
      ),
    );
  }
}
