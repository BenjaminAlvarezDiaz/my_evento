import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/components/rounded_button_component.dart';
import 'package:my_evento/values/k_colors.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    this.buttonText,
    this.buttonTextColor = const Color(0xFFFFFFFF),
    this.buttonFontSize = 14,
    this.buttonFontWeight = FontWeight.normal,
    this.buttonIcon,
    this.buttonHeight = 40,
    this.buttonWidth = 100,
    this.buttonBorderRadius = 20,
    this.buttonBorderColor = Colors.black,
    this.buttonBackgroundColor = const Color(0xFFE12E31),
    this.backgroundColor = Colors.white,
    this.widget = const Expanded(flex: 4, child: SizedBox()),
    this.textTitle = 'Title',
    this.fontSizeTitle = 14,
    this.fontWeightTitle = FontWeight.normal,
    this.colorTextTitle = KWhite,
    this.leftButton = const SizedBox(),
    this.rightButton = const SizedBox(),
    this.dialogPadding = const EdgeInsets.symmetric(vertical: 150, horizontal: 250)
  }) : super(key: key);

  final String? buttonText;
  final Color buttonTextColor;
  final double buttonFontSize;
  final FontWeight buttonFontWeight;
  final Icon? buttonIcon;
  final double buttonHeight;
  final double buttonWidth;
  final Color buttonBackgroundColor;
  final double buttonBorderRadius;
  final Color buttonBorderColor;
  final Color backgroundColor;
  final Widget widget;
  final String textTitle;
  final double fontSizeTitle;
  final Color colorTextTitle;
  final FontWeight fontWeightTitle;
  final Widget leftButton;
  final Widget rightButton;
  final EdgeInsets? dialogPadding;

  @override
  Widget build(BuildContext context) => RoundedButtonComponent(
      text: buttonText,
      textColor: buttonTextColor,
      fontSize: buttonFontSize,
      fontWeight: buttonFontWeight,
      icon: buttonIcon,
      height: buttonHeight,
      width: buttonWidth,
      backgroundColor: buttonBackgroundColor,
      borderRadius: buttonBorderRadius,
      borderColor: buttonBorderColor,
      onPressed: (){
        showAmountDialog(context);
      }
  );

  void showAmountDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context){
        return Dialog(
          insetPadding: dialogPadding,
          backgroundColor: backgroundColor,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text(
                textTitle,
                style: TextStyle(
                    fontSize: fontSizeTitle,
                    fontWeight: fontWeightTitle,
                    color: colorTextTitle,
                ),
              ),
              widget,
              _buttons()
            ],
          )
        );
      }
  );


  _buttons(){
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          leftButton,
          rightButton,
        ],
      ),
    );
  }
}
