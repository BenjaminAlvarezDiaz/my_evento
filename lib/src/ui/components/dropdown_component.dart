import 'package:flutter/material.dart';
import 'package:my_evento/values/k_colors.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  double? height;
  double? width;
  double? heightClose = 15;
  GlobalKey containerOpenKey = GlobalKey();
  GlobalKey containerCloseKey = GlobalKey();
  bool activated = false;
  @override
  Widget build(BuildContext context) {
    return _dropdown(
        Container(
            color: Colors.deepPurple,
            child: const Text('Nouuuuuuuuuuuuuuuuuu')
        ),
        Container(
            color: Colors.pink,
            child: const Text('Siiuu'
                '\nuuu\nuu'
                '\'nuuu\nuuu'
                '\nuuu\nuuu'
                '\nuu\nuuuuu'
                '\nuuuuuu\nuuuuu'
                '\nuuuuuu\nuuuuu'
                '\nuuuuuu\nuuuuu'
                '\nuuuuuu\nuuuuu'
                '\nuuuuuu\nuuuuu'
                '\nuuuuuu\nuuuuu'
            )
        )
    );
  }

  Widget _dropdown(Widget? widgetClose, Widget? widgetOpen){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              activated = !activated;
              if (!activated) {
                final RenderBox renderBox = containerOpenKey
                    .currentContext?.findRenderObject() as RenderBox;
                final Size size = renderBox.size;
                height = size.height;
                width = size.width;
              }
            });
          },
          child: Container(
              key: containerCloseKey,
              height: heightClose,
              child: widgetClose
          ),
        ),
        activated ? GestureDetector(
          onTap: (){
            setState(() {
              activated = !activated;
            });
          },
          child: Container(
              key: containerOpenKey,
              height: height,
              width: width,
              child: widgetOpen
          ),
        ) : Container(color: KTransparent,)
      ],
    );
  }

  Widget _a(){
    return _cardExpanded(
        Container(
            color: Colors.deepPurple,
            child: const Text('Nouuuuuuuuuuuuuuuuuu')
        ),
        Container(
            color: Colors.pink,
            child: const Text('Siiuu\nuuu\nuu\nuuu\nuuu\nuuu\nuuu\nuu\nuuuuu\nuuuuuu\nuuuuu'))
    );
  }

  Widget _cardExpanded(Widget cardClose, Widget cardOpen) {
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
                      heightClose = 15;
                    }
                  });
                },
                child: Container(
                    key: containerCloseKey,
                    height: heightClose,
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
  }
}
