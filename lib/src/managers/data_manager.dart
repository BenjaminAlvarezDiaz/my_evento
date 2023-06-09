import 'package:my_evento/src/data_base/event_database.dart';
import 'package:my_evento/src/interfaces/idata_access.dart';
import 'package:my_evento/src/data_access/data_dummy.dart';

class DataManager {

  late IDataAccess dataAccess;

  DataManager._privateConstruct(this.dataAccess);

  //EventDataBase.instance para la base de datos Dummy() para los datos dummy
  static final DataManager _instance = DataManager._privateConstruct(EventDataBase.instance);

  factory DataManager(){
    return _instance;
  }

  getDateEvent(){
    return ;
  }
  getHourEvent(){
    return ;
  }
  /*getTitleEvent(){
    return dataAccess.getTitleEvent();
  }*/
  getDescriptionEvent(){
    return ;
  }
  getImageEvent(){
    return ;
  }
  getLocalization(){
    return ;
  }
  getLocalizationInMap(){
    return ;
  }
  getListEvent(){
    return dataAccess.getListEvent();
  }
  closeDataBase(){
    return dataAccess.closeDataBase();
  }

  setDateEvent(String newDate) {
    return ;
  }

  setDescriptionEvent(String newDescription) {
    return ;
  }

  setHourEvent(String newHour) {
    return ;
  }

  setImageEvent(String newImage) {
    return ;
  }

  setLocalization(String newLocalization) {
    return ;
  }

  setLocalizationInMap(String newLocalizationInMap) {
    return ;
  }

  setTitleEvent(String newTitle) {
    return ;
  }

  setListEvent() {
    return ;
  }

}