// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif/gif.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.
// 기본 Stateful Widget 의 Wrapper 클래스를 여기에 저장하여 사용합니다.

// -----------------------------------------------------------------------------
// (컨택스트 메뉴 영역 위젯)
class SfwContextMenuRegion extends StatefulWidget {
  const SfwContextMenuRegion(
      {required this.globalKey,
      required this.child,
      required this.contextMenuRegionItemVoList})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwContextMenuRegionState createState() => SfwContextMenuRegionState();

  // [public 변수]
  final GlobalKey<SfwContextMenuRegionState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!
  // (래핑할 대상 위젯)
  final Widget child;

  // (컨텍스트 메뉴 리스트)
  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required SfwContextMenuRegionState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: (TapUpDetails details) {
          currentState.show(position: details.globalPosition);
        },
        onLongPress: globalKey.currentState!.longPressEnabled
            ? () {
                assert(currentState.longPressOffset != null);
                globalKey.currentState
                    ?.show(position: globalKey.currentState!.longPressOffset!);
                currentState.longPressOffset = null;
              }
            : null,
        onLongPressStart: globalKey.currentState!.longPressEnabled
            ? (LongPressStartDetails details) {
                currentState.longPressOffset = details.globalPosition;
              }
            : null,
        child: child);
  }
}

class SfwContextMenuRegionState extends State<SfwContextMenuRegion> {
  SfwContextMenuRegionState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  // [public 변수]
  Offset? longPressOffset;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (우클릭 메뉴 보이기)
  Future<void> show({required Offset position}) async {
    final RenderObject overlay =
        Overlay.of(context).context.findRenderObject()!;

    List<PopupMenuItem> popupMenuItemList = [];
    Map popupMenuItemCallbackMap = {};
    int idx = 0;
    for (ContextMenuRegionItemVo contextMenuRegionItemVo
        in widget.contextMenuRegionItemVoList) {
      popupMenuItemList.add(PopupMenuItem(
          value: idx, child: contextMenuRegionItemVo.menuItemWidget));

      popupMenuItemCallbackMap[idx] = contextMenuRegionItemVo.menuItemCallback;
      idx += 1;
    }

    // !!!우클릭 메뉴 외곽을 수정하고 싶으면 이것을 수정하기!!!
    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(position.dx, position.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: popupMenuItemList);

    if (popupMenuItemCallbackMap.containsKey(result)) {
      popupMenuItemCallbackMap[result]();
    }
  }

  // (길게 누르기를 할지 우클릭을 할지 여부)
  bool get longPressEnabled {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return true;
      case TargetPlatform.macOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
    }
  }
}

class ContextMenuRegionItemVo {
  ContextMenuRegionItemVo(
      {required this.menuItemWidget, required this.menuItemCallback});

  Widget menuItemWidget;
  void Function() menuItemCallback;
}

// (Gif Widget)
class SfwGifWidget extends StatefulWidget {
  const SfwGifWidget({required this.globalKey, required this.gifImage})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwGifWidgetState createState() => SfwGifWidgetState();

  // [public 변수]
  final GlobalKey<SfwGifWidgetState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!
  final ImageProvider gifImage;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required SfwGifWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Gif(
      image: gifImage,
      controller: currentState.dialogSpinnerGifController,
      placeholder: (context) => const Text(''),
      onFetchCompleted: () {},
    );
  }
}

class SfwGifWidgetState extends State<SfwGifWidget>
    with SingleTickerProviderStateMixin {
  SfwGifWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
    dialogSpinnerGifController = GifController(vsync: this);
    dialogSpinnerGifController.repeat(
        period: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    dialogSpinnerGifController.dispose();

    super.dispose();
  }

  // [public 변수]
  // (Gif 컨트롤러)
  late GifController dialogSpinnerGifController;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

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

// (ListView.Builder)
class SfwListViewBuilder extends StatefulWidget {
  const SfwListViewBuilder(
      {required this.globalKey, required this.itemWidgetList,  this.shrinkWrap = false, this.primary})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwListViewBuilderState createState() => SfwListViewBuilderState();

  // [public 변수]
  final GlobalKey<SfwListViewBuilderState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!
  final List<Widget> itemWidgetList;

  final bool shrinkWrap;

  final bool? primary;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required SfwListViewBuilderState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      primary: primary,
      itemCount: currentState.itemWidgetList.length,
      itemBuilder: (context, index) {
        return currentState.itemWidgetList[index];
      },
    );
  }
}

class SfwListViewBuilderState extends State<SfwListViewBuilder> {
  SfwListViewBuilderState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
    itemWidgetList = widget.itemWidgetList;
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  // [public 변수]
  List<Widget> itemWidgetList = [];

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}
