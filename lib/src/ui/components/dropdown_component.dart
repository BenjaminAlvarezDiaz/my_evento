import 'package:flutter/material.dart';
import 'package:my_evento/values/k_colors.dart';

class Dropdown extends StatefulWidget {
  final Widget? button;
  final Widget? content;
  final Widget? oneItemContent;
  final double? heightButton;
  final double? widthButton;
  final double? heightDropdownList;
  final double widthDropdownList;
  final double? horizontalAlignment;
  final bool oneItem;
  final bool dropdownListLeft;
  final bool dropdownListRight;
  //final Function()? buttonOnTap;
  final String textInside;
  final TextStyle? textInsideTheme;
  final Decoration? buttonDecoration;
  final Color? iconColor;
  const Dropdown({
    Key? key,
    this.button,
    this.content,
    this.oneItemContent,
    this.heightButton = 50,
    this.widthButton = 200,
    this.heightDropdownList = 100,
    this.widthDropdownList = 100,
    this.horizontalAlignment = 90,
    this.oneItem = false,
    this.dropdownListLeft = false,
    this.dropdownListRight = false,
    //this.buttonOnTap,
    this.textInside = '',
    this.textInsideTheme,
    this.buttonDecoration,
    this.iconColor = Colors.black54,
  }) : super (key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  //final GlobalKey _containerOpenKey = GlobalKey();
  //GlobalKey _containerCloseKey = GlobalKey();
  //Size _containerOpenSize = const Size(0, 0);
  bool isDropdownOpen = false;

  Widget? _withDefaultButton(){
    if(widget.button == null){
      return InkWell(
        onTap: (){
          setState(() {
            isDropdownOpen = !isDropdownOpen;
          });
        },
        child: Container(
          height: widget.heightButton,
          width: widget.widthButton,
          decoration: _defaultButtonDecoration(),
          child: Row(
            children: [
              SizedBox(width: 20,),
              Expanded(flex: 3, child: Text(widget.textInside, style: widget.textInsideTheme,)),
              isDropdownOpen ?
              Expanded(flex: 1, child: Icon(Icons.keyboard_arrow_up, color: widget.iconColor,)) :
              Expanded(flex: 1, child: Icon(Icons.keyboard_arrow_down, color: widget.iconColor,))
            ],
          ),
        ),
      );
    }
    return _button();
  }

  Decoration? _defaultButtonDecoration(){
    if(widget.buttonDecoration == null && widget.button != null){
      return const BoxDecoration();
    }else if(widget.buttonDecoration == null){
     return BoxDecoration(
         color: Colors.white,
         borderRadius: const BorderRadius.all(Radius.circular(10)),
         border: Border.all(color: Colors.black54));
    }
    return widget.buttonDecoration;
  }

  @override
  Widget build(BuildContext context) {
    return widget.oneItem ? _dropdownOneItem() : _dropdown();
  }

  Widget _dropdownOneItem(){
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: Column(
        children: [
          Container(child: _withDefaultButton()),
          SizedBox(height: 5,),
          _dropdownItem(),
        ],
      ),
    );
  }

  Widget _dropdownItem(){
    if(isDropdownOpen && (widget.dropdownListLeft && widget.dropdownListRight) != null){
      return Row(
        children: [
          widget.dropdownListRight? SizedBox(width: widget.horizontalAlignment) : const SizedBox(),
          Container(
              height: widget.heightDropdownList,
              width: widget.widthDropdownList,
              child: widget.oneItemContent),
          widget.dropdownListLeft? SizedBox(width: widget.horizontalAlignment) : const SizedBox(),
        ],
      );
    } else if(isDropdownOpen != null && (widget.dropdownListLeft && widget.dropdownListRight) == null){
      return Container(
          height: widget.heightDropdownList,
          width: widget.widthDropdownList,
          child: widget.oneItemContent);
    }
    return Container(color: Colors.transparent,);

  }

  @override
  void initState() {
    super.initState();

    /*WidgetsBinding.instance!.addPostFrameCallback((_) {
      final RenderBox renderBox = _containerOpenKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _containerOpenSize = renderBox.size;
        print(_containerOpenSize.width);
      });
      print(_containerOpenSize.width);
    });
    print(_containerOpenSize.width);*/
  }

  Widget _dropdown(){
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                isDropdownOpen = !isDropdownOpen;
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
            child: _withDefaultButton(),
          ),
          isDropdownOpen ? Container(child: widget.content) :
          Container(color: Colors.transparent,)
        ],
      ),
    );
  }

  Widget _dropdownItems(){
    if((isDropdownOpen && widget.dropdownListLeft && widget.dropdownListRight) != null){
      return Row(
        children: [
          widget.dropdownListRight? SizedBox(width: widget.horizontalAlignment) : const SizedBox(),
          Container(
              height: widget.heightDropdownList,
              width: widget.widthDropdownList,
              child: widget.oneItemContent),
          widget.dropdownListLeft? SizedBox(width: widget.horizontalAlignment) : const SizedBox(),
        ],
      );
    } else if(isDropdownOpen != null && (widget.dropdownListLeft && widget.dropdownListRight) == null){
      return Container(
          height: widget.heightDropdownList,
          width: widget.widthDropdownList,
          child: widget.oneItemContent);
    }
    return Container(color: Colors.transparent,);

  }

  Widget _button(){
    return InkWell(
        onTap: (){
          setState(() {
            isDropdownOpen = !isDropdownOpen;
          });
        },
        child: Container(
          height: widget.heightButton,
          width: widget.widthButton,
          decoration: _defaultButtonDecoration(),
          child: widget.button,
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

/*class _MyDropdownState extends State<Dropdown> {
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
}*/
