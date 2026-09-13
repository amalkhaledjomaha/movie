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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @findYourNextFavoriteMovie.
  ///
  /// In en, this message translates to:
  /// **'Find Your Next\nFavorite Movie Here'**
  String get findYourNextFavoriteMovie;

  /// No description provided for @getAccessToHugeLibrary.
  ///
  /// In en, this message translates to:
  /// **'Get access to a huge library of movies to suit all tastes. You will surely like it.'**
  String get getAccessToHugeLibrary;

  /// No description provided for @discoverMovies.
  ///
  /// In en, this message translates to:
  /// **'Discover Movies'**
  String get discoverMovies;

  /// No description provided for @discoverMoviesDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.'**
  String get discoverMoviesDescription;

  /// No description provided for @exploreAllGenres.
  ///
  /// In en, this message translates to:
  /// **'Explore All Genres'**
  String get exploreAllGenres;

  /// No description provided for @exploreAllGenresDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.'**
  String get exploreAllGenresDescription;

  /// No description provided for @createWatchlists.
  ///
  /// In en, this message translates to:
  /// **'Create Watchlists'**
  String get createWatchlists;

  /// No description provided for @createWatchlistsDescription.
  ///
  /// In en, this message translates to:
  /// **'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.'**
  String get createWatchlistsDescription;

  /// No description provided for @rateReviewAndLearn.
  ///
  /// In en, this message translates to:
  /// **'Rate, Review, and Learn'**
  String get rateReviewAndLearn;

  /// No description provided for @rateReviewAndLearnDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies through your reviews.'**
  String get rateReviewAndLearnDescription;

  /// No description provided for @startWatchingNow.
  ///
  /// In en, this message translates to:
  /// **'Start Watching Now'**
  String get startWatchingNow;

  /// No description provided for @startWatchingNowDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies through your reviews.'**
  String get startWatchingNowDescription;

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

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get exploreNow;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetenpaword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forgetenpaword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @donthaveaccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account ?'**
  String get donthaveaccount;

  /// No description provided for @createone.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get createone;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @loginwithgoogle.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get loginwithgoogle;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirmpassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmpassword;

  /// No description provided for @phonenumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phonenumber;

  /// No description provided for @createaccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createaccount;

  /// No description provided for @alreadyhaveaccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ?'**
  String get alreadyhaveaccount;

  /// No description provided for @pickavatar.
  ///
  /// In en, this message translates to:
  /// **'Pick Avatar'**
  String get pickavatar;

  /// No description provided for @johnsafwat.
  ///
  /// In en, this message translates to:
  /// **'John Safwat'**
  String get johnsafwat;

  /// No description provided for @resetpassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetpassword;

  /// No description provided for @deleteaccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteaccount;

  /// No description provided for @updatedata.
  ///
  /// In en, this message translates to:
  /// **'Update Data'**
  String get updatedata;

  /// No description provided for @nameisrequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameisrequired;

  /// No description provided for @namemustbeatleast3characters.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters'**
  String get namemustbeatleast3characters;

  /// No description provided for @confirmpasswordisrequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmpasswordisrequired;

  /// No description provided for @passwordsdonotmatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsdonotmatch;

  /// No description provided for @phoneisrequired.
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get phoneisrequired;

  /// No description provided for @phonethan10.
  ///
  /// In en, this message translates to:
  /// **'Phone must be at least 10 characters'**
  String get phonethan10;

  /// No description provided for @invalidphone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get invalidphone;

  /// No description provided for @accountupdated.
  ///
  /// In en, this message translates to:
  /// **'Account updated successfully'**
  String get accountupdated;

  /// No description provided for @updateerror.
  ///
  /// In en, this message translates to:
  /// **'Failed to update account'**
  String get updateerror;

  /// No description provided for @deleteaccounttitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteaccounttitle;

  /// No description provided for @deleteaccountmessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get deleteaccountmessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @loginagaintodelete.
  ///
  /// In en, this message translates to:
  /// **'Please login again to delete your account'**
  String get loginagaintodelete;

  /// No description provided for @deleteerror.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account'**
  String get deleteerror;

  /// No description provided for @emailisrequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailisrequired;

  /// No description provided for @enteravalidemail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enteravalidemail;

  /// No description provided for @passwordisrequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordisrequired;

  /// No description provided for @passwordmustbeatleast6characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordmustbeatleast6characters;

  /// No description provided for @invalid_credential.
  ///
  /// In en, this message translates to:
  /// **'invalid-credential'**
  String get invalid_credential;

  /// No description provided for @emailorpasswordisincorrect.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get emailorpasswordisincorrect;

  /// No description provided for @user_not_found.
  ///
  /// In en, this message translates to:
  /// **'user-not-found'**
  String get user_not_found;

  /// No description provided for @noaccountfoundwiththisemail.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email'**
  String get noaccountfoundwiththisemail;

  /// No description provided for @wrong_password.
  ///
  /// In en, this message translates to:
  /// **'wrong-password'**
  String get wrong_password;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get incorrectPassword;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'invalid-email'**
  String get invalid_email;

  /// No description provided for @pleaseenteravalidemail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseenteravalidemail;

  /// No description provided for @too_many_requests.
  ///
  /// In en, this message translates to:
  /// **'too-many-requests'**
  String get too_many_requests;

  /// No description provided for @too_many_attempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get too_many_attempts;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get something_went_wrong;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get login_title;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @title_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get title_success;

  /// No description provided for @desc_Success.
  ///
  /// In en, this message translates to:
  /// **'Password reset link has been sent to your email.'**
  String get desc_Success;

  /// No description provided for @title_error.
  ///
  /// In en, this message translates to:
  /// **'Reset Password Failed'**
  String get title_error;

  /// No description provided for @accountcreatedsuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get accountcreatedsuccessfully;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @somethingwentwrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingwentwrong;

  /// No description provided for @weakpassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak'**
  String get weakpassword;

  /// No description provided for @emailalreadyinuse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get emailalreadyinuse;

  /// No description provided for @invalidemail.
  ///
  /// In en, this message translates to:
  /// **'The email address is not valid'**
  String get invalidemail;

  /// No description provided for @operationnotallowed.
  ///
  /// In en, this message translates to:
  /// **'Email/Password authentication is not enabled'**
  String get operationnotallowed;

  /// No description provided for @networkrequestfailed.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection'**
  String get networkrequestfailed;

  /// No description provided for @watchnow.
  ///
  /// In en, this message translates to:
  /// **'Watch Now'**
  String get watchnow;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @seemore.
  ///
  /// In en, this message translates to:
  /// **'See More →'**
  String get seemore;

  /// No description provided for @availablenow.
  ///
  /// In en, this message translates to:
  /// **'Available Now'**
  String get availablenow;

  /// No description provided for @romance.
  ///
  /// In en, this message translates to:
  /// **'Romance'**
  String get romance;

  /// No description provided for @comedy.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get comedy;

  /// No description provided for @horror.
  ///
  /// In en, this message translates to:
  /// **'Horror'**
  String get horror;

  /// No description provided for @thriller.
  ///
  /// In en, this message translates to:
  /// **'Thriller'**
  String get thriller;

  /// No description provided for @sciFi.
  ///
  /// In en, this message translates to:
  /// **'Sci-Fi'**
  String get sciFi;

  /// No description provided for @movieapp.
  ///
  /// In en, this message translates to:
  /// **'Movie App'**
  String get movieapp;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
