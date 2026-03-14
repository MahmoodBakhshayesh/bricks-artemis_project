import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login Success'**
  String get loginSuccess;

  /// No description provided for @groundHandlingChargeNote.
  ///
  /// In en, this message translates to:
  /// **'Ground Handling Charge Note'**
  String get groundHandlingChargeNote;

  /// No description provided for @loginPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please fill username and password to login.'**
  String get loginPageSubtitle;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @selectServer.
  ///
  /// In en, this message translates to:
  /// **'Select Server'**
  String get selectServer;

  /// No description provided for @availableServers.
  ///
  /// In en, this message translates to:
  /// **'Available Servers'**
  String get availableServers;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clearAndClose.
  ///
  /// In en, this message translates to:
  /// **'Clear & Close'**
  String get clearAndClose;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @flightList.
  ///
  /// In en, this message translates to:
  /// **'Flight List'**
  String get flightList;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @flight.
  ///
  /// In en, this message translates to:
  /// **'Flight'**
  String get flight;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @std.
  ///
  /// In en, this message translates to:
  /// **'STD'**
  String get std;

  /// No description provided for @reg.
  ///
  /// In en, this message translates to:
  /// **'Reg'**
  String get reg;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @aircraft.
  ///
  /// In en, this message translates to:
  /// **'Aircraft'**
  String get aircraft;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @pcb.
  ///
  /// In en, this message translates to:
  /// **'P/C/B'**
  String get pcb;

  /// No description provided for @statusPoints.
  ///
  /// In en, this message translates to:
  /// **'StatusPoints'**
  String get statusPoints;

  /// No description provided for @checkList.
  ///
  /// In en, this message translates to:
  /// **'CheckList'**
  String get checkList;

  /// No description provided for @messaging.
  ///
  /// In en, this message translates to:
  /// **'Messaging'**
  String get messaging;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @tokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Token Expired'**
  String get tokenExpired;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @flightBoard.
  ///
  /// In en, this message translates to:
  /// **'Flight Board'**
  String get flightBoard;

  /// No description provided for @ahmReports.
  ///
  /// In en, this message translates to:
  /// **'AHM Reports'**
  String get ahmReports;

  /// No description provided for @administrator.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get administrator;

  /// No description provided for @aircraftBasic.
  ///
  /// In en, this message translates to:
  /// **'Aircraft Basic'**
  String get aircraftBasic;

  /// No description provided for @airlineBasic.
  ///
  /// In en, this message translates to:
  /// **'Airline Basic'**
  String get airlineBasic;

  /// No description provided for @supervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get supervisor;

  /// No description provided for @flights.
  ///
  /// In en, this message translates to:
  /// **'Flights'**
  String get flights;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @arrival.
  ///
  /// In en, this message translates to:
  /// **'Arrival'**
  String get arrival;

  /// No description provided for @loadControl.
  ///
  /// In en, this message translates to:
  /// **'Load Control'**
  String get loadControl;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @reportCPT.
  ///
  /// In en, this message translates to:
  /// **'Report CPT'**
  String get reportCPT;

  /// No description provided for @reportPaxBag.
  ///
  /// In en, this message translates to:
  /// **'report Pax&Bag'**
  String get reportPaxBag;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @userList.
  ///
  /// In en, this message translates to:
  /// **'User List'**
  String get userList;

  /// No description provided for @userGroup.
  ///
  /// In en, this message translates to:
  /// **'User Group'**
  String get userGroup;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @compareDocument.
  ///
  /// In en, this message translates to:
  /// **'Compare Document'**
  String get compareDocument;

  /// No description provided for @flightDetails.
  ///
  /// In en, this message translates to:
  /// **'Flight Details'**
  String get flightDetails;

  /// No description provided for @serverTimeError.
  ///
  /// In en, this message translates to:
  /// **'Device Time is not correct.\nit makes some functionality unavailable.'**
  String get serverTimeError;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @prev.
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get prev;

  /// No description provided for @origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get origin;

  /// No description provided for @assign.
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get assign;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @charge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get charge;

  /// No description provided for @currentUserGroup.
  ///
  /// In en, this message translates to:
  /// **'Current User Group'**
  String get currentUserGroup;

  /// No description provided for @assignedUser.
  ///
  /// In en, this message translates to:
  /// **'Assigned User'**
  String get assignedUser;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @serviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Title'**
  String get serviceTitle;

  /// No description provided for @startOperation.
  ///
  /// In en, this message translates to:
  /// **'Start Operation'**
  String get startOperation;

  /// No description provided for @endOperation.
  ///
  /// In en, this message translates to:
  /// **'End Operation'**
  String get endOperation;

  /// No description provided for @moreOperation.
  ///
  /// In en, this message translates to:
  /// **'More Operation'**
  String get moreOperation;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minute;

  /// No description provided for @lastAction.
  ///
  /// In en, this message translates to:
  /// **'Last Action'**
  String get lastAction;

  /// No description provided for @remarkList.
  ///
  /// In en, this message translates to:
  /// **'Remark List'**
  String get remarkList;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @deviceCode.
  ///
  /// In en, this message translates to:
  /// **'Device Code'**
  String get deviceCode;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @addServiceRemark.
  ///
  /// In en, this message translates to:
  /// **'Add Service Remark'**
  String get addServiceRemark;

  /// No description provided for @flightConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Flight Confirmation'**
  String get flightConfirmation;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @remark.
  ///
  /// In en, this message translates to:
  /// **'Remark'**
  String get remark;

  /// No description provided for @chargeNote.
  ///
  /// In en, this message translates to:
  /// **'Charge Note'**
  String get chargeNote;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @serviceHistory.
  ///
  /// In en, this message translates to:
  /// **'Service History'**
  String get serviceHistory;

  /// No description provided for @addFlight.
  ///
  /// In en, this message translates to:
  /// **'Add Flight'**
  String get addFlight;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @assignFlight.
  ///
  /// In en, this message translates to:
  /// **'Assign Flight'**
  String get assignFlight;

  /// No description provided for @confirmThisReassignment.
  ///
  /// In en, this message translates to:
  /// **'I confirm this reassignment.'**
  String get confirmThisReassignment;

  /// No description provided for @forceAssign.
  ///
  /// In en, this message translates to:
  /// **'Force Assign'**
  String get forceAssign;

  /// No description provided for @addFlightService.
  ///
  /// In en, this message translates to:
  /// **'Add Flight Service'**
  String get addFlightService;

  /// No description provided for @serviceList.
  ///
  /// In en, this message translates to:
  /// **'Service List'**
  String get serviceList;

  /// No description provided for @ariCrafts.
  ///
  /// In en, this message translates to:
  /// **'Aricrafts'**
  String get ariCrafts;

  /// No description provided for @deleteService.
  ///
  /// In en, this message translates to:
  /// **'Delete Service'**
  String get deleteService;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @deleteFlightServiceSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Delete Flight Service was Successful.'**
  String get deleteFlightServiceSuccessful;

  /// No description provided for @pleaseConfirmThisAction.
  ///
  /// In en, this message translates to:
  /// **'Please confirm this action'**
  String get pleaseConfirmThisAction;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchServiceHere.
  ///
  /// In en, this message translates to:
  /// **'Search Service Here...'**
  String get searchServiceHere;

  /// No description provided for @rejectFlight.
  ///
  /// In en, this message translates to:
  /// **'Reject Flight'**
  String get rejectFlight;

  /// No description provided for @subUnit.
  ///
  /// In en, this message translates to:
  /// **'SubUnit'**
  String get subUnit;

  /// No description provided for @logoutConfirmationText.
  ///
  /// In en, this message translates to:
  /// **'You’ll be signed out of your account and need to log in again to continue.'**
  String get logoutConfirmationText;
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
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
