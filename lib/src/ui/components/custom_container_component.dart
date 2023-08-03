// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../values/k_colors.dart';

class CustomContainerComponent extends StatefulWidget {
  Widget? title;
  Widget? content;
  bool? isCollapsable;
  bool isCollapsed = false;

  CustomContainerComponent({
    super.key,
    this.content,
    this.title,
    this.isCollapsable,
  }) {
    if (isCollapsable != null && isCollapsable!) {
      isCollapsed = true;
    }
  }

  @override
  State<CustomContainerComponent> createState() =>
      _CustomContainerComponentState();
}

class _CustomContainerComponentState extends State<CustomContainerComponent> {
  Icon _collapseIcon = Icon(
    Icons.keyboard_double_arrow_down_sharp,
    color: KWhite,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: KBackgroundBlue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: KBackgroundBlue_T1,
            spreadRadius: 0.5,
            blurRadius: 5.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title != null
                ? GestureDetector(
                    onTap: widget.isCollapsable != null && widget.isCollapsable!
                        ? () {
                            widget.isCollapsed = !widget.isCollapsed;
                            _collapseIcon = widget.isCollapsed
                                ? const Icon(
                                    Icons.keyboard_double_arrow_down_sharp,
                                    color: KWhite,
                                  )
                                : const Icon(
                                    Icons.keyboard_double_arrow_up_sharp,
                                    color: KWhite,
                                  );
                            setState(() {});
                          }
                        : () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.title!,
                        widget.isCollapsable != null && widget.isCollapsable!
                            ? GestureDetector(
                                onTap: () {
                                  widget.isCollapsed = !widget.isCollapsed;
                                  _collapseIcon = widget.isCollapsed
                                      ? const Icon(
                                          Icons
                                              .keyboard_double_arrow_down_sharp,
                                          color: KWhite,
                                        )
                                      : const Icon(
                                          Icons.keyboard_double_arrow_up_sharp,
                                          color: KWhite,
                                        );
                                  setState(() {});
                                },
                                child: _collapseIcon,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            widget.isCollapsed
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 10,
                  ),
            Visibility(
              visible: widget.isCollapsed == false,
              child: widget.content ?? const SizedBox.shrink(),
            ),
            widget.isCollapsed
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 10,
                  ),
          ],
        ),
      ),
    );
  }
}
