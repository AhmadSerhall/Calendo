//custom dialog fixed dimensions
import 'package:admin/core/constants/colors.dart';
import 'package:admin/core/constants/constraints.dart';
import 'package:admin/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

showDialogError(String title, String msg, BuildContext context) {
  if (msg.length > 74) {
    msg = msg.substring(0, 73);
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Container(
          // width: 343,
          // height: 360,
          //margin: EdgeInsets.symmetric(horizontal: defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: SvgPicture.asset(
                      'assets/svg/warning.svg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(title, textScaleFactor: 1.0, style: headline2),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.0,
                      style: headline3,
                    ),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      width: 100.w,
                      height: 46,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          textScaleFactor: 1.0,
                          style: headline3.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
