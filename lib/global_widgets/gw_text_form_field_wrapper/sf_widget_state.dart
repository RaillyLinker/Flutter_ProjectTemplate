// (external)
import 'package:flutter/cupertino.dart';

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
    hintText = widget.inputVo.hintText;
    hintStyle = widget.inputVo.hintStyle;
    suffixIcon = widget.inputVo.suffixIcon;
    onChanged = widget.inputVo.onChanged;
    onFieldSubmitted = widget.inputVo.onFieldSubmitted;
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

  // 입력창 힌트
  late String? hintText;

  // 입력창 힌트 스타일
  late TextStyle? hintStyle;

  // 입력창 suffix 아이콘
  late Widget? suffixIcon;

  void Function(String value)? onChanged;

  void Function(String value)? onFieldSubmitted;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}
