// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// [BLoC 위젯 샘플 템플릿]
// Page 가 아니라 외부에서 만드는 BLoC 클래스는 아래와 같이 작성하고,
// 이를 사용하려는 페이지의 page_business.dart 안의 blocProviders 리스트 안에 꼭 입력 해야 사용이 가능 합니다.

// -----------------------------------------------------------------------------
class BlocTemplate extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  // !!!BLoC 위젯 상태 변수 선언 및 초기화!!!
  int sampleNumber = 0;

  BlocTemplate() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

// 위젯 샘플
var blocBuilderSample = BlocBuilder<BlocTemplate, bool>(builder: (c, s) {
  BlocTemplate blocTemplate = BlocProvider.of<BlocTemplate>(c);

  return GestureDetector(
    onTap: () {
      // BLoC 상태 변수 변경
      blocTemplate.sampleNumber += 1;

      // BLoC 갱신
      blocTemplate.refresh();
    },
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      // BLoC 상태 변수를 위젯에 반영
      child: Text(
        blocTemplate.sampleNumber.toString(),
      ),
    ),
  );
});
