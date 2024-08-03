import 'package:flutter/material.dart';
import 'dart:math';

class ElevatedHorizontalList extends StatefulWidget {
  final Widget? itemBuilder;

  const ElevatedHorizontalList({
    super.key,
    this.itemBuilder
  });

  @override
  State<ElevatedHorizontalList> createState() => _ElevatedHorizontalListState();
}

class _ElevatedHorizontalListState extends State<ElevatedHorizontalList> {

  final _controller = PageController(
      viewportFraction: 0.5,
      keepPage: true
  );

  double currentPage = 0.0;

  void _listener(){
    setState(() {
      currentPage = _controller.page!;
    });
  }

  @override
  void initState(){
    super.initState();
    _controller.addListener(_listener);
  }

  @override
  void dispose(){
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? opacity;
    return PageView.builder(itemBuilder: (_, i){
      if(i == currentPage){
        opacity = 1;
        return Transform.scale(
            scale: 1,
            child: widget.itemBuilder,
        );
      }else if(i < currentPage){
        opacity = max(1 - (currentPage - i), 0.8);
        return Transform.scale(
            scale: max(1 - (currentPage - i), 0.8),
            child: widget.itemBuilder,
        );
      }else{
        opacity = max(1 - (i - currentPage), 0.8);
        listCards[i].opacity = opacity!;
        return Transform.scale(
            scale: max(1 - (i - currentPage), 0.8),
            child: widget.itemBuilder,
        );
      }
    });
  }
}
