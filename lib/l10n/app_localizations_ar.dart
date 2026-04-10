// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get studentId => 'كود الطالب';

  @override
  String get password => 'كلمة المرور';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة.';

  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';

  @override
  String get receiveTimeout =>
      'استغرق الخادم وقتاً طويلاً للرد. يرجى المحاولة مرة أخرى.';

  @override
  String get unauthorized => 'انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get forbidden => 'ليس لديك إذن للوصول إلى هذا المصدر.';

  @override
  String get internalServerError =>
      'الخادم غير متاح مؤقتاً. يرجى المحاولة مرة أخرى لاحقاً.';

  @override
  String get unknownNetwork => 'حدث خطأ في الشبكة. يرجى المحاولة مرة أخرى.';

  @override
  String get invalidLogin =>
      'بيانات الاعتماد غير صالحة. يرجى التحقق من كود الطالب وكلمة المرور.';

  @override
  String get invalidToken => 'جلستك غير صالحة. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get serviceNotAvailable => 'هذه الخدمة غير متوفرة حالياً.';

  @override
  String get unknownServerError =>
      'حدث خطأ غير متوقع في الخادم. يرجى المحاولة مرة أخرى.';

  @override
  String get cacheReadError =>
      'تعذر تحميل البيانات المحفوظة. يرجى المحاولة مرة أخرى.';

  @override
  String get cacheWriteError =>
      'تعذر حفظ البيانات محلياً. يرجى المحاولة مرة أخرى.';

  @override
  String get parseError => 'تلقينا رداً غير متوقع من الخادم.';

  @override
  String get somethingWentWrong => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟ احصل على وصول';

  @override
  String get loginPrompt => 'يرجى إدخال كود الطالب وكلمة المرور';

  @override
  String get appDescription => 'حياتك الأكاديمية، مبسطة.';

  @override
  String get getAccessWrongInfoError =>
      'المعلومات الي انت دخلتها مش صح حاول تتأكد منها او توجهه لشئون الطلاب';

  @override
  String get cisStudentHub => 'CIS Student Hub';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get helpDesk => 'مكتب المساعدة';

  @override
  String get studentIdHint => 'Cxxxxxxx';

  @override
  String get getAccess => 'الحصول على وصول';

  @override
  String get retrieveCredentials => 'استرجاع بيانات الاعتماد الخاصة بك';

  @override
  String get retrieveCredentialsDescription =>
      'أدخل بياناتك أدناه لاستلام كود الطالب وكلمة المرور الخاصة بك.';

  @override
  String get errorGettingCredentials => 'خطأ في الحصول على بيانات الاعتماد';

  @override
  String get failedToRetrieveCredentials => 'فشل استرجاع بيانات الاعتماد';

  @override
  String get ok => 'موافق';

  @override
  String get studentCode => 'كود الطالب';

  @override
  String get studentCodeHint => 'أدخل كود الطالب الخاص بك';

  @override
  String get providedByUniversity => 'مقدم من الجامعة';

  @override
  String get nationalId => 'الرقم القومي';

  @override
  String get nationalIdHint => 'أدخل الرقم القومي المكون من 14 رقماً';

  @override
  String get getAccessPrompt => 'يرجى إدخال كود الطالب والرقم القومي';

  @override
  String get getMyCredentials => 'الحصول على بياناتي';

  @override
  String get credentials => 'بيانات الاعتماد';

  @override
  String get credentialsRetrieved => 'تم استرجاع بيانات الاعتماد! 🎉';

  @override
  String get credentialsRetrievedDescription =>
      'احفظ هذه التفاصيل وقم بتسجيل الدخول للبدء.';

  @override
  String get usernameEmail => 'اسم المستخدم (البريد الإلكتروني)';

  @override
  String get goToLogin => 'الذهاب لتسجيل الدخول';

  @override
  String get goBack => 'الرجوع';

  @override
  String get secureAccessFooter => 'ACADEMIC PORTAL SECURE ACCESS';

  @override
  String get copiedToClipboard => 'تم النسخ إلى الحافظة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get lightMode => 'فاتح ☀️';

  @override
  String get darkMode => 'داكن 🌙';

  @override
  String get systemMode => 'تلقائي';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get notificationsDescription => 'تذكير المهام والكويزات';

  @override
  String get account => 'الحساب';

  @override
  String get academicData => 'البيانات الأكاديمية';

  @override
  String get aboutApp => 'عن التطبيق';

  @override
  String appVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get thirdYearCis => 'الفرقة الثالثة · CIS';
}
