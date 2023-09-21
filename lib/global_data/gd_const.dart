// (external)
import 'package:shared_preferences/shared_preferences.dart';

// [전역 상수 저장 파일]
// 프로그램 전역에서 사용할 전역 상수를 선언하는 파일입니다.

// 상수를 모아둡니다.

// -----------------------------------------------------------------------------
// (SharedPreferences 객체)
late final SharedPreferences sharedPreferences;

// (안드로이드 API 레벨)
// ex : 32 or 33 or 안드로이드 환경이 아니면 null
late final int? androidApiLevel;
