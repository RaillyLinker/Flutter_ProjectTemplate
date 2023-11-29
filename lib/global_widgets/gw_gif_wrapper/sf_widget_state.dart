// (external)
import 'package:flutter/cupertino.dart';
import 'package:gif/gif.dart';

// (inner Folder)
import 'sf_widget.dart' as sf_widget;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class SfWidgetState extends State<sf_widget.SfWidget>
    with SingleTickerProviderStateMixin {
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
