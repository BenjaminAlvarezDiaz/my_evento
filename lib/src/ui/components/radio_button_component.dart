// Flutter imports:
import 'package:flutter/material.dart';

import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';

// Project imports:

class RadioButtonComponent extends StatefulWidget {
  final String label;
  final TextStyle? style;
  final Function onPressed;
  final String? description;
  final bool isSelected;
  final Color selectedColor;
  final bool isLabelOnTheLeft;
  final bool isEnabled;
  final double radius;

  const RadioButtonComponent({
    Key? key,
    required this.label,
    this.style,
    this.description,
    required this.onPressed,
    this.selectedColor = KPrimary,
    this.isSelected = false,
    this.isLabelOnTheLeft = false,
    this.isEnabled = true,
    this.radius = 25,
  }) : super(key: key);

  @override
  RadioButtonComponentState createState() => RadioButtonComponentState();
}

class RadioButtonComponentState extends State<RadioButtonComponent> {
  RadioButtonComponentState();

  final colorLabel = const Color(0xFF666666);
  final Color shadowColor = const Color(0x1A666666);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => {
              if (widget.isEnabled)
                {
                  widget.onPressed(),
                }
            },
        child: _content());
  }

  _content() {
    List<Widget> children = _getChildren();
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: children),
        widget.description != null
            ? Row(children: [
                SizedBox(width: widget.radius + 10),
                Flexible(
                  child: Text(
                    widget.description ?? "",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: KGray_L1,
                      fontSize: KFontSize25,
                    ),
                  ),
                ),
              ])
            : const SizedBox.shrink(),
      ],
    );
  }

  _getChildren() {
    List<Widget> children = [];
    if (widget.isLabelOnTheLeft) {
      children.addAll([_label(), const SizedBox(width: 10)]);
      children.add(_checkBox());
    } else {
      children.add(_checkBox());
      children.addAll([const SizedBox(width: 10), _label()]);
    }
    return children;
  }

  _label() {
    return Text(
      widget.label,
      style: widget.style ??
          const TextStyle(
            color: KGray,
            fontSize: KFontSize30,
            fontWeight: FontWeight.w400,
          ),
    );
  }

  _checkBox() {
    return Container(
      padding: EdgeInsets.zero,
      height: widget.radius,
      width: widget.radius,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        border: widget.isSelected
            ? Border.all(color: Colors.white, width: 5)
            : null,
        boxShadow: [
          BoxShadow(
            color: widget.isSelected
                ? widget.selectedColor.withOpacity(0.1)
                : shadowColor,
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.isEnabled
              ? (widget.isSelected ? widget.selectedColor : Colors.white)
              : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius - 10)),
        ),
      ),
    );
  }
}
