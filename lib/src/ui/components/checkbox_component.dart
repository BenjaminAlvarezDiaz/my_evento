import 'package:flutter/material.dart';

import '../../../values/k_colors.dart';

// ignore: must_be_immutable
class CheckboxComponent extends StatefulWidget {
  final Widget? label;
  final ImageIcon? icon;
  final Function(bool isCheck)? onTap;
  final Color selectedColor;
  late bool isSelected;
  final bool isLabelOnTheLeft;
  final double spacing;
  final double height;
  final double width;
  final bool autoCheckOnClick;
  final MainAxisAlignment mainAxisAlignment;

  CheckboxComponent(
      {Key? key,
      this.label,
      this.icon,
      this.onTap,
      this.selectedColor = KPrimary,
      this.isSelected = false,
      this.isLabelOnTheLeft = false,
      this.spacing = 10,
      this.height = 35,
      this.width = 35,
      this.autoCheckOnClick = true,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  _CheckboxComponentState createState() => _CheckboxComponentState();
}

class _CheckboxComponentState extends State<CheckboxComponent> {
  _CheckboxComponentState();

  final colorLabel = const Color(0xFF666666);
  final Color shadowColor = const Color(0x1A666666);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(),
        child: _content());
  }

  _onTap() {
    setState(() {
      if (widget.autoCheckOnClick) {
        widget.isSelected = !widget.isSelected;
      }
    });

    if (widget.onTap != null) {
      widget.onTap!(widget.isSelected);
    }
  }

  _content() {
    List<Widget> children = _getChildren();
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  _getChildren() {
    List<Widget> children = [];
    if (widget.isLabelOnTheLeft) {
      if (widget.label != null) {
        children.addAll([widget.label!, const SizedBox(width: 10)]);
      }
      children.add(_checkBox());
    } else {
      children.add(_checkBox());
      if (widget.label != null) {
        children.addAll([const SizedBox(width: 10), widget.label!]);
      }
    }
    return children;
  }

  _checkBox() {
    return Container(
      padding: const EdgeInsets.all(5),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.isSelected ? widget.selectedColor : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        border: Border.all(color: KPrimary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: widget.isSelected
                ? widget.selectedColor.withOpacity(0.1)
                : shadowColor,
            spreadRadius: 2,
            blurRadius: 1,
          ),
        ],
      ),
      child: Visibility(
        visible: widget.icon != null,
        child: widget.icon!,
      ),
    );
  }
}
