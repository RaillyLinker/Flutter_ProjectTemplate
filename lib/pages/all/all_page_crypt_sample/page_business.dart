// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/page_outer_frame/widget_business.dart'
    as page_outer_frame_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_functions/gf_crypto.dart' as gf_crypto;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : 템플릿 적용
// todo : 입력 부분 Form 방식 변경

// 암호화, 복화화가 잘 이루어지는지 확인하는 샘플입니다.
// 변환 함수에 원하는 암/복호화 알고리즘을 적용하고, 화면의 버튼을 눌러 결과를 확인할 수 있습니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness(this._context) {
    pageViewModel = PageViewModel(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  late PageViewModel pageViewModel;

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    pageInputVo = page_entrance.PageInputVo();
  }

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!!
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
    pageViewModel.aes256EncryptTextController.dispose();
    pageViewModel.aes256DecryptTextController.dispose();
    pageViewModel.aes256SecretKeyTextController.dispose();
    pageViewModel.aes256IvTextController.dispose();
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!!

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!!
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // BLoC 위젯 관련 상태 변수 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // BLoC 위젯 변경 트리거 발동
//     blocObjects.blocSample.refresh();
//   }

  // (암호화 함수)
  void doEncrypt() {
    String encryptString = pageViewModel.aes256EncryptTextController.text;

    try {
      // !!!원하는 암호화 알고리즘을 적용!!!
      pageViewModel.aes256EncryptResultText = gf_crypto.aes256Encrypt(
        plainText: encryptString,
        secretKey: pageViewModel.aes256SecretKeyTextController.text,
        secretIv: pageViewModel.aes256IvTextController.text,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    blocObjects.blocEncryptResultText.refresh();
  }

  // (복호화 함수)
  void doDecrypt() {
    String decryptString = pageViewModel.aes256DecryptTextController.text;

    try {
      // !!!원하는 복호화 알고리즘을 적용!!!
      pageViewModel.aes256DecryptResultText = gf_crypto.aes256Decrypt(
        cipherText: decryptString,
        secretKey: pageViewModel.aes256SecretKeyTextController.text,
        secretIv: pageViewModel.aes256IvTextController.text,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    blocObjects.blocDecryptResultText.refresh();
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel(this._context);

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;

  // PageOutFrameViewModel
  page_outer_frame_business.WidgetBusiness pageOutFrameBusiness =
      page_outer_frame_business.WidgetBusiness();

  GlobalKey<FormState> aes256FormKey = GlobalKey<FormState>();

  TextEditingController aes256EncryptTextController = TextEditingController();
  TextEditingController aes256DecryptTextController = TextEditingController();
  TextEditingController aes256SecretKeyTextController = TextEditingController();
  TextEditingController aes256IvTextController = TextEditingController();

  String aes256EncryptResultText = "";
  String aes256DecryptResultText = "";
}

// (BLoC 클래스)
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
//
//   // BLoC 위젯 갱신 함수
//   void refresh() {
//     add(!state);
//   }
// }

// (암호화 결과 텍스트 위젯)
class BlocEncryptResultText extends Bloc<bool, bool> {
  BlocEncryptResultText() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

// (복호화 결과 텍스트 위젯)
class BlocDecryptResultText extends Bloc<bool, bool> {
  BlocDecryptResultText() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!이 페이지에서 사용할 "모든" BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 넣어줄 것!!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample())
    BlocProvider<BlocEncryptResultText>(
        create: (context) => BlocEncryptResultText()),
    BlocProvider<BlocDecryptResultText>(
        create: (context) => BlocDecryptResultText()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocEncryptResultText = BlocProvider.of<BlocEncryptResultText>(_context);
    blocDecryptResultText = BlocProvider.of<BlocDecryptResultText>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocEncryptResultText blocEncryptResultText;
  late BlocDecryptResultText blocDecryptResultText;
}
