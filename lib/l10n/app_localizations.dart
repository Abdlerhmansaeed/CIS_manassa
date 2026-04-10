import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @studentId.
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get studentId;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login Success'**
  String get loginSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network.'**
  String get noInternet;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again.'**
  String get connectionTimeout;

  /// No description provided for @receiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'Server took too long to respond. Please try again.'**
  String get receiveTimeout;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get unauthorized;

  /// No description provided for @forbidden.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access this resource.'**
  String get forbidden;

  /// No description provided for @internalServerError.
  ///
  /// In en, this message translates to:
  /// **'The server is temporarily unavailable. Please try again later.'**
  String get internalServerError;

  /// No description provided for @unknownNetwork.
  ///
  /// In en, this message translates to:
  /// **'A network error occurred. Please try again.'**
  String get unknownNetwork;

  /// No description provided for @invalidLogin.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Please check your Student ID and password.'**
  String get invalidLogin;

  /// No description provided for @invalidToken.
  ///
  /// In en, this message translates to:
  /// **'Your session is invalid. Please log in again.'**
  String get invalidToken;

  /// No description provided for @serviceNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'This service is currently unavailable.'**
  String get serviceNotAvailable;

  /// No description provided for @unknownServerError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected server error occurred. Please try again.'**
  String get unknownServerError;

  /// No description provided for @cacheReadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load saved data. Please try again.'**
  String get cacheReadError;

  /// No description provided for @cacheWriteError.
  ///
  /// In en, this message translates to:
  /// **'Could not save data locally. Please try again.'**
  String get cacheWriteError;

  /// No description provided for @parseError.
  ///
  /// In en, this message translates to:
  /// **'Received an unexpected response from the server.'**
  String get parseError;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password? Get Access'**
  String get forgotPassword;

  /// No description provided for @loginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter Student ID and Password'**
  String get loginPrompt;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Your academic life, simplified.'**
  String get appDescription;

  /// No description provided for @getAccessWrongInfoError.
  ///
  /// In en, this message translates to:
  /// **'The information you entered is incorrect. Try to verify it or refer it to the student affairs office'**
  String get getAccessWrongInfoError;

  /// No description provided for @cisStudentHub.
  ///
  /// In en, this message translates to:
  /// **'CIS Student Hub'**
  String get cisStudentHub;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @helpDesk.
  ///
  /// In en, this message translates to:
  /// **'Help Desk'**
  String get helpDesk;

  /// No description provided for @studentIdHint.
  ///
  /// In en, this message translates to:
  /// **'Cxxxxxxx'**
  String get studentIdHint;

  /// No description provided for @getAccess.
  ///
  /// In en, this message translates to:
  /// **'Get Access'**
  String get getAccess;

  /// No description provided for @retrieveCredentials.
  ///
  /// In en, this message translates to:
  /// **'Retrieve Your Credentials'**
  String get retrieveCredentials;

  /// No description provided for @retrieveCredentialsDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your details below to receive your Student ID and Password.'**
  String get retrieveCredentialsDescription;

  /// No description provided for @errorGettingCredentials.
  ///
  /// In en, this message translates to:
  /// **'Error getting credentials'**
  String get errorGettingCredentials;

  /// No description provided for @failedToRetrieveCredentials.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve credentials'**
  String get failedToRetrieveCredentials;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @studentCode.
  ///
  /// In en, this message translates to:
  /// **'Student Code'**
  String get studentCode;

  /// No description provided for @studentCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your student code'**
  String get studentCodeHint;

  /// No description provided for @providedByUniversity.
  ///
  /// In en, this message translates to:
  /// **'Provided by the university'**
  String get providedByUniversity;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @nationalIdHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your 14-digit national ID'**
  String get nationalIdHint;

  /// No description provided for @getAccessPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter Student Code and National ID'**
  String get getAccessPrompt;

  /// No description provided for @getMyCredentials.
  ///
  /// In en, this message translates to:
  /// **'Get My Credentials'**
  String get getMyCredentials;

  /// No description provided for @credentials.
  ///
  /// In en, this message translates to:
  /// **'Credentials'**
  String get credentials;

  /// No description provided for @credentialsRetrieved.
  ///
  /// In en, this message translates to:
  /// **'Credentials Retrieved! 🎉'**
  String get credentialsRetrieved;

  /// No description provided for @credentialsRetrievedDescription.
  ///
  /// In en, this message translates to:
  /// **'Save these details and log in to get started.'**
  String get credentialsRetrievedDescription;

  /// No description provided for @usernameEmail.
  ///
  /// In en, this message translates to:
  /// **'USERNAME (EMAIL)'**
  String get usernameEmail;

  /// No description provided for @goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to Login'**
  String get goToLogin;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @secureAccessFooter.
  ///
  /// In en, this message translates to:
  /// **'ACADEMIC PORTAL SECURE ACCESS'**
  String get secureAccessFooter;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light ☀️'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark 🌙'**
  String get darkMode;

  /// No description provided for @systemMode.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemMode;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Tasks and quizzes reminders'**
  String get notificationsDescription;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @academicData.
  ///
  /// In en, this message translates to:
  /// **'Academic Data'**
  String get academicData;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @thirdYearCis.
  ///
  /// In en, this message translates to:
  /// **'Third Year · CIS'**
  String get thirdYearCis;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
