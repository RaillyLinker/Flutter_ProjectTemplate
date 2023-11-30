// (external)
import 'package:flutter/cupertino.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'dialog_widget.dart' as dialog_widget;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class DialogWidgetState extends State<dialog_widget.DialogWidget>
    with WidgetsBindingObserver {
  DialogWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (needInitState) {
            needInitState = false;
            widget.onDialogCreated();

            // 2초 대기
            await Future.delayed(const Duration(seconds: 2));

            // 다이얼로그 완료 처리
            dialogComplete();
          }

          // !!!생명주기 처리!!!
        },
        onFocusLost: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityGained: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityLost: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundGained: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundLost: () async {
          // !!!생명주기 처리!!!
        },
        child: widget.widgetUiBuild(context: context, currentState: this),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.onDialogCreated();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (최초 실행 플래그)
  bool needInitState = true;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (다이얼로그 작업 완료 여부)
  bool isComplete = false;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  Future<void> dialogComplete() async {
    isComplete = true;
    refreshUi();

    // 애니메이션의 지속 시간만큼 지연
    await Future.delayed(const Duration(milliseconds: 800));

    // 다이얼로그 닫기
    if (!context.mounted) return;
    context.pop();
  }
}
