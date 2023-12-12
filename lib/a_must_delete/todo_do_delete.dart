import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';

// todo : refreshWrapper 적용 후 파일 삭제
// (TextFormField)
class SfwTextFormField extends StatefulWidget {
  const SfwTextFormField(
      {required this.globalKey,
      this.autofocus = false,
      this.obscureText = false,
      this.labelText,
      this.labelStyle,
      this.floatingLabelStyle,
      this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.keyboardType,
      this.focusedBorder,
      this.onChanged,
      this.inputValidator,
      this.onEditingComplete,
      this.contentPadding,
      this.filled,
      this.fillColor,
      this.isDense,
      this.border,
      this.maxLength,
      this.inputFormatters,
      this.prefixIcon,
      this.autofillHints})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwTextFormFieldState createState() => SfwTextFormFieldState();

  // [public 변수]
  final GlobalKey<SfwTextFormFieldState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!

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

  final TextInputType? keyboardType;

  // 입력값 수정시 콜백
  final void Function(String inputValue)? onChanged;

  // 입력값 검증 콜백(inputValue 를 받아서 검증 후 에러가 있다면 에러 메세지를 반환하고, 없다면 null 반환)
  final String? Function(String inputValue)? inputValidator;

  // 입력 완료 후 엔터를 눌렀을 시 콜백
  final void Function()? onEditingComplete;

  final EdgeInsetsGeometry? contentPadding;

  final bool? filled;

  final Color? fillColor;

  final bool? isDense;

  final InputBorder? border;

  final int? maxLength;

  final List<TextInputFormatter>? inputFormatters;

  final Widget? prefixIcon;

  final Iterable<String>? autofillHints;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required SfwTextFormFieldState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return TextFormField(
        keyboardType: currentState.keyboardType,
        controller: currentState.textFieldController,
        focusNode: currentState.textFieldFocus,
        autofocus: autofocus,
        obscureText: currentState.obscureText,
        maxLength: currentState.maxLength,
        inputFormatters: currentState.inputFormatters,
        decoration: InputDecoration(
            prefixIcon: currentState.prefixIcon,
            filled: currentState.filled,
            fillColor: currentState.fillColor,
            isDense: currentState.isDense,
            border: currentState.border,
            contentPadding: currentState.contentPadding,
            errorText: currentState.textFieldErrorMsg,
            labelText: currentState.labelText,
            labelStyle: currentState.labelStyle,
            floatingLabelStyle: currentState.floatingLabelStyle,
            hintText: currentState.hintText,
            hintStyle: currentState.hintStyle,
            suffixIcon: currentState.suffixIcon,
            focusedBorder: currentState.focusedBorder),
        autofillHints: currentState.autofillHints,
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

class SfwTextFormFieldState extends State<SfwTextFormField> {
  SfwTextFormFieldState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
    obscureText = widget.obscureText;
    labelText = widget.labelText;
    labelStyle = widget.labelStyle;
    floatingLabelStyle = widget.floatingLabelStyle;
    hintText = widget.hintText;
    hintStyle = widget.hintStyle;
    suffixIcon = widget.suffixIcon;
    onChanged = widget.onChanged;
    inputValidator = widget.inputValidator;
    focusedBorder = widget.focusedBorder;
    onEditingComplete = widget.onEditingComplete;
    keyboardType = widget.keyboardType;
    contentPadding = widget.contentPadding;
    filled = widget.filled;
    fillColor = widget.fillColor;
    isDense = widget.isDense;
    border = widget.border;
    maxLength = widget.maxLength;
    inputFormatters = widget.inputFormatters;
    prefixIcon = widget.prefixIcon;
    autofillHints = widget.autofillHints;
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

  // (입력창 포커싱)
  void requestFocus() {
    FocusScope.of(context).requestFocus(textFieldFocus);
  }
}

// (오로지 리플래시만을 위한 BLoC 클래스)
class RefreshableBloc extends Bloc<bool, bool> {
  RefreshableBloc() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  void refreshUi() {
    add(!state);
  }
}

// (페이지 정보 저장용 BLoC State)
class BlocPageInfoState<pageBusinessType> {
  BlocPageInfoState({required this.pageBusiness});

  // 하위 위젯에 전달할 비즈니스 객체
  pageBusinessType pageBusiness;
}

// (페이지 정보 저장용 BLoC)
// state 저장용이므로 이벤트 설정은 하지 않음.
class BlocPageInfo extends Bloc<bool, BlocPageInfoState> {
  BlocPageInfo(super.firstState);
}

// (페이지 생명주기 관련 states)
// 페이지 생명주기가 진행되며 자동적으로 갱신되며, 이외엔 열람 / 수정할 필요가 없음
class PageLifeCycleStates {
  bool isCanPop = false;
  bool isNoCanPop = false;
  bool isPageCreated = false;
  bool isDisposed = false;

  // 페이지 뷰 최초 설정이 되었는지 여부
  bool isPageViewInit = false;
}
