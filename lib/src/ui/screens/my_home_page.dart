import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/components/calendar_picker.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';
import 'package:my_evento/src/ui/screen_controllers/my_home_page_controller.dart';
import 'package:my_evento/src/models/event_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  StateMVC<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends StateMVC<MyHomePage> {
  late MyHomePageController _con;
  late List<Event> events;
  bool isLoading = false;

  _MyHomePageState() : super (MyHomePageController()) {
    _con = MyHomePageController();
  }

  int _selectedIndex = 0;
  PageController pageController = PageController();

  @override
  void initState(){
    super.initState();

    refreshEvents();
  }

  Future refreshEvents() async {
    setState(() => isLoading = true);

    events = await _con.dataManager.getListEvent();

    setState(() => isLoading = false);
  }

  @override
  void dispose(){
    _con.closeDataBase();

    super.dispose();
  }

  void onTaped(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leading(),
        actions: [
          actions()
        ],
        centerTitle: true,
        title: titlePage(),
        backgroundColor: const Color(0xff7F0432),
      ),
      body: body(context),
      bottomNavigationBar: BottomNavigationBar(
        items: barItems(),
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff00001D),
        unselectedItemColor: const Color(0xff231142),
        currentIndex: _selectedIndex,
        onTap: onTaped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  List<BottomNavigationBarItem> barItems(){
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: ''
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: ''
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: ''
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: ''
      )
    ];
  }

  Widget leading(){
    return IconButton(
        onPressed: (){},
        icon: const Icon(Icons.notifications),
        tooltip: ('Notificaciones')
    );
  }

  Widget actions(){
    return IconButton(
      onPressed: (){},
      icon: const Icon(Icons.more_vert),
      tooltip: ('Opciones'),
    );
  }

  Widget body(context){
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          isLoading ? const Center(child: CircularProgressIndicator())
              : eventListHome(),
          calendar(),
          isLoading ? const Center(child: CircularProgressIndicator())
              : myEventList(context),
          Container(color: Colors.redAccent,)
        ],
      ),
    );
  }

  void onPageChanged(int _index){
    return setState(() {
      _selectedIndex = _index;
    });
  }

  Widget titlePage(){
    return IndexedStack(
      index: _selectedIndex,
      children: const [
        Center(child: Text('Inicio')),
        Center(child: Text('Calendario de eventos')),
        Center(child: Text('Tus eventos')),
        Center(child: Text('Tu perfil'))
      ],
    );
  }

  Widget eventListHome(){
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: itemBuilder,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
            ),
          ),
        ],
      ),
    );
  }

  Widget myEventList(context){
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          newEvent(context),
          const SizedBox(height: 20),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: itemBuilder,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
            ),
          )
        ],
      ),
    );
  }

  Widget calendar(){
    late int? daySelected = 0;
    return Container(
        color: Colors.white,
        child: CalendarPicker(
          daysWithBorder: false,
          nameDaysWithBorder: false,
          fontWeightOfNameDay: FontWeight.w500,
          fontWeightOfDay: FontWeight.normal,
          fontWeightOfMonth: FontWeight.w500,
          onDaySelected: (date){
            setState(() {
              daySelected = date.day;
              print(daySelected);
            });
          },
        )
    );
  }

  Widget newEvent(context){
    return ButtonMultifunction(
      text: const Text('Nuevo evento', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16),
      ),
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onTap: (){
        _con.onPressedCreateEvent(context);
        },
      withIcon: true,
      withBorder: true,
      width: 200,
    );
  }

  Widget itemBuilder(BuildContext context, int index){
    return InkWell(
      child: Container(
        height: 200,
        color: Colors.white,
        child: Stack(
          children: [
            imageItemBuilder(index),
            informationItemBuilder(index)
          ],
        ),
      ),
      onTap: (){},
    );
  }

  Widget imageItemBuilder(int index){
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('${_con.getListEvent()[index].image}'),
              fit: BoxFit.cover)
          )
      ),
    );
  }

  Widget informationItemBuilder(int index){
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: title(index),
        ),
        Expanded(
          flex: 1,
          child: dateHourAndLocalization(index),
        )
      ],
    );
  }

  Widget title(int index){
    return Row(
      children: [
        const Expanded(flex: 14, child: SizedBox()),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(flex: 3,
                  child: Text('${_con.getListEvent()[index].eventTitle}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500))),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  Widget dateHourAndLocalization(int index){
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(flex: 10 , child: Text('${_con.getListEvent()[index].date.day.toString()} '
                      '/ ${_con.getListEvent()[index].date.month.toString()}'
                      ' de ${_con.getListEvent()[index].startHour}'
                      ' a ${_con.getListEvent()[index].endHour}',
                      style: const TextStyle(fontSize: 16))),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(flex: 7, child: Text('${_con.getListEvent()[index].localization}', style: const TextStyle(fontSize: 16))),
                  const Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
        const Expanded(flex: 2, child: SizedBox())
      ],
    );
  }

}

//Para ver los eventos de una persona necesito completar en el event model una id del propio usuario para luego buscar en
// la tabla de la base de datos los eventos que tengan la misma id para mostrarlos en la otra pantalla
//Expanded(flex: 1, child: Text(_con.getListEvent()[index].date.day.toString(), style: const TextStyle(fontSize: 16),)),
//Expanded(flex: 1, child: Text('/ ${_con.getListEvent()[index].date.month.toString()}', style: const TextStyle(fontSize: 16),)),
//const Expanded(flex: 1, child: Text('de',  style: TextStyle(fontSize: 16))),
//Expanded(flex: 2, child: Text('${_con.getListEvent()[index].startHour}', style: const TextStyle(fontSize: 16))),
//const Expanded(flex: 1, child: Text('a', style: TextStyle(fontSize: 16))),
//Expanded(flex: 2, child: Text('${_con.getListEvent()[index].endHour}', style: const TextStyle(fontSize: 16))),