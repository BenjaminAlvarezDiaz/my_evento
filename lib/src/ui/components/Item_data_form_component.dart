import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_evento/src/utils/extensions.dart';

import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';
import 'checkbox_component.dart';

enum ItemDataFormType { text, number, checkBoxLabel }

enum CheckBoxLabelType {
  left,
  right,
}

typedef ValidateFunction = String? Function(String value);

// ignore: must_be_immutable
class ItemDataFormComponent extends StatefulWidget {
  //COMMONS
  late ItemDataFormType type;
  bool isValid;
  String label;
  String? errorMessage;
  late Color backgroundColor;
  bool hasDividerLine;
  String? placeHolder;
  List<BoxShadow>? boxShadow;
  TextStyle? placeholderStyle;
  bool showErrorPlaceHolder;
  String errorPlaceHolder;

  //TEXT
  TextEditingController? controller;
  Function(String)? onTextChange;
  TextInputType textInputType = TextInputType.text;
  TextInputAction? textInputAction;
  Function()? onPress;
  Color errorBorderColor = Colors.transparent;
  Color borderColor = Colors.transparent;
  TextStyle? errorTextStyle;
  BorderRadius? borderRadius;
  EdgeInsets? innerPadding;
  double? height;
  Alignment? alignment;
  BoxBorder? errorBorder;
  Widget? leftIcon;
  Widget? rightIcon;
  TextAlign? inputTextAlign;
  bool isPassword = false;
  bool isRequired = false;
  bool isEnabled = true;
  ValidateFunction? validate;
  int? maxLength;
  TextInputType? keyboardType;
  VoidCallback? onEditComplete;
  EdgeInsets? scrollPadding;
  bool isPasswordEnabled = true;
  TextStyle? textStyle;
  String passwordEnablerText = "Mostrar";
  FocusNode? focusNode;
  String? placeholder;
  List<TextInputFormatter> inputFormatters = [];
  int? maxLines;
  int? minLines;

  //IMAGEID
  String? labelImage1;
  String? labelImage2;
  String? imageUrl1;
  String? imageUrl2;
  String? imagePath1;
  String? imagePath2;
  Function()? onImage1Tap;
  Function()? onImage2Tap;
  Function()? onIconTrashTap1;
  Function()? onIconTrashTap2;

  //CHECKBOX
  late bool autoCheckOnClick;
  String? checkBoxLabel;
  Widget? checkBoxWidget;
  CheckBoxLabelType? checkBoxType;
  late bool isSelected;
  String? iconLeftPath;
  Function(bool isCheck)? onTap;

  ItemDataFormComponent.text({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.errorBorderColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.controller,
    this.placeHolder,
    this.backgroundColor = Colors.white,
    this.hasDividerLine = false,
    this.boxShadow,
    this.placeholderStyle,
    this.innerPadding,
    this.borderRadius,
    this.height,
    this.alignment,
    this.errorBorder,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.isEnabled = true,
    this.validate,
    this.maxLength,
    this.keyboardType,
    this.onEditComplete,
    this.scrollPadding,
    this.textInputAction = TextInputAction.done,
    this.errorMessage = "",
    this.onTextChange,
    this.textStyle,
    this.onPress,
    this.inputFormatters = const [],
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key) {
    type = ItemDataFormType.text;
  }

  ItemDataFormComponent.number({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.errorMessage,
    this.errorBorderColor = Colors.transparent,
    this.onTextChange,
    required this.controller,
    this.placeholder,
    this.backgroundColor = Colors.white,
    this.hasDividerLine = false,
    this.boxShadow,
    this.placeholderStyle,
    this.innerPadding,
    this.borderRadius,
    this.textStyle,
    this.height,
    this.alignment,
    this.errorBorder,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.validate,
    this.maxLength,
    this.onEditComplete,
    this.focusNode,
    this.textInputAction,
    this.onPress,
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
  }) : super(key: key) {
    type = ItemDataFormType.number;
  }

  ItemDataFormComponent.checkBoxLabel({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.autoCheckOnClick = true,
    this.checkBoxType,
    this.checkBoxLabel,
    this.checkBoxWidget,
    this.isSelected = false,
    this.iconLeftPath = '',
    this.onTap,
    this.errorMessage,
    this.hasDividerLine = false,
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
  }) : super(key: key) {
    type = ItemDataFormType.checkBoxLabel;
  }

  @override
  _ItemDataFormComponentState createState() => _ItemDataFormComponentState();
}

class _ItemDataFormComponentState extends State<ItemDataFormComponent> {
  bool isValid = true;
  String textError = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !widget.label.isNullOrEmpty(),
          child: const SizedBox(
            height: 15,
          ),
        ),
        _label(),
        const SizedBox(
          height: 5,
        ),
        _content(),
        Visibility(
          visible: !widget.isValid && widget.showErrorPlaceHolder,
          child: Text(
            widget.errorPlaceHolder.isEmpty
                ? "Este campo es requerido"
                : widget.errorPlaceHolder,
            textAlign: TextAlign.start,
            style: const TextStyle(color: KRed, fontSize: KFontSize35),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  _label() {
    return Visibility(
      visible: !widget.label.isNullOrEmpty(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.label,
          softWrap: true,
          style: TextStyle(
              color: widget.isValid ? KGray : KPrimary,
              fontWeight: widget.isValid ? FontWeight.normal : FontWeight.bold,
              fontSize: KFontSize35),
        ),
      ),
    );
  }

  _content() {
    switch (widget.type) {
      case ItemDataFormType.text:
        return _text();
      case ItemDataFormType.number:
        return _number();
      case ItemDataFormType.checkBoxLabel:
        return _checkBoxLabel();
      default:
        return _text();
    }
  }

  _text() {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
          border: Border.all(
              color: widget.isValid
                  ? widget.borderColor
                  : widget.errorBorderColor)),
      height: widget.height,
      alignment: widget.alignment,
      child: Padding(
        padding: widget.innerPadding ?? EdgeInsets.zero,
        child: Row(
          children: [
            widget.leftIcon ?? const SizedBox.shrink(),
            Expanded(
              child: TextField(
                onTap: widget.onPress,
                enabled: widget.isEnabled,
                keyboardType: widget.keyboardType,
                onEditingComplete: widget.onEditComplete,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength),
                  ...widget.inputFormatters
                ],
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                textInputAction: widget.textInputAction,
                scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(0),
                //validator: (value) => validate(value),
                controller: widget.controller,
                cursorColor: Colors.grey,
                obscureText: widget.isPasswordEnabled && widget.isPassword,
                obscuringCharacter: "*",
                onChanged: (value) {
                  setState(() {});
                  if (widget.onTextChange != null) {
                    widget.onTextChange!(value);
                  }
                },
                style: widget.isValid
                    ? widget.textStyle ??
                        const TextStyle(color: KGray, fontSize: KFontSize35)
                    : widget.errorTextStyle ??
                        const TextStyle(color: KPrimary, fontSize: KFontSize35),
                textAlign: widget.inputTextAlign ?? TextAlign.start,
                decoration: InputDecoration(
                  contentPadding: widget.hasDividerLine
                      ? const EdgeInsets.only(bottom: 13)
                      : null,
                  border: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid ? KGray : KPrimary,
                          ),
                        )
                      : InputBorder.none,
                  focusedBorder: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid ? KGray : KPrimary,
                          ),
                        )
                      : InputBorder.none,
                  hintText:
                      widget.placeHolder!.hasValue() ? widget.placeHolder : '',
                  hintStyle: widget.placeholderStyle ??
                      const TextStyle(color: KGray_L1, fontSize: KFontSize35),
                  isCollapsed: true,
                ),
              ),
            ),
            widget.rightIcon ?? const SizedBox.shrink(),
            Visibility(
              visible: widget.isPassword &&
                  (widget.controller != null
                      ? widget.controller!.text.isNotEmpty
                      : false),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.isPasswordEnabled = !widget.isPasswordEnabled;
                    widget.isPasswordEnabled
                        //i18n
                        ? widget.passwordEnablerText = 'Mostrar'
                        : widget.passwordEnablerText = 'Ocultar';
                  });
                },
                child: _getPasswordEnabler(widget.passwordEnablerText),
              ),
            )
          ],
        ),
      ),
    );
  }

  validate(String? value) {
    setState(() {
      String? validatorData =
          widget.validate != null ? widget.validate!(value!) : null;
      textError = validatorData ?? "";
      isValid = (widget.validate == null ||
              validatorData == null ||
              validatorData.isEmpty) &&
          (!widget.isRequired || (widget.isRequired && value!.isNotEmpty));
    });
  }

  _getPasswordEnabler(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: KFontSize35,
            fontWeight: FontWeight.normal,
            color: KPrimary),
      ),
    );
  }

  _number() {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
          border: Border.all(
              color: widget.isValid
                  ? widget.borderColor
                  : widget.errorBorderColor)),
      height: widget.height,
      alignment: widget.alignment,
      child: Padding(
        padding: widget.innerPadding ?? EdgeInsets.zero,
        child: Row(
          children: [
            widget.leftIcon ?? const SizedBox.shrink(),
            Expanded(
              child: TextFormField(
                onTap: widget.onPress,
                onChanged: (value) {
                  if (widget.onTextChange != null) {
                    widget.onTextChange!(value);
                  }
                },
                onEditingComplete: widget.onEditComplete,
                focusNode: widget.focusNode,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: (value) => validate(value),
                controller: widget.controller,
                cursorColor: Colors.grey,
                style: widget.isValid
                    ? widget.textStyle ??
                        const TextStyle(color: KGray, fontSize: KFontSize35)
                    : widget.errorTextStyle ??
                        const TextStyle(color: KPrimary, fontSize: KFontSize35),
                textAlign: widget.inputTextAlign ?? TextAlign.start,
                decoration: InputDecoration(
                  contentPadding: widget.hasDividerLine
                      ? const EdgeInsets.only(bottom: 13)
                      : null,
                  hintText:
                      widget.placeholder!.hasValue() ? widget.placeholder : '',
                  hintStyle: widget.placeholderStyle ??
                      const TextStyle(color: KGray_L1, fontSize: KFontSize35),
                  border: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid ? KGray : KPrimary,
                          ),
                        )
                      : InputBorder.none,
                  focusedBorder: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid ? KGray : KPrimary,
                          ),
                        )
                      : InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
            widget.rightIcon ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  _checkBoxLabel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: !widget.iconLeftPath!.isNullOrEmpty(),
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                height: 27,
                width: 27,
                child: Image.asset(
                  widget.iconLeftPath!,
                  color: KGray,
                ),
              ),
            ),
            Expanded(
              child: CheckboxComponent(
                height: 29,
                width: 29,
                autoCheckOnClick: widget.autoCheckOnClick,
                isLabelOnTheLeft: widget.checkBoxType == CheckBoxLabelType.left,
                mainAxisAlignment: widget.checkBoxType == CheckBoxLabelType.left
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                icon: const ImageIcon(
                  AssetImage("images/icon_checkbox.png"),
                  color: Colors.white,
                ),
                onTap: widget.onTap,
                label: Flexible(
                  child: (widget.checkBoxLabel != null &&
                          widget.checkBoxLabel!.isNotEmpty)
                      ? Text(
                          widget.checkBoxLabel!,
                          style: const TextStyle(
                            color: KGray,
                            fontWeight: FontWeight.normal,
                            fontSize: KFontSize35,
                          ),
                        )
                      : widget.checkBoxWidget!,
                ),
                isSelected: widget.isSelected,
              ),
            ),
          ],
        ),
        Visibility(
            visible: !widget.isValid,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                widget.errorMessage ?? '',
                style: const TextStyle(color: KPrimary, fontSize: 13),
              ),
            )),
        Visibility(
            visible: !widget.isValid,
            child: const Divider(
              color: KPrimary,
              thickness: 2,
            ))
      ],
    );
  }
}
