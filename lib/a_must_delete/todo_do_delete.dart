import 'package:bloc/bloc.dart';

// todo : refreshWrapper 적용 후 파일 삭제
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
