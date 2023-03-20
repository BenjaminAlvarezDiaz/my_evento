import 'package:my_evento/src/interfaces/idata_access.dart';
import 'package:my_evento/src/models/event_model.dart';


class Dummy implements IDataAccess {
  //late EventModel eventModel;
  List<Event> listEventModel = <Event>[
    Event( 1, 'Game Over', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
        'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
        'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
        'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
        'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
        'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
        'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Oaaaaaa', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Ovesdasdasr', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Over', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Over', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Overaasdasdasdasdasdasdasasd', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Over', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Over', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
    Event( 1,'Game Over', 'assets/74297472_p0_master1200.jpg', DateTime(2023, 2, 19), '4:30', '5:30', 'Micro estadio delmi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus nibh velit, '
            'nec molestie lorem hendrerit ac. Morbi tempor ligula in condimentum viverra. '
            'In semper nisl tellus, eu fringilla orci pharetra eget. Quisque malesuada auctor ullamcorper. '
            'Sed vehicula metus nibh, quis ullamcorper leo rutrum commodo. Sed dictum magna quam, '
            'nec tincidunt sem imperdiet vitae. Maecenas ac mauris diam. Nam sed sollicitudin nibh, vel semper dolor. '
            'Integer at elit ultricies, feugiat erat at, pellentesque neque. Duis ut mi elementum magna viverra iaculis. '
            'Proin consequat ultricies nunc rhoncus condimentum. Nulla quis tortor consectetur, vestibulum tellus sit amet, euismod velit. '),
  ];

  @override
  getDateEvent() {
    return ;
  }

  @override
  getDescriptionEvent() {
    return ;
  }

  @override
  getHourEvent() {
    return ;
  }

  @override
  getImageEvent() {
    return ;
  }

  @override
  getLocalization() {
    return ;
  }

  @override
  getLocalizationInMap() {
    return ;
  }

  @override
  getTitleEvent(){
    int index = 1;
    return listEventModel[index].eventTitle;
  }

  @override
  List <Event> getListEvent() {
    return listEventModel;
  }

  @override
  setDateEvent(String newDate) {
    return ;
  }

  @override
  setDescriptionEvent(String newDescription) {
    return ;
  }

  @override
  setHourEvent(String newHour) {
    return ;
  }

  @override
  setImageEvent(String newImage) {
    return ;
  }

  @override
  setLocalization(String newLocalization) {
    return ;
  }

  @override
  setLocalizationInMap(String newLocalizationInMap) {
    return ;
  }

  @override
  setTitleEvent(String newTitle) {
    return ;
  }

  @override
  setListEvent() {
    return ;
  }

  @override
  closeDataBase() {
    return;
  }

}