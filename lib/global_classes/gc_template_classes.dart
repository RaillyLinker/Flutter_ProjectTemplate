// (external)
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// [템플릿 코드를 줄이기 위해 사용하는 클래스 모음 파일]

// -----------------------------------------------------------------------------
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

// (네트워크 응답 Vo)
class NetworkResponseObject<ResponseHeaderVo, ResponseBodyVo> {
  NetworkResponseObject(
      {required this.networkResponseObjectOk, required this.dioException});

  // Dio Error 가 나지 않은 경우 not null
  NetworkResponseObjectOk? networkResponseObjectOk;

  // Dio Error 가 난 경우에 not null
  DioException? dioException;
}

class NetworkResponseObjectOk<ResponseHeaderVo, ResponseBodyVo> {
  NetworkResponseObjectOk(
      {required this.responseStatusCode,
      required this.responseHeaders,
      required this.responseBody});

  // Http Status Code
  int responseStatusCode;

  // Response Header Object
  ResponseHeaderVo responseHeaders;

  // Response Body Object (body 가 반환 되지 않는 조건에는 null)
  ResponseBodyVo? responseBody;
}
