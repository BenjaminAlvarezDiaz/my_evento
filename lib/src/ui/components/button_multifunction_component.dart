import 'package:flutter/material.dart';
import 'package:my_evento/values/k_colors.dart';

class ButtonMultifunction extends StatefulWidget {
  final bool withIcon;
  final bool iconRight;
  final bool withBorder;
  final Icon? changedIcon;
  final Icon? icon;
  final Text text;
  final Function()? onTap;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color borderColor;
  final bool withSplash;
  final Color? splashColor;
  const ButtonMultifunction({
    Key? key,
    this.withIcon = false,
    this.iconRight = false,
    this.withBorder = false,
    this.changedIcon,
    this.icon,
    required this.text,
    required this.onTap,
    this.height = 50,
    this.width = 150,
    this.backgroundColor = const Color(0xff7F0432),
    this.borderColor = KTransparent,
    this.withSplash = true,
    this.splashColor = Colors.grey,
  }) : super(key: key);

  @override
  State<ButtonMultifunction> createState() => _ButtonMultifunctionState();
}

class _ButtonMultifunctionState extends State<ButtonMultifunction> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: KGrey4.withOpacity(0.1),
      highlightColor: KGrey4.withOpacity(0.1),
      hoverColor: KGrey4.withOpacity(0.1),
      child: Ink(
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: widget.withBorder ? BorderRadius.circular(5) : null,
            border: widget.withBorder ? Border.all(color: widget.borderColor
            ) : null
        ),
        child: Container(
          height: widget.height,
          width: widget.width,
          child: widget.withIcon ? widget.iconRight ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //const SizedBox(width: 20,),
              widget.text,
              const SizedBox(width: 10,),
              widget.icon!,
              const SizedBox(width: 10,)
            ],
          ) :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20,),
              widget.icon!,
              const SizedBox(width: 10,),
              widget.text,
              const SizedBox(width: 20,)
            ],
          ) :
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20,),
                widget.text,
                const SizedBox(width: 20,),
              ]
          )
        ),
      ),
    );
  }
}
