// ignore_for_file: empty_catches

//import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/components/Item_data_form_component.dart';
import 'package:my_evento/src/utils/functions_utils.dart';
import '../../values/k_colors.dart';
import '../../values/k_values.dart';
import '../enums/page_names.dart';
import '../ui/screens/my_home_screen.dart';
import '../ui/popups/form_popup.dart';
import '../ui/popups/information_alert_popup.dart';
import '../utils/screen_args.dart';

class ScreenManager {
  static final ScreenManager _instance = ScreenManager._constructor();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  PageNames? currentPage;

  factory ScreenManager() {
    return _instance;
  }

  PageNames? getPageNameEnum(String? screenName) {
    try {
      return PageNames.values.where((x) => x.toString() == screenName).single;
    } catch (e) {}

    return null;
  }

  ScreenManager._constructor();

  MaterialPageRoute? getRoute(RouteSettings settings) {
    ScreenArgs? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as ScreenArgs;
    }

    PageNames? page = getPageNameEnum(settings.name);

    currentPage = page;
    switch (page) {
      case PageNames.home:
        return MaterialPageRoute(builder: (context) => MyHomeScreen(arguments));
      default:
        return null;
    }
  }

  _goPage(String pageName,
      {ScreenArgs? args,
      Function(ScreenArgs args)? actionBack,
      bool makeRootPage = false}) {
    if (!makeRootPage) {
      return navigatorKey.currentState
          ?.pushNamed(pageName, arguments: args)
          .then((value) {
        if (actionBack != null) actionBack(value as ScreenArgs);
      });
    } else {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          pageName, (route) => false,
          arguments: args);
    }
  }

  goBack({ScreenArgs? args, PageNames? specificPage}) {
    if (specificPage != null) {
      navigatorKey.currentState!
          .popAndPushNamed(specificPage.toString(), arguments: args);
    } else {
      Navigator.pop(navigatorKey.currentState!.overlay!.context, args);
    }
  }

  goHome({ScreenArgs? args, Function(ScreenArgs? args)? actionBack}) {
    ScreenManager()._goPage(PageNames.home.toString(),
        args: args, actionBack: actionBack, makeRootPage: true);
  }

  //Popup

  openDefaultErrorAlert(String detail, {Function? onRetry}) async {
    return await InformationAlertPopup(
      context: ScreenManager().navigatorKey.currentContext!,
      backgroundOpacity: 0.8,
      image: Image.asset(
        'images/common/icon_alert.png',
        height: 50,
        width: 50,
      ),
      title: 'Error',
      titleStyle: const TextStyle(
        color: KGray,
        fontWeight: FontWeight.w800,
        fontSize: KFontSize40,
      ),
      subtitle1: detail,
      subtitle1Style: const TextStyle(color: KGray, fontSize: KFontSize35),
      labelButtonAccept: onRetry == null ? 'Aceptar' : 'Reintentar',
      labelButtonCancel: onRetry != null ? 'Cancelar' : null,
      onAccept: onRetry,
      onCancel: () {},
      isCancellable: true,
    ).show();
  }

  void openDefaultErrorAlertPopUp(String detail, {Function? onRetry}) async {
    await InformationAlertPopup(
      context: ScreenManager().navigatorKey.currentContext!,
      backgroundOpacity: 0.8,
      image: Image.asset(
        'images/icon_alert.png',
        height: 50,
        width: 50,
        color: KPrimary,
      ),
      title: 'Error',
      titleStyle: const TextStyle(
        color: KGray,
        fontWeight: FontWeight.w800,
        fontSize: KFontSize40,
      ),
      subtitle1: detail,
      subtitle1Style: const TextStyle(color: KGray, fontSize: KFontSize40),
      labelButtonAccept: onRetry == null ? 'Aceptar' : 'Reintentar',
      labelButtonCancel: onRetry != null ? 'Cancelar' : null,
      onAccept: onRetry,
      onCancel: () {},
      isCancellable: true,
    ).show();
  }

  void openExitAppAlertPopup({Function? onAccept}) async {
    await InformationAlertPopup(
      context: ScreenManager().navigatorKey.currentContext!,
      backgroundOpacity: 0.8,
      image: Image.asset(
        'images/icon_exit.png',
        height: 50,
        width: 50,
        fit: BoxFit.contain,
        color: KPrimary,
      ),
      title: 'ATENCIÓN',
      titleStyle: const TextStyle(
        color: KPrimary,
        fontWeight: FontWeight.w500,
        fontSize: KFontSize40,
      ),
      subtitle1: '¿Estás seguro de querer salir de la aplicación?',
      subtitle1Style: const TextStyle(color: KGray, fontSize: KFontSize35),
      labelButtonAccept: "Salir",
      labelButtonCancel: "Cancelar",
      onAccept: onAccept,
      onCancel: () {},
      isCancellable: true,
      hasExitButton: false,
    ).show();
  }

  /*openAddInvestmentPopup(
      UserModel selectedUser, TextEditingController controller,
      {Function? onAccept}) async {
    List<DateTime?> selectedDate = [DateTime.now()];
    List<DateTime?> selectedEndingDate = [DateTime.now()];
    await FormPopup(
      context: ScreenManager().navigatorKey.currentContext!,
      backgroundOpacity: 0.8,
      /* image: Image.asset(
        'images/icon_exit.png',
        height: 50,
        width: 50,
        fit: BoxFit.contain,
        color: KPrimary,
      ), */
      title: 'NUEVA INVERSIÓN',
      titleStyle: const TextStyle(
        color: KPrimary,
        fontWeight: FontWeight.w500,
        fontSize: KFontSize40,
      ),
      labelButtonAccept: "Aceptar",
      labelButtonCancel: "Cancelar",
      onAccept: onAccept,
      onCancel: () {
        selectedDate.clear();
        selectedEndingDate.clear();
      },
      isCancellable: true,
      hasExitButton: false,
      content: Material(
        color: KBackgroundBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(ScreenManager().navigatorKey.currentContext!)
                      .size
                      .width /
                  4,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: KPrimary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: ItemDataFormComponent.number(
                controller: controller,
                placeholder: "Monto de la nueva inversión",
                height: 30,
                innerPadding: const EdgeInsets.all(5),
                inputTextAlign: TextAlign.center,
                backgroundColor: KBackgroundBlue,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                textStyle: const TextStyle(
                  color: KWhite,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 375,
                  width: 375,
                  child: Column(
                    children: [
                      const Text(
                        "Fecha de la inversión",
                        style: TextStyle(
                          color: KWhite,
                          fontSize: KFontSize40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          currentDate: selectedDate[0],
                          weekdayLabelTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          controlsTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          dayTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          yearTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          nextMonthIcon: const Icon(
                            Icons.keyboard_arrow_right,
                            color: KWhite,
                          ),
                          lastMonthIcon: const Icon(
                            Icons.keyboard_arrow_left,
                            color: KWhite,
                          ),
                        ),
                        value: selectedDate,
                        onValueChanged: (dates) => selectedDate = dates,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  height: 375,
                  width: 375,
                  child: Column(
                    children: [
                      const Text(
                        "Vencimiento del plazo",
                        style: TextStyle(
                          color: KWhite,
                          fontSize: KFontSize40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          currentDate: selectedEndingDate[0],
                          weekdayLabelTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          controlsTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          dayTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          yearTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          nextMonthIcon: const Icon(
                            Icons.keyboard_arrow_right,
                            color: KWhite,
                          ),
                          lastMonthIcon: const Icon(
                            Icons.keyboard_arrow_left,
                            color: KWhite,
                          ),
                        ),
                        value: selectedEndingDate,
                        onValueChanged: (dates) => selectedEndingDate = dates,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).show();

    return selectedDate.isNotEmpty && selectedEndingDate.isNotEmpty
        ? [selectedDate[0], selectedEndingDate[0]]
        : <DateTime>[];
  }*/

  /*openUpgradeProfitsPopUp(
    TextEditingController upgradeController,
    TextEditingController percentageController,
    List<UserModel> selectedUsers, {
    Function? onToggleFunction,
  }) async {
    bool acceptPressed = false;
    await FormPopup(
      context: ScreenManager().navigatorKey.currentContext!,
      title: 'ACTUALIZAR GANANCIAS',
      titleStyle: const TextStyle(
        color: KPrimary,
        fontWeight: FontWeight.w500,
        fontSize: KFontSize40,
      ),
      labelButtonAccept: 'Aceptar',
      labelButtonCancel: 'Cancelar',
      onAccept: () {
        acceptPressed = true;
      },
      onCancel: () {
        upgradeController.clear();
        percentageController.clear();
      },
      content: Material(
        color: KBackgroundBlue,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (selectedUsers.length == 1) ...[
                  Container(
                    width: MediaQuery.of(
                                ScreenManager().navigatorKey.currentContext!)
                            .size
                            .width /
                        4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: KPrimary,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ItemDataFormComponent.number(
                      controller: upgradeController,
                      placeholder: "Nueva Ganancia",
                      height: 30,
                      innerPadding: const EdgeInsets.all(5),
                      inputTextAlign: TextAlign.center,
                      backgroundColor: KBackgroundBlue,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      textStyle: const TextStyle(
                        color: KWhite,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "ó",
                    style: TextStyle(
                      color: KWhite,
                      fontSize: KFontSize40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
                Container(
                  width:
                      MediaQuery.of(ScreenManager().navigatorKey.currentContext!)
                              .size
                              .width /
                          20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: KPrimary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ItemDataFormComponent.number(
                    controller: percentageController,
                    placeholder: "100",
                    height: 30,
                    innerPadding: const EdgeInsets.all(5),
                    inputTextAlign: TextAlign.center,
                    backgroundColor: KBackgroundBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    textStyle: const TextStyle(
                      color: KWhite,
                    ),
                  ),
                ),
                const Icon(
                  Icons.percent,
                  color: KPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    ).show();

    return acceptPressed;
  }*/

  /*openAddInvestorPopUp(
    TextEditingController dniUserController,
    TextEditingController userNameController,
    TextEditingController userLastNameController,
    TextEditingController depositValueController, {
    Function? onAccept,
  }) async {
    List<DateTime?> selectedDate = [DateTime.now()];
    List<DateTime?> selectedEndingDate = [DateTime.now()];
    await FormPopup(
      context: ScreenManager().navigatorKey.currentContext!,
      title: "Añadir Inversor",
      titleStyle: const TextStyle(
        color: KPrimary,
        fontWeight: FontWeight.w500,
        fontSize: KFontSize40,
      ),
      labelButtonCancel: "Cancelar",
      labelButtonAccept: "Añadir",
      onAccept: onAccept,
      content: Material(
        color: KBackgroundBlue,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:
                      MediaQuery.of(ScreenManager().navigatorKey.currentContext!)
                              .size
                              .width /
                          4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: KPrimary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ItemDataFormComponent.number(
                    controller: depositValueController,
                    placeholder: "Valor de inversión",
                    height: 30,
                    innerPadding: const EdgeInsets.all(5),
                    inputTextAlign: TextAlign.center,
                    backgroundColor: KBackgroundBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    textStyle: const TextStyle(
                      color: KWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width:
                      MediaQuery.of(ScreenManager().navigatorKey.currentContext!)
                              .size
                              .width /
                          4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: KPrimary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ItemDataFormComponent.number(
                    controller: dniUserController,
                    placeholder: "N° de DNI",
                    height: 30,
                    innerPadding: const EdgeInsets.all(5),
                    inputTextAlign: TextAlign.center,
                    backgroundColor: KBackgroundBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    textStyle: const TextStyle(
                      color: KWhite,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:
                      MediaQuery.of(ScreenManager().navigatorKey.currentContext!)
                              .size
                              .width /
                          4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: KPrimary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ItemDataFormComponent.text(
                    controller: userNameController,
                    placeHolder: "Nombre",
                    height: 30,
                    innerPadding: const EdgeInsets.all(5),
                    inputTextAlign: TextAlign.center,
                    backgroundColor: KBackgroundBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    textStyle: const TextStyle(
                      color: KWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width:
                      MediaQuery.of(ScreenManager().navigatorKey.currentContext!)
                              .size
                              .width /
                          4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: KPrimary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ItemDataFormComponent.text(
                    controller: userLastNameController,
                    placeHolder: "Apellido",
                    height: 30,
                    innerPadding: const EdgeInsets.all(5),
                    inputTextAlign: TextAlign.center,
                    backgroundColor: KBackgroundBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    textStyle: const TextStyle(
                      color: KWhite,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 375,
                  width: 375,
                  child: Column(
                    children: [
                      const Text(
                        "Fecha de la inversión",
                        style: TextStyle(
                          color: KWhite,
                          fontSize: KFontSize40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          currentDate: selectedDate[0],
                          weekdayLabelTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          controlsTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          dayTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          yearTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          nextMonthIcon: const Icon(
                            Icons.keyboard_arrow_right,
                            color: KWhite,
                          ),
                          lastMonthIcon: const Icon(
                            Icons.keyboard_arrow_left,
                            color: KWhite,
                          ),
                        ),
                        value: selectedDate,
                        onValueChanged: (dates) => selectedDate = dates,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  height: 375,
                  width: 375,
                  child: Column(
                    children: [
                      const Text(
                        "Vencimiento del plazo",
                        style: TextStyle(
                          color: KWhite,
                          fontSize: KFontSize40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          currentDate: selectedEndingDate[0],
                          weekdayLabelTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          controlsTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          dayTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          yearTextStyle: const TextStyle(
                            color: KWhite,
                          ),
                          nextMonthIcon: const Icon(
                            Icons.keyboard_arrow_right,
                            color: KWhite,
                          ),
                          lastMonthIcon: const Icon(
                            Icons.keyboard_arrow_left,
                            color: KWhite,
                          ),
                        ),
                        value: selectedEndingDate,
                        onValueChanged: (dates) => selectedEndingDate = dates,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).show();

    return selectedDate.isNotEmpty && selectedEndingDate.isNotEmpty
        ? [selectedDate[0], selectedEndingDate[0]]
        : <DateTime>[];
  }*/

  /*openChoicePopUp(
    UserModel? selectedUser, {
    Function? onAccept,
    double? newInvestment,
    double? newProfit,
  }) async {
    await FormPopup(
      context: ScreenManager().navigatorKey.currentContext!,
      title: 'LOS DATOS SERÁN GUARDADOS DE LA SIGUIENTE MANERA: ',
      titleStyle: const TextStyle(
        color: KWhite,
        fontWeight: FontWeight.w500,
        fontSize: KFontSize45,
      ),
      labelButtonAccept: 'Confirmar',
      labelButtonCancel: 'Cancelar',
      content: Material(
        color: KBackgroundBlue,
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'INVIRTIENDO: ',
                    style: TextStyle(
                      color: KWhite,
                      fontSize: KFontSize40,
                    ),
                  ),
                  TextSpan(
                    text: _getTotalInvestment(
                        selectedUser, newInvestment, newProfit),
                    style: const TextStyle(
                      color: KPrimary,
                      fontSize: KFontSize40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'GANANCIAS: ',
                    style: TextStyle(
                      color: KWhite,
                      fontSize: KFontSize40,
                    ),
                  ),
                  TextSpan(
                    text: newProfit != null
                        ? newProfit.toString()
                        : _getTotalProfit(selectedUser),
                    style: const TextStyle(
                      color: KPrimary,
                      fontSize: KFontSize40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '¿CONFIRMAR CAMBIOS? ',
              style: TextStyle(
                color: KWhite,
                fontSize: KFontSize45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      onAccept: onAccept,
    ).show();
  }*/

  /*_getTotalInvestment(
      UserModel? selectedUser, double? newInvestment, double? newProfit) {
    double aux = 0;
    DateTime now = DateTime.now();

    if (daysBetween(selectedUser?.currentInvestment?.expirationDate, now) < 0) {
      aux += selectedUser?.currentInvestment?.amount ?? 0;
      aux += selectedUser?.currentInvestment?.profit ?? 0;
    }
    aux += newInvestment ?? 0;
    aux += newProfit ?? 0;

    if (selectedUser!.previousInvestments != null) {
      for (InvestmentModel? invest in selectedUser.previousInvestments!) {
        if (daysBetween(invest?.expirationDate, now) < 0) {
          aux += invest?.amount ?? 0;
          aux += invest?.profit ?? 0;
        }
      }
    }

    return aux.toStringAsFixed(2);
  }*/

  /*_getTotalProfit(UserModel? selectedUser) {
    double aux = 0;
    DateTime now = DateTime.now();

    if (daysBetween(selectedUser?.currentInvestment?.expirationDate, now) < 0) {
      aux += selectedUser?.currentInvestment?.profit ?? 0;
    }

    if (selectedUser!.previousInvestments != null) {
      for (InvestmentModel? invest in selectedUser.previousInvestments!) {
        aux += invest?.profit ?? 0;
      }
    }

    return aux.toStringAsFixed(2);
  }*/
}
