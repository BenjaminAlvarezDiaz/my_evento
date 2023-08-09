import 'package:mvc_pattern/mvc_pattern.dart';
import '../../interfaces/i_view_controller.dart';
import '../../managers/data_manager.dart';
import '../../providers/app_provider.dart';
import '../../utils/screen_args.dart';

class InitScreenController extends ControllerMVC implements IViewController {
  static late InitScreenController _this;

  factory InitScreenController(ScreenArgs? args) {
    _this = InitScreenController._(args);
    return _this;
  }

  static InitScreenController get con => _this;
  ScreenArgs? args;
  InitScreenController._(this.args);

  @override
  void initScreen({ScreenArgs? arguments}) {
    args = arguments;
  }

  @override
  disposeScreen() {}

  init() async {
    await DataManager().init();
    await AppProvider().init();
    //_locale = Locale(getCode(DataManager().getCulture()), '');
    setState(() {});
  }

  /* changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getCode(Culture code) {
    switch (code) {
      case Culture.es:
        return 'es';
      case Culture.en:
        return 'en';
    }
  } */
}
