import 'package:flutter/material.dart';

import '../../../values/k_colors.dart';
import '../../managers/screen_manager.dart';

class SelectedImage{
  final BuildContext context;
  final IconData iconLeft;
  final IconData iconRight;
  final String labelLeft;
  final String labelRight;
  final TextStyle? labelItemsStyle;
  final double? iconsSize;
  final double? itemsSize;
  final BoxDecoration? itemsDecoration;
  final Widget? button;
  final Color? backgroundColor;
  final Color? iconsColors;
  final Function()? onTapLeft;
  final Function()? onTapRight;

  SelectedImage({
    required this.context,
    required this.iconLeft,
    required this.iconRight,
    this.labelLeft = 'labelLeft',
    this.labelRight = 'labelRight',
    this.labelItemsStyle,
    this.iconsSize = 32,
    this.itemsSize,
    this.itemsDecoration,
    this.button,
    this.backgroundColor,
    this.iconsColors,
    this.onTapLeft,
    this.onTapRight,
  });

  final double radius = 10;

  Future show(){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return _dialog();
        }
    );
  }

  _dialog(){
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
        ),
        Center(
          child: Container(
            child: _body(),
            width: 200,
            height: 100,
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ],
    );
  }

  _body(){
    return Column(
      children: [
        SizedBox(height: 20,),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _itemLeft(),
              SizedBox(width: 50,),
              _itemRight()
            ],
          ),
        ),
        //Expanded(flex: 2, child: Material(type: MaterialType.transparency, child: _confirmButton(),)),
        //SizedBox(height: 20,),
        //Expanded(flex: 1, child: SizedBox(height: 5,)),
      ],
    );
  }

  _itemsDefaultDecoration(){
    return BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
    );
  }

  _itemLeft(){
    return Column(
      children: [
        GestureDetector(
          onTap: onTapLeft,
          child: Container(
              decoration: itemsDecoration == null? _itemsDefaultDecoration() : itemsDecoration,
              height: itemsSize,
              width: itemsSize,
              child: Center(
                  child: Icon(iconLeft, size: iconsSize, color: iconsColors,))
          ),
        ),
        Material(type: MaterialType.transparency, child: Text(labelLeft, style: labelItemsStyle,)),
      ],
    );
  }

  _itemRight(){
    return Column(
      children: [
        GestureDetector(
          onTap: onTapRight,
          child: Container(
              decoration: itemsDecoration == null? _itemsDefaultDecoration() : itemsDecoration,
              height: itemsSize,
              width: itemsSize,
              child: Center(
                  child: Icon(iconRight, size: iconsSize, color: iconsColors,))
          ),
        ),
        Material(type: MaterialType.transparency, child: Text(labelRight, style: labelItemsStyle,)),
      ],
    );
  }

  _confirmButtonDefault(){
    return Container(
        height: 50,
        width: 100,
        color: Colors.lightBlue,
    );
  }

  _confirmButton(){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context, false);
      },
      child: button == null? _confirmButtonDefault() : button,
    );
  }
}