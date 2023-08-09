import 'package:flutter/material.dart';
import 'package:my_evento/src/managers/screen_manager.dart';
import 'package:my_evento/src/utils/extensions.dart';

import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';

class FormPopup {
  final BuildContext context;
  final Image? image;
  final double backgroundOpacity;
  final String title;
  final TextStyle? titleStyle;
  final Widget? content;
  final String? footerText;
  final TextStyle? footerTextStyle;
  final String labelButtonAccept;
  final Function? onAccept;
  final String? labelButtonCancel;
  final Function? onCancel;
  final bool isCancellable;
  bool? hasExitButton;

  FormPopup({
    required this.context,
    this.image,
    this.backgroundOpacity = 0.8,
    required this.title,
    this.titleStyle,
    this.content,
    this.footerText,
    this.footerTextStyle,
    required this.labelButtonAccept,
    this.onAccept,
    this.labelButtonCancel,
    this.onCancel,
    this.isCancellable = false,
    this.hasExitButton,
  });

  final double radius = 10;

  Future show() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return _dialog();
        });
  }

  _dialog() {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(30),
          color: Colors.transparent,
        ),
        Center(
          child: Container(
            child: _body(),
            width: MediaQuery.of(ScreenManager().navigatorKey.currentContext!)
                    .size
                    .width /
                1.5,
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: KFontColor,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ],
    );
  }

  _body() {
    return Stack(
      children: [
        _content(),
        hasExitButton == null || hasExitButton! == true
            ? _buttonExit()
            : const SizedBox.shrink(),
      ],
    );
  }

  _content() {
    return SingleChildScrollView(
        child: Container(
      key: const Key('FormPopupContent'),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start, children: _getChildren()),
    ));
  }

  _getChildren() {
    List<Widget> children = [];
    if (image != null) {
      children.addAll(
          [const SizedBox(height: 10), _image(), const SizedBox(height: 20)]);
    }

    if (title.hasValue()) {
      children.addAll([_title(), const SizedBox(height: 15)]);
    }

    if (content != null) {
      children.addAll([content!, const SizedBox(height: 15)]);
    }

    if (footerText != null) {
      children.addAll([
        const SizedBox(height: 10),
        _footerText(),
        const SizedBox(height: 15)
      ]);
    }

    children.addAll([const SizedBox(height: 15), _buttons()]);
    return children;
  }

  _image() {
    return image;
  }

  _title() {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        title.hasValue() ? title : "",
        softWrap: true,
        textAlign: TextAlign.center,
        style: titleStyle ??
            const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: KFontSize45,
            ),
      ),
    );
  }

  _footerText() {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        footerText ?? "",
        textAlign: TextAlign.center,
        softWrap: true,
        style: footerTextStyle ??
            const TextStyle(
              color: KBlack,
              fontWeight: FontWeight.w400,
              fontSize: KFontSize35,
            ),
      ),
    );
  }

  _buttons() {
    return Row(
      children: [
        _buttonCancel(),
        const SizedBox(width: 15),
        /*
          Visibility(
            visible: labelButtonCancel != null,
            child: SizedBox(
              width: 15,
            ),
          ),*/
        _buttonAccept(),
      ],
    );
  }

  _buttonExit() {
    return Visibility(
      visible: isCancellable,
      child: Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: GestureDetector(
              key: const Key('FormPopupExitButton'),
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Image.asset(
                "images/icon_close.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
                color: KPrimary,
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonAccept() {
    return Flexible(
      child: Padding(
        padding: labelButtonCancel != null
            ? const EdgeInsets.only(right: 20)
            : const EdgeInsets.only(left: 50, right: 50),
        child: TextButton(
          key: const Key('FormPopupAcceptButton'),
          onPressed: () {
            Navigator.pop(context, true);
            if (onAccept != null) {
              onAccept!();
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: KPrimary,
            textStyle: const TextStyle(fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 40,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  labelButtonAccept.hasValue() ? labelButtonAccept : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: KFontSize35,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonCancel() {
    return Visibility(
      visible: labelButtonCancel != null,
      child: Flexible(
        child: TextButton(
          key: const Key('FormPopupCancelButton'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.pop(context, false);

            if (onCancel != null) {
              onCancel!();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 40,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  labelButtonCancel ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: KPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: KFontSize35,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
