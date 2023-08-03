// Flutter imports:
import 'package:flutter/material.dart';
import 'package:my_evento/values/k_icons.dart';

import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';

// Project imports:

class SearchBox extends StatefulWidget {
  SearchBox({
    Key? key,
    this.onTap,
    this.onTextChange,
    this.height = 38,
    this.placeHolder,
    this.controller,
    this.onClearSearchTap,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  final Function()? onTap;
  final Function()? onClearSearchTap;
  final Function(String)? onTextChange;
  final double height;
  final String? placeHolder;
  final TextEditingController? controller;
  Color? backgroundColor;
  Color? borderColor;
  double? borderWidth;

  @override
  SearchBoxState createState() => SearchBoxState();
}

class SearchBoxState extends State<SearchBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? KWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.borderColor ?? KTransparent,
          width: widget.borderWidth ?? 1,
        ),
      ),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /* Image.asset(KIconSearchBingosPath, width: 22, height: 22),
          const SizedBox(
            width: 15,
          ), */
          Expanded(
            child: TextField(
              controller: widget.controller,
              onTap: widget.onTap,
              cursorColor: KGray,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: const TextStyle(
                color: KGray,
                fontWeight: FontWeight.normal,
                fontSize: KFontSize25,
              ),
              onChanged: (value) {
                if (widget.onTextChange != null) {
                  widget.onTextChange!(value);
                }
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.placeHolder,
                hintStyle: const TextStyle(
                  color: KGray,
                  fontWeight: FontWeight.w400,
                  fontSize: KFontSize25,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.controller!.clear();
              if (widget.onClearSearchTap != null) {
                widget.onClearSearchTap!();
              }
            },
            child: Image.asset(
              KIconSearchPath,
              width: 22,
              height: 22,
              color: KGray,
            ),
          ),
        ],
      ),
    );
  }
}
