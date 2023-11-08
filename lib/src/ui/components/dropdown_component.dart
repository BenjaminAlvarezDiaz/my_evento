import 'package:flutter/material.dart';
import 'package:my_evento/values/k_colors.dart';

class Dropdown extends StatefulWidget {
  final Widget? button;
  final Widget? content;
  final double? heightButton;
  final double? widthButton;
  final double? heightOpen;
  final double? widthOpen;
  final bool oneItem;
  final Function()? buttonOnTap;
  final String textInside;
  final TextStyle? textInsideTheme;
  final Decoration? buttonDecoration;
  final Color? iconColor;
  const Dropdown({
    Key? key,
    this.button,
    this.content,
    this.heightButton = 50,
    this.widthButton = 200,
    this.heightOpen = 500,
    this.widthOpen = 200,
    this.oneItem = false,
    this.buttonOnTap,
    this.textInside = '',
    this.textInsideTheme,
    this.buttonDecoration = const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
    this.iconColor = Colors.black54,
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
    return widget.oneItem ? _dropdownOneItem() : _dropdown();
  }

  Widget _dropdownOneItem(){
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
            child: widget.button ?? _button(),
          ),
          activated ? Container(
              height: widget.heightOpen,
              width: widget.widthOpen,
              child: widget.content
          ) : Container(color: KTransparent,)
        ],
      ),
    );
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
                height: widget.heightButton,
                width: widget.widthButton,
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

  Widget _button(){
    return InkWell(
        onTap: widget.buttonOnTap,
        child: Container(
          decoration: widget.buttonDecoration,
          child: Row(
            children: [
              SizedBox(width: 20,),
              Expanded(flex: 3, child: Text(widget.textInside, style: widget.textInsideTheme,)),
              Expanded(flex: 1, child: Icon(Icons.keyboard_arrow_down, color: widget.iconColor,))
            ],
          ),
        )
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

class _MyDropdownState extends State<Dropdown> {
  List<String> items = ['Opción 1', 'Opción 2', 'Opción 3'];
  String selectedItem = 'Opción 1';
  bool isDropdownOpen = false;

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  void selectItem(String item) {
    setState(() {
      selectedItem = item;
      isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: toggleDropdown,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(selectedItem),
            ),
          ),
          if (isDropdownOpen)
            Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: items.map((item) {
                  return GestureDetector(
                    onTap: () => selectItem(item),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      child: Text(item),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
