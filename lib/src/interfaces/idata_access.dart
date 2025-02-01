import 'package:my_evento/src/models/event_model.dart';

abstract class IDataAccess {
  create(Event event);
  getDateEvent();
  getHourEvent();
  //getTitleEvent();
  getDescriptionEvent();
  getImageEvent();
  getLocalization();
  getLocalizationInMap();
  getListEvent();
  setDateEvent(String newDate);
  setHourEvent(String newHour);
  setTitleEvent(String newTitle);
  setDescriptionEvent(String newDescription);
  setImageEvent(String newImage);
  setLocalization(String newLocalization);
  setLocalizationInMap(String newLocalizationInMap);
  setListEvent();
  closeDataBase();
}