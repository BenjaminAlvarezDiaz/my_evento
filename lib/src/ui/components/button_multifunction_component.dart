import 'package:flutter/material.dart';

class ButtonMultifunction extends StatefulWidget {
  late bool withIcon;
  late bool iconRight;
  late bool withBorder;
  late Icon? changedIcon;
  late Icon? icon;
  late Text text;
  late Function()? onTap;
  late double height;
  late double width;
  late Color? backgroundColor;
  ButtonMultifunction({
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
    this.backgroundColor = const Color(0xff7F0432)
  }) : super(key: key);

  @override
  State<ButtonMultifunction> createState() => _ButtonMultifunctionState();
}

class _ButtonMultifunctionState extends State<ButtonMultifunction> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.withBorder ? BorderRadius.circular(5) : null,
          border: widget.withBorder ? Border.all(color: const Color(0xff7F0432)
          ) : null
        ),
        height: widget.height,
        width: widget.width,
        child: widget.withIcon ? widget.iconRight ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20,),
            widget.text,
            const SizedBox(width: 10,),
            widget.icon!,
            const SizedBox(width: 20,)
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
    );
  }
}
