import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screen_controllers/title_and_description_screen_controller.dart';

class TitleAndDescriptionScreen extends StatefulWidget {
  const TitleAndDescriptionScreen({super.key});

  @override
  StateMVC<TitleAndDescriptionScreen> createState() => _TitleAndDescriptionScreenState();
}

class _TitleAndDescriptionScreenState extends StateMVC<TitleAndDescriptionScreen> {
  late TitleAndDescriptionScreenController _con;

  _TitleAndDescriptionScreenState() : super(TitleAndDescriptionScreenController()){
    _con = TitleAndDescriptionScreenController();
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(),
    );
  }

  AppBar appBar(context){
    return AppBar(
      backgroundColor: Colors.red,
      leading: IconButton(
          onPressed: (){
            _con.onPressedBack(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
      ),
    );
  }

  Widget body(){
    return Container(color: Colors.red,);
  }
}
