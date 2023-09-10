import 'package:flutter/material.dart';
import 'package:my_evento/values/k_colors.dart';

class Dropdown extends StatefulWidget {
  final Widget? button;
  final Widget? content;
  late final double? heightClose;
  late final double? widthClose;
  late final double? heightOpen;
  late final double? widthOpen;
  Dropdown({
    Key? key,
    required this.button,
    required this.content,
    this.heightClose = 50,
    this.widthClose = 200,
    this.heightOpen = 500,
    this.widthOpen = 200,
  }) : super (key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  GlobalKey containerOpenKey = GlobalKey();
  GlobalKey containerCloseKey = GlobalKey();
  bool activated = false;
  @override
  Widget build(BuildContext context) {
    return _dropdown();
  }

  Widget _dropdown(){
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                activated = !activated;
                /*if (activated) {
                  final RenderBox renderBox = containerOpenKey
                      .currentContext?.findRenderObject() as RenderBox;
                  final Size size = renderBox.size;
                  widget.heightOpen = size.height;
                  widget.widthOpen = size.width;
                } else {
                  final RenderBox renderBox = containerCloseKey.currentContext?.findRenderObject() as RenderBox;
                  final Size size = renderBox.size;
                  widget.heightClose = size.height;
                  //widget.widthClose = size.width;
                }*/
              });
            },
            child: Container(
                key: containerCloseKey,
                height: widget.heightClose,
                width: widget.widthClose,
                child: widget.button
            ),
          ),
          activated ? GestureDetector(
            onTap: (){
              setState(() {
                //activated = !activated;
              });
            },
            child: Container(
                key: containerOpenKey,
                height: widget.heightOpen,
                width: widget.widthOpen,
                child: widget.content
            ),
          ) : Container(color: KTransparent,)
        ],
      ),
    );
  }

  /*Widget _a(){
    return _cardExpanded(
        Container(
            color: Colors.deepPurple,
            child: const Text('Nouuuuuuuuuuuuuuuuuu')
        ),
        Container(
            color: Colors.pink,
            child: const Text('Siiuu\nuuu\nuu\nuuu\nuuu\nuuu\nuuu\nuu\nuuuuu\nuuuuuu\nuuuuu'))
    );
  }*/

  /*Widget _cardExpanded(Widget cardClose, Widget cardOpen) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 100,
      //width: 200,
      curve: Curves.easeInOut,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    activated = !activated;
                    if (!activated) {
                      final RenderBox renderBox = containerOpenKey
                          .currentContext?.findRenderObject() as RenderBox;
                      final Size size = renderBox.size;
                      height = 50 + size.height + 20;
                    }
                    else {
                      final RenderBox renderBox = containerCloseKey.currentContext?.findRenderObject() as RenderBox;
                      final Size size = renderBox.size;
                      widget.heightClose = 15;
                    }
                  });
                },
                child: Container(
                    key: containerCloseKey,
                    height: widget.heightClose,
                    child: cardClose)
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  activated = !activated;
                  if (!activated) {
                    final RenderBox renderBox = containerOpenKey
                        .currentContext?.findRenderObject() as RenderBox;
                    final Size size = renderBox.size;
                    height = 50 + size.height + 20;
                  }
                  else {
                    final RenderBox renderBox = containerCloseKey.currentContext?.findRenderObject() as RenderBox;
                    final Size size = renderBox.size;
                    heightClose = 15;
                  }
                });
              },
              child: Container(
                key: containerOpenKey,
                height: height,
                child: cardOpen,
              ),
            )
          ],
        ),
      ),
    );
  }*/
}
