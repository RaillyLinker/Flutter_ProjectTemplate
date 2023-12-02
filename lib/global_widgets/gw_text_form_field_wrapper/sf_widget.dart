// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'sf_widget_state.dart' as sf_widget_state;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo(
      {this.autofocus = false,
      this.obscureText = false,
      this.labelText,
      this.labelStyle,
      this.floatingLabelStyle,
      this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.focusedBorder,
      this.onChanged,
      this.inputValidator,
      this.onEditingComplete});

  // 페이지 진입시 입력창 포커스 여부
  final bool autofocus;

  // 입력값을 * 로 숨기기
  final bool obscureText;

  // 초기 라벨
  final String? labelText;

  // 초기 라벨 스타일
  final TextStyle? labelStyle;

  // 초기 라벨 스타일
  final TextStyle? floatingLabelStyle;

  // 초기 힌트
  final String? hintText;

  // 초기 힌트 스타일
  final TextStyle? hintStyle;

  // 입력창 suffix 아이콘
  final Widget? suffixIcon;

  final InputBorder? focusedBorder;

  // 입력값 수정시 콜백
  final void Function(String inputValue)? onChanged;

  // 입력값 검증 콜백(inputValue 를 받아서 검증 후 에러가 있다면 에러 메세지를 반환하고, 없다면 null 반환)
  final String? Function(String inputValue)? inputValidator;

  // 입력 완료 후 엔터를 눌렀을 시 콜백
  final void Function()? onEditingComplete;
}

class SfWidget extends StatefulWidget {
  const SfWidget({required this.globalKey, required this.inputVo})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  sf_widget_state.SfWidgetState createState() =>
      sf_widget_state.SfWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<sf_widget_state.SfWidgetState> globalKey;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required sf_widget_state.SfWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return TextFormField(
        controller: currentState.textFieldController,
        focusNode: currentState.textFieldFocus,
        autofocus: inputVo.autofocus,
        obscureText: currentState.obscureText,
        decoration: InputDecoration(
            errorText: currentState.textFieldErrorMsg,
            labelText: currentState.labelText,
            labelStyle: currentState.labelStyle,
            floatingLabelStyle: currentState.floatingLabelStyle,
            hintText: currentState.hintText,
            hintStyle: currentState.hintStyle,
            suffixIcon: currentState.suffixIcon,
            focusedBorder: currentState.focusedBorder),
        onChanged: (value) {
          // 입력값 변경시 에러 메세지 삭제
          if (currentState.textFieldErrorMsg != null) {
            currentState.textFieldErrorMsg = null;
            currentState.refreshUi();
          }

          // 콜백 실행
          if (currentState.onChanged != null) {
            currentState.onChanged!(value);
          }
        },
        onEditingComplete: () {
          // 입력창에서 엔터를 눌렀을 때

          // 콜백 실행
          if (currentState.onEditingComplete != null) {
            currentState.onEditingComplete!();
          }
        });
  }
}
