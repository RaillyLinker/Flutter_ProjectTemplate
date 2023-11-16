// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// [위젯 샘플 템플릿]
// Page 외부에서 위젯을 만드는 샘플입니다. (BLoC 를 이용한 동적 위젯 포함)
// 아래와 같이 작성하세요.

// -----------------------------------------------------------------------------
// (위젯 샘플)
class WidgetTemplate extends StatelessWidget {
  const WidgetTemplate(this._viewModel, {super.key});

  final WidgetViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    // 본 위젯 외부에서 BLoC 객체를 다루려면 이런 형식으로 context 에서 객체를 가져와 사용하면 됩니다.
    BlocTemplate blocTemplate = BlocProvider.of<BlocTemplate>(context);

    // 하위 위젯 UI 작성 (BLoC 를 사용한 것을 가정)
    return BlocBuilder<BlocTemplate, bool>(builder: (c, s) {
      return GestureDetector(
        onTap: () {
          // BLoC 상태 변수 변경
          _viewModel.sampleNumber += 1;

          // BLoC 갱신
          blocTemplate.refresh();
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          // BLoC 상태 변수를 위젯에 반영
          child: Text(
            _viewModel.sampleNumber.toString(),
          ),
        ),
      );
    });
  }
}

// 위젯에서 사용할 모든 정보를 담고 있는 뷰모델은 페이지의 뷰모델에 저장 하여 위젯 생성시 입력 합니다.
class WidgetViewModel {
  WidgetViewModel(this.sampleNumber);

  // !!!위젯 에서 사용할 상태 변수 선언!!!
  // 주로 여기선 BLoC 에서 사용할 변수를 선언하고,
  // 가독성을 위하여 Stateless 위젯에서 사용하는 변수는 해당 변수의 파라미터로 설정하세요.
  int sampleNumber;
}

// 위젯에서 사용할 모든 BLoC 객체들은 페이지의 page_business.dart 안에 있는 BLocProviders 에 반드시 등록을 해야합니다.
class BlocTemplate extends Bloc<bool, bool> {
  BlocTemplate() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}
