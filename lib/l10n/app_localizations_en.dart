// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get studentId => 'Student ID';

  @override
  String get password => 'Password';

  @override
  String get loginSuccess => 'Login Success';

  @override
  String get loginFailed => 'Login Failed';

  @override
  String get noInternet => 'No internet connection. Please check your network.';

  @override
  String get connectionTimeout => 'Connection timed out. Please try again.';

  @override
  String get receiveTimeout =>
      'Server took too long to respond. Please try again.';

  @override
  String get unauthorized => 'Your session has expired. Please log in again.';

  @override
  String get forbidden => 'You do not have permission to access this resource.';

  @override
  String get internalServerError =>
      'The server is temporarily unavailable. Please try again later.';

  @override
  String get unknownNetwork => 'A network error occurred. Please try again.';

  @override
  String get invalidLogin =>
      'Invalid credentials. Please check your Student ID and password.';

  @override
  String get invalidToken => 'Your session is invalid. Please log in again.';

  @override
  String get serviceNotAvailable => 'This service is currently unavailable.';

  @override
  String get unknownServerError =>
      'An unexpected server error occurred. Please try again.';

  @override
  String get cacheReadError => 'Could not load saved data. Please try again.';

  @override
  String get cacheWriteError =>
      'Could not save data locally. Please try again.';

  @override
  String get parseError => 'Received an unexpected response from the server.';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get signIn => 'Sign In';

  @override
  String get rememberMe => 'Remember Me';

  @override
  String get forgotPassword => 'Forgot Password? Get Access';

  @override
  String get loginPrompt => 'Please enter Student ID and Password';

  @override
  String get appDescription => 'Your academic life, simplified.';

  @override
  String get getAccessWrongInfoError =>
      'The information you entered is incorrect. Try to verify it or refer it to the student affairs office';

  @override
  String get cisStudentHub => 'CIS Student Hub';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get helpDesk => 'Help Desk';

  @override
  String get studentIdHint => 'Cxxxxxxx';

  @override
  String get getAccess => 'Get Access';

  @override
  String get retrieveCredentials => 'Retrieve Your Credentials';

  @override
  String get retrieveCredentialsDescription =>
      'Enter your details below to receive your Student ID and Password.';

  @override
  String get errorGettingCredentials => 'Error getting credentials';

  @override
  String get failedToRetrieveCredentials => 'Failed to retrieve credentials';

  @override
  String get ok => 'OK';

  @override
  String get studentCode => 'Student Code';

  @override
  String get studentCodeHint => 'Enter your student code';

  @override
  String get providedByUniversity => 'Provided by the university';

  @override
  String get nationalId => 'National ID';

  @override
  String get nationalIdHint => 'Enter your 14-digit national ID';

  @override
  String get getAccessPrompt => 'Please enter Student Code and National ID';

  @override
  String get getMyCredentials => 'Get My Credentials';

  @override
  String get credentials => 'Credentials';

  @override
  String get credentialsRetrieved => 'Credentials Retrieved! 🎉';

  @override
  String get credentialsRetrievedDescription =>
      'Save these details and log in to get started.';

  @override
  String get usernameEmail => 'USERNAME (EMAIL)';

  @override
  String get goToLogin => 'Go to Login';

  @override
  String get goBack => 'Go back';

  @override
  String get secureAccessFooter => 'ACADEMIC PORTAL SECURE ACCESS';

  @override
  String get copiedToClipboard => 'Copied to clipboard';
}
