// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// (inner Folder)
import 'sf_widget.dart' as sf_widget;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class SfWidgetState extends State<sf_widget.SfWidget> {
  SfWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
    obscureText = widget.inputVo.obscureText;
    labelText = widget.inputVo.labelText;
    labelStyle = widget.inputVo.labelStyle;
    floatingLabelStyle = widget.inputVo.floatingLabelStyle;
    hintText = widget.inputVo.hintText;
    hintStyle = widget.inputVo.hintStyle;
    suffixIcon = widget.inputVo.suffixIcon;
    onChanged = widget.inputVo.onChanged;
    inputValidator = widget.inputVo.inputValidator;
    focusedBorder = widget.inputVo.focusedBorder;
    onEditingComplete = widget.inputVo.onEditingComplete;
    keyboardType = widget.inputVo.keyboardType;
    contentPadding = widget.inputVo.contentPadding;
    filled = widget.inputVo.filled;
    fillColor = widget.inputVo.fillColor;
    isDense = widget.inputVo.isDense;
    border = widget.inputVo.border;
    maxLength = widget.inputVo.maxLength;
    inputFormatters = widget.inputVo.inputFormatters;
    prefixIcon = widget.inputVo.prefixIcon;
    autofillHints = widget.inputVo.autofillHints;
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    textFieldController.dispose();
    textFieldFocus.dispose();

    super.dispose();
  }

  // [public 변수]
  final TextEditingController textFieldController = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();

  // 입력값을 * 로 숨기기
  late bool obscureText;

  // 입력창 에러 메세지
  String? textFieldErrorMsg;

  // 입력창 라벨
  late String? labelText;

  // 입력창 라벨 스타일
  late TextStyle? labelStyle;

  // 입력창 라벨 스타일
  late TextStyle? floatingLabelStyle;

  // 입력창 힌트
  late String? hintText;

  // 입력창 힌트 스타일
  late TextStyle? hintStyle;

  // 입력창 suffix 아이콘
  late Widget? suffixIcon;

  // 입력값 수정시 콜백
  void Function(String inputValue)? onChanged;

  // 입력값 검증 콜백(inputValue 를 받아서 검증 후 에러가 있다면 에러 메세지를 반환하고, 없다면 null 반환)
  String? Function(String inputValue)? inputValidator;

  // 입력 완료 후 엔터를 눌렀을 시 콜백
  void Function()? onEditingComplete;

  late InputBorder? focusedBorder;

  late TextInputType? keyboardType;

  late EdgeInsetsGeometry? contentPadding;

  late bool? filled;

  late Color? fillColor;

  late bool? isDense;

  late InputBorder? border;

  late int? maxLength;

  late List<TextInputFormatter>? inputFormatters;

  late Widget? prefixIcon;

  late Iterable<String>? autofillHints;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (inputValidator 에 따른 입력창 검증 - 반환값이 null 이 아니라면 에러가 존재하는 상태로, 에러가 표시되고 포커싱)
  String? validate() {
    if (inputValidator == null) {
      return null;
    } else {
      String inputValue = textFieldController.text;
      String? errorTxt = inputValidator!(inputValue);
      textFieldErrorMsg = errorTxt;
      refreshUi();
      requestFocus();
      return errorTxt;
    }
  }

  // (입력값 반환)
  String getInputValue() {
    return textFieldController.text;
  }

  // (입력창 포커싱)
  void requestFocus() {
    FocusScope.of(context).requestFocus(textFieldFocus);
  }

  // (현재 포커스가 있는지 여부)
  bool hasFocus() {
    return textFieldFocus.hasFocus;
  }

  // (값 입력)
  void setInputValue(String inputValue) {
    textFieldController.text = inputValue;
    textFieldErrorMsg = null;
    refreshUi();
  }
}
