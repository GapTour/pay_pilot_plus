// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `مشکلی پیش آمد، بعداً دوباره تلاش کنید...`
  String get warning_somethingWentWrong {
    return Intl.message(
      'مشکلی پیش آمد، بعداً دوباره تلاش کنید...',
      name: 'warning_somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `عملیات با موفقیت انجام شد!`
  String get warning_operationSuccessful {
    return Intl.message(
      'عملیات با موفقیت انجام شد!',
      name: 'warning_operationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `عملیات ناموفق بود:`
  String get warning_operationFailure {
    return Intl.message(
      'عملیات ناموفق بود:',
      name: 'warning_operationFailure',
      desc: '',
      args: [],
    );
  }

  /// `لطفاً یک رویداد انتخاب کنید!`
  String get warning_selectEvent {
    return Intl.message(
      'لطفاً یک رویداد انتخاب کنید!',
      name: 'warning_selectEvent',
      desc: '',
      args: [],
    );
  }

  /// `خطا در محاسبه حقوق اعضا!`
  String get warning_calculatingSalaryGoesWrong {
    return Intl.message(
      'خطا در محاسبه حقوق اعضا!',
      name: 'warning_calculatingSalaryGoesWrong',
      desc: '',
      args: [],
    );
  }

  /// `توضیحات: `
  String get contentTitle_description {
    return Intl.message(
      'توضیحات: ',
      name: 'contentTitle_description',
      desc: '',
      args: [],
    );
  }

  /// `درآمد `
  String get contentTitle_income {
    return Intl.message(
      'درآمد ',
      name: 'contentTitle_income',
      desc: '',
      args: [],
    );
  }

  /// `هزینه `
  String get contentTitle_expense {
    return Intl.message(
      'هزینه ',
      name: 'contentTitle_expense',
      desc: '',
      args: [],
    );
  }

  /// `کل درآمد: `
  String get contentTitle_totalIncome {
    return Intl.message(
      'کل درآمد: ',
      name: 'contentTitle_totalIncome',
      desc: '',
      args: [],
    );
  }

  /// `کل هزینه: `
  String get contentTitle_totalExpense {
    return Intl.message(
      'کل هزینه: ',
      name: 'contentTitle_totalExpense',
      desc: '',
      args: [],
    );
  }

  /// `مانده: `
  String get contentTitle_balance {
    return Intl.message(
      'مانده: ',
      name: 'contentTitle_balance',
      desc: '',
      args: [],
    );
  }

  /// `فعال: `
  String get contentTitle_active {
    return Intl.message(
      'فعال: ',
      name: 'contentTitle_active',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ عضویت: `
  String get contentTitle_joinAt {
    return Intl.message(
      'تاریخ عضویت: ',
      name: 'contentTitle_joinAt',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ: `
  String get contentTitle_date {
    return Intl.message(
      'تاریخ: ',
      name: 'contentTitle_date',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ تولد: `
  String get contentTitle_birthday {
    return Intl.message(
      'تاریخ تولد: ',
      name: 'contentTitle_birthday',
      desc: '',
      args: [],
    );
  }

  /// `تلفن: `
  String get contentTitle_phone {
    return Intl.message(
      'تلفن: ',
      name: 'contentTitle_phone',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی تلگرام: `
  String get contentTitle_telegram {
    return Intl.message(
      'آی‌دی تلگرام: ',
      name: 'contentTitle_telegram',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی اینستاگرام: `
  String get contentTitle_instagram {
    return Intl.message(
      'آی‌دی اینستاگرام: ',
      name: 'contentTitle_instagram',
      desc: '',
      args: [],
    );
  }

  /// `در `
  String get contentTitle_onDate {
    return Intl.message('در ', name: 'contentTitle_onDate', desc: '', args: []);
  }

  /// `تیم درگیر: `
  String get contentTitle_engagedTeam {
    return Intl.message(
      'تیم درگیر: ',
      name: 'contentTitle_engagedTeam',
      desc: '',
      args: [],
    );
  }

  /// `حقوق `
  String get contentTitle_salary {
    return Intl.message(
      'حقوق ',
      name: 'contentTitle_salary',
      desc: '',
      args: [],
    );
  }

  /// `نامشخص`
  String get contentTitle_unknown {
    return Intl.message(
      'نامشخص',
      name: 'contentTitle_unknown',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت‌نشده`
  String get contentTitle_unpaid {
    return Intl.message(
      'پرداخت‌نشده',
      name: 'contentTitle_unpaid',
      desc: '',
      args: [],
    );
  }

  /// `توسط `
  String get contentTitle_byWho {
    return Intl.message(
      'توسط ',
      name: 'contentTitle_byWho',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های پرداخت‌شده `
  String get contentTitle_paidExpenses {
    return Intl.message(
      'هزینه‌های پرداخت‌شده ',
      name: 'contentTitle_paidExpenses',
      desc: '',
      args: [],
    );
  }

  /// `فروردین`
  String get monthTitle_farvardin {
    return Intl.message(
      'فروردین',
      name: 'monthTitle_farvardin',
      desc: '',
      args: [],
    );
  }

  /// `اردیبهشت`
  String get monthTitle_ordibehesht {
    return Intl.message(
      'اردیبهشت',
      name: 'monthTitle_ordibehesht',
      desc: '',
      args: [],
    );
  }

  /// `خرداد`
  String get monthTitle_khordad {
    return Intl.message(
      'خرداد',
      name: 'monthTitle_khordad',
      desc: '',
      args: [],
    );
  }

  /// `تیر`
  String get monthTitle_tir {
    return Intl.message('تیر', name: 'monthTitle_tir', desc: '', args: []);
  }

  /// `مرداد`
  String get monthTitle_mordad {
    return Intl.message('مرداد', name: 'monthTitle_mordad', desc: '', args: []);
  }

  /// `شهریور`
  String get monthTitle_shahrivar {
    return Intl.message(
      'شهریور',
      name: 'monthTitle_shahrivar',
      desc: '',
      args: [],
    );
  }

  /// `مهر`
  String get monthTitle_mehr {
    return Intl.message('مهر', name: 'monthTitle_mehr', desc: '', args: []);
  }

  /// `آبان`
  String get monthTitle_aban {
    return Intl.message('آبان', name: 'monthTitle_aban', desc: '', args: []);
  }

  /// `آذر`
  String get monthTitle_azar {
    return Intl.message('آذر', name: 'monthTitle_azar', desc: '', args: []);
  }

  /// `دی`
  String get monthTitle_dey {
    return Intl.message('دی', name: 'monthTitle_dey', desc: '', args: []);
  }

  /// `بهمن`
  String get monthTitle_bahman {
    return Intl.message('بهمن', name: 'monthTitle_bahman', desc: '', args: []);
  }

  /// `اسفند`
  String get monthTitle_esfand {
    return Intl.message('اسفند', name: 'monthTitle_esfand', desc: '', args: []);
  }

  /// `عنوان`
  String get textField_label_title {
    return Intl.message(
      'عنوان',
      name: 'textField_label_title',
      desc: '',
      args: [],
    );
  }

  /// `نام`
  String get textField_label_name {
    return Intl.message(
      'نام',
      name: 'textField_label_name',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ عضویت`
  String get textField_label_joinAt {
    return Intl.message(
      'تاریخ عضویت',
      name: 'textField_label_joinAt',
      desc: '',
      args: [],
    );
  }

  /// `ایمیل`
  String get textField_label_email {
    return Intl.message(
      'ایمیل',
      name: 'textField_label_email',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ تولد`
  String get textField_label_birthday {
    return Intl.message(
      'تاریخ تولد',
      name: 'textField_label_birthday',
      desc: '',
      args: [],
    );
  }

  /// `توضیحات`
  String get textField_label_description {
    return Intl.message(
      'توضیحات',
      name: 'textField_label_description',
      desc: '',
      args: [],
    );
  }

  /// `(اختیاری)`
  String get textField_label_optional {
    return Intl.message(
      '(اختیاری)',
      name: 'textField_label_optional',
      desc: '',
      args: [],
    );
  }

  /// `تیم`
  String get textField_label_team {
    return Intl.message(
      'تیم',
      name: 'textField_label_team',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ`
  String get textField_label_amount {
    return Intl.message(
      'مبلغ',
      name: 'textField_label_amount',
      desc: '',
      args: [],
    );
  }

  /// `رمز عبور`
  String get textField_label_password {
    return Intl.message(
      'رمز عبور',
      name: 'textField_label_password',
      desc: '',
      args: [],
    );
  }

  /// `تکرار رمز عبور`
  String get textField_label_repeatPassword {
    return Intl.message(
      'تکرار رمز عبور',
      name: 'textField_label_repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `نسبت`
  String get textField_label_ratio {
    return Intl.message(
      'نسبت',
      name: 'textField_label_ratio',
      desc: '',
      args: [],
    );
  }

  /// `تلفن`
  String get textField_label_phone {
    return Intl.message(
      'تلفن',
      name: 'textField_label_phone',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی تلگرام`
  String get textField_label_telegramId {
    return Intl.message(
      'آی‌دی تلگرام',
      name: 'textField_label_telegramId',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی اینستاگرام`
  String get textField_label_instagramId {
    return Intl.message(
      'آی‌دی اینستاگرام',
      name: 'textField_label_instagramId',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ`
  String get textField_label_date {
    return Intl.message(
      'تاریخ',
      name: 'textField_label_date',
      desc: '',
      args: [],
    );
  }

  /// `تولید برای`
  String get textField_label_generateFor {
    return Intl.message(
      'تولید برای',
      name: 'textField_label_generateFor',
      desc: '',
      args: [],
    );
  }

  /// `تحلیل فیلم`
  String get textField_hint_movieAnalyze {
    return Intl.message(
      'تحلیل فیلم',
      name: 'textField_hint_movieAnalyze',
      desc: '',
      args: [],
    );
  }

  /// `کیک شکلاتی`
  String get textField_hint_chocolateCake {
    return Intl.message(
      'کیک شکلاتی',
      name: 'textField_hint_chocolateCake',
      desc: '',
      args: [],
    );
  }

  /// `مهدیار`
  String get textField_hint_mahdiyar {
    return Intl.message(
      'مهدیار',
      name: 'textField_hint_mahdiyar',
      desc: '',
      args: [],
    );
  }

  /// `فیلم Cast Away`
  String get textField_hint_castAwayMovie {
    return Intl.message(
      'فیلم Cast Away',
      name: 'textField_hint_castAwayMovie',
      desc: '',
      args: [],
    );
  }

  /// `@mahdiyar`
  String get textField_hint_id {
    return Intl.message(
      '@mahdiyar',
      name: 'textField_hint_id',
      desc: '',
      args: [],
    );
  }

  /// `09391543702`
  String get textField_hint_phone {
    return Intl.message(
      '09391543702',
      name: 'textField_hint_phone',
      desc: '',
      args: [],
    );
  }

  /// `حقوق این ماه`
  String get textField_hint_thisMonthSalary {
    return Intl.message(
      'حقوق این ماه',
      name: 'textField_hint_thisMonthSalary',
      desc: '',
      args: [],
    );
  }

  /// `• الزامی`
  String get validator_required {
    return Intl.message(
      '• الزامی',
      name: 'validator_required',
      desc: '',
      args: [],
    );
  }

  /// `• رمز عبور مطابقت ندارد`
  String get validator_passwordNotMatch {
    return Intl.message(
      '• رمز عبور مطابقت ندارد',
      name: 'validator_passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `• هیچ عضوی برای اضافه کردن وجود ندارد`
  String get validator_noMemberToAddTeam {
    return Intl.message(
      '• هیچ عضوی برای اضافه کردن وجود ندارد',
      name: 'validator_noMemberToAddTeam',
      desc: '',
      args: [],
    );
  }

  /// `• هیچ نسبتی برای اضافه کردن وجود ندارد`
  String get validator_thereIsNoRatio {
    return Intl.message(
      '• هیچ نسبتی برای اضافه کردن وجود ندارد',
      name: 'validator_thereIsNoRatio',
      desc: '',
      args: [],
    );
  }

  /// `• نسبت نمی‌تواند بیشتر از {ratio} باشد`
  String validator_ratioCanNotMoreThan(int ratio) {
    return Intl.message(
      '• نسبت نمی‌تواند بیشتر از $ratio باشد',
      name: 'validator_ratioCanNotMoreThan',
      desc: 'add reminded ratio',
      args: [ratio],
    );
  }

  /// `اعضا`
  String get dropDownButton_label_members {
    return Intl.message(
      'اعضا',
      name: 'dropDownButton_label_members',
      desc: '',
      args: [],
    );
  }

  /// `مهمانان`
  String get dropDownButton_label_guests {
    return Intl.message(
      'مهمانان',
      name: 'dropDownButton_label_guests',
      desc: '',
      args: [],
    );
  }

  /// `تیم‌ها`
  String get dropDownButton_label_teams {
    return Intl.message(
      'تیم‌ها',
      name: 'dropDownButton_label_teams',
      desc: '',
      args: [],
    );
  }

  /// `نوع تراکنش`
  String get dropDownButton_label_transactionType {
    return Intl.message(
      'نوع تراکنش',
      name: 'dropDownButton_label_transactionType',
      desc: '',
      args: [],
    );
  }

  /// `یک نوع انتخاب کنید`
  String get dropDownButton_hint_selectType {
    return Intl.message(
      'یک نوع انتخاب کنید',
      name: 'dropDownButton_hint_selectType',
      desc: '',
      args: [],
    );
  }

  /// `یک مهمان انتخاب کنید`
  String get dropDownButton_hint_selectGuest {
    return Intl.message(
      'یک مهمان انتخاب کنید',
      name: 'dropDownButton_hint_selectGuest',
      desc: '',
      args: [],
    );
  }

  /// `یک عضو انتخاب کنید`
  String get dropDownButton_hint_selectMember {
    return Intl.message(
      'یک عضو انتخاب کنید',
      name: 'dropDownButton_hint_selectMember',
      desc: '',
      args: [],
    );
  }

  /// `یک آیتم انتخاب کنید`
  String get dropDownButton_hint_selectItem {
    return Intl.message(
      'یک آیتم انتخاب کنید',
      name: 'dropDownButton_hint_selectItem',
      desc: '',
      args: [],
    );
  }

  /// `یک تیم انتخاب کنید`
  String get dropDownButton_hint_selectTeam {
    return Intl.message(
      'یک تیم انتخاب کنید',
      name: 'dropDownButton_hint_selectTeam',
      desc: '',
      args: [],
    );
  }

  /// `امروز`
  String get button_title_today {
    return Intl.message(
      'امروز',
      name: 'button_title_today',
      desc: '',
      args: [],
    );
  }

  /// `اعضای تیم`
  String get button_title_teamMember {
    return Intl.message(
      'اعضای تیم',
      name: 'button_title_teamMember',
      desc: '',
      args: [],
    );
  }

  /// `تولید پشتیبان`
  String get button_title_backup {
    return Intl.message(
      'تولید پشتیبان',
      name: 'button_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `بازیابی داده`
  String get button_title_restore {
    return Intl.message(
      'بازیابی داده',
      name: 'button_title_restore',
      desc: '',
      args: [],
    );
  }

  /// `تغییر زبان`
  String get button_title_changeLanguage {
    return Intl.message(
      'تغییر زبان',
      name: 'button_title_changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `انصراف`
  String get button_title_cancel {
    return Intl.message(
      'انصراف',
      name: 'button_title_cancel',
      desc: '',
      args: [],
    );
  }

  /// `ورود`
  String get button_title_login {
    return Intl.message('ورود', name: 'button_title_login', desc: '', args: []);
  }

  /// `تغییر به حالت آفلاین`
  String get button_title_switchToOfflineMode {
    return Intl.message(
      'تغییر به حالت آفلاین',
      name: 'button_title_switchToOfflineMode',
      desc: '',
      args: [],
    );
  }

  /// `ثبت‌نام`
  String get button_title_register {
    return Intl.message(
      'ثبت‌نام',
      name: 'button_title_register',
      desc: '',
      args: [],
    );
  }

  /// `بازگشت به ورود`
  String get button_title_backToLogin {
    return Intl.message(
      'بازگشت به ورود',
      name: 'button_title_backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `قبلی`
  String get button_title_previous {
    return Intl.message(
      'قبلی',
      name: 'button_title_previous',
      desc: '',
      args: [],
    );
  }

  /// `تولید`
  String get button_title_generate {
    return Intl.message(
      'تولید',
      name: 'button_title_generate',
      desc: '',
      args: [],
    );
  }

  /// `بعدی`
  String get button_title_next {
    return Intl.message('بعدی', name: 'button_title_next', desc: '', args: []);
  }

  /// `حذف`
  String get button_title_delete {
    return Intl.message('حذف', name: 'button_title_delete', desc: '', args: []);
  }

  /// `اعضا`
  String get button_title_members {
    return Intl.message(
      'اعضا',
      name: 'button_title_members',
      desc: '',
      args: [],
    );
  }

  /// `پیش‌نمایش`
  String get button_title_preview {
    return Intl.message(
      'پیش‌نمایش',
      name: 'button_title_preview',
      desc: '',
      args: [],
    );
  }

  /// `تیم ها`
  String get button_title_teams {
    return Intl.message(
      'تیم ها',
      name: 'button_title_teams',
      desc: '',
      args: [],
    );
  }

  /// `مهمانان`
  String get button_title_guests {
    return Intl.message(
      'مهمانان',
      name: 'button_title_guests',
      desc: '',
      args: [],
    );
  }

  /// `منو`
  String get button_title_menuItems {
    return Intl.message(
      'منو',
      name: 'button_title_menuItems',
      desc: '',
      args: [],
    );
  }

  /// `رویدادها`
  String get button_title_events {
    return Intl.message(
      'رویدادها',
      name: 'button_title_events',
      desc: '',
      args: [],
    );
  }

  /// `گزارش‌ها`
  String get button_title_reports {
    return Intl.message(
      'گزارش‌ها',
      name: 'button_title_reports',
      desc: '',
      args: [],
    );
  }

  /// `تنظیمات`
  String get button_title_settings {
    return Intl.message(
      'تنظیمات',
      name: 'button_title_settings',
      desc: '',
      args: [],
    );
  }

  /// `تایید`
  String get button_title_submit {
    return Intl.message(
      'تایید',
      name: 'button_title_submit',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش`
  String get button_title_edit {
    return Intl.message(
      'ویرایش',
      name: 'button_title_edit',
      desc: '',
      args: [],
    );
  }

  /// `گزارش حقوق`
  String get button_title_salaryReport {
    return Intl.message(
      'گزارش حقوق',
      name: 'button_title_salaryReport',
      desc: '',
      args: [],
    );
  }

  /// `حالت آنلاین`
  String get button_title_onlineMode {
    return Intl.message(
      'حالت آنلاین',
      name: 'button_title_onlineMode',
      desc: '',
      args: [],
    );
  }

  /// `حالت آفلاین`
  String get button_title_offlineMode {
    return Intl.message(
      'حالت آفلاین',
      name: 'button_title_offlineMode',
      desc: '',
      args: [],
    );
  }

  /// `تغییر زبان`
  String get modalBottom_title_changeLanguage {
    return Intl.message(
      'تغییر زبان',
      name: 'modalBottom_title_changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `درباره انجام این عملیات اطمینان دارید؟`
  String get alertDialog_areYouSure {
    return Intl.message(
      'درباره انجام این عملیات اطمینان دارید؟',
      name: 'alertDialog_areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `توجه کنید که در صورت حذف این آیتم، تمامی اطلاعات مربوط به این آیتم هم به صورت اتوماتیک حذف خواهد شد.`
  String get alertDialog_noticeThisAboutAction {
    return Intl.message(
      'توجه کنید که در صورت حذف این آیتم، تمامی اطلاعات مربوط به این آیتم هم به صورت اتوماتیک حذف خواهد شد.',
      name: 'alertDialog_noticeThisAboutAction',
      desc: '',
      args: [],
    );
  }

  /// `در صورت تایید تغییرات اعمال شده ذخیره نخواهد شد!`
  String get alertDialog_discardChanges {
    return Intl.message(
      'در صورت تایید تغییرات اعمال شده ذخیره نخواهد شد!',
      name: 'alertDialog_discardChanges',
      desc: '',
      args: [],
    );
  }

  /// `ثبت یک حساب جدید...`
  String get register_appBarTitle {
    return Intl.message(
      'ثبت یک حساب جدید...',
      name: 'register_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `ورود به حساب کاربری...`
  String get login_appBarTitle {
    return Intl.message(
      'ورود به حساب کاربری...',
      name: 'login_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `تنظیمات`
  String get settings_appBarTitle {
    return Intl.message(
      'تنظیمات',
      name: 'settings_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `اعضای تیم`
  String get teamDetials_appBarTitle {
    return Intl.message(
      'اعضای تیم',
      name: 'teamDetials_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `افزودن عضو جدید`
  String get teamDetails_addMembers {
    return Intl.message(
      'افزودن عضو جدید',
      name: 'teamDetails_addMembers',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش عضو`
  String get teamDetails_editMembers {
    return Intl.message(
      'ویرایش عضو',
      name: 'teamDetails_editMembers',
      desc: '',
      args: [],
    );
  }

  /// `هنوز عضوی اضافه نشده است!`
  String get teamDetails_emptyStateContent {
    return Intl.message(
      'هنوز عضوی اضافه نشده است!',
      name: 'teamDetails_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `تیم‌ها`
  String get team_appBarTitle {
    return Intl.message('تیم‌ها', name: 'team_appBarTitle', desc: '', args: []);
  }

  /// `هنوز تیمی اضافه نشده است!`
  String get team_emptyStateContent {
    return Intl.message(
      'هنوز تیمی اضافه نشده است!',
      name: 'team_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن تیم جدید`
  String get team_addTeam {
    return Intl.message(
      'افزودن تیم جدید',
      name: 'team_addTeam',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش تیم`
  String get team_editTeam {
    return Intl.message(
      'ویرایش تیم',
      name: 'team_editTeam',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات عضو`
  String get memberDetails_appBarTitle {
    return Intl.message(
      'جزئیات عضو',
      name: 'memberDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `اعضا`
  String get member_appBarTitle {
    return Intl.message('اعضا', name: 'member_appBarTitle', desc: '', args: []);
  }

  /// `هنوز عضوی اضافه نشده است!`
  String get member_emptyStateContent {
    return Intl.message(
      'هنوز عضوی اضافه نشده است!',
      name: 'member_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن عضو جدید`
  String get member_addMember {
    return Intl.message(
      'افزودن عضو جدید',
      name: 'member_addMember',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش عضو`
  String get member_editMember {
    return Intl.message(
      'ویرایش عضو',
      name: 'member_editMember',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات رویداد`
  String get eventDetails_appBarTitle {
    return Intl.message(
      'جزئیات رویداد',
      name: 'eventDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش تراکنش`
  String get eventDetails_editEventTransaction {
    return Intl.message(
      'ویرایش تراکنش',
      name: 'eventDetails_editEventTransaction',
      desc: '',
      args: [],
    );
  }

  /// `افزودن تراکنش جدید`
  String get eventDetails_addEventTransaction {
    return Intl.message(
      'افزودن تراکنش جدید',
      name: 'eventDetails_addEventTransaction',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش سفارش`
  String get eventDetails_editEventOrder {
    return Intl.message(
      'ویرایش سفارش',
      name: 'eventDetails_editEventOrder',
      desc: '',
      args: [],
    );
  }

  /// `افزودن سفارش جدید`
  String get eventDetails_addEventOrder {
    return Intl.message(
      'افزودن سفارش جدید',
      name: 'eventDetails_addEventOrder',
      desc: '',
      args: [],
    );
  }

  /// `لطفاً انتخاب کنید...`
  String get eventDetails_selectOrder {
    return Intl.message(
      'لطفاً انتخاب کنید...',
      name: 'eventDetails_selectOrder',
      desc: '',
      args: [],
    );
  }

  /// `سفارش‌دهنده`
  String get eventDetails_orderBy {
    return Intl.message(
      'سفارش‌دهنده',
      name: 'eventDetails_orderBy',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش نسبت`
  String get eventDetails_editEventRatio {
    return Intl.message(
      'ویرایش نسبت',
      name: 'eventDetails_editEventRatio',
      desc: '',
      args: [],
    );
  }

  /// `افزودن نسبت عضو جدید`
  String get eventDetails_addEventRatio {
    return Intl.message(
      'افزودن نسبت عضو جدید',
      name: 'eventDetails_addEventRatio',
      desc: '',
      args: [],
    );
  }

  /// `تراکنش‌ها`
  String get eventDetails_tabBar_transactions {
    return Intl.message(
      'تراکنش‌ها',
      name: 'eventDetails_tabBar_transactions',
      desc: '',
      args: [],
    );
  }

  /// `سفارش‌ها`
  String get eventDetails_tabBar_orders {
    return Intl.message(
      'سفارش‌ها',
      name: 'eventDetails_tabBar_orders',
      desc: '',
      args: [],
    );
  }

  /// `اعضا`
  String get eventDetails_tabBar_members {
    return Intl.message(
      'اعضا',
      name: 'eventDetails_tabBar_members',
      desc: '',
      args: [],
    );
  }

  /// `عضو`
  String get eventDetails_tabBar_member {
    return Intl.message(
      'عضو',
      name: 'eventDetails_tabBar_member',
      desc: '',
      args: [],
    );
  }

  /// `مهمان`
  String get eventDetails_tabBar_guest {
    return Intl.message(
      'مهمان',
      name: 'eventDetails_tabBar_guest',
      desc: '',
      args: [],
    );
  }

  /// `گزارش`
  String get eventDetails_tabBar_report {
    return Intl.message(
      'گزارش',
      name: 'eventDetails_tabBar_report',
      desc: '',
      args: [],
    );
  }

  /// `همه`
  String get eventDetails_eventOrdersBanner_all {
    return Intl.message(
      'همه',
      name: 'eventDetails_eventOrdersBanner_all',
      desc: '',
      args: [],
    );
  }

  /// `ظرفیت کل: {totalOrders} / مهمانان: {totalGuests}, اعضا: {totalMembers}`
  String eventDetails_eventOrdersBanner_totalCapacity(
    int totalOrders,
    int totalGuests,
    int totalMembers,
  ) {
    return Intl.message(
      'ظرفیت کل: $totalOrders / مهمانان: $totalGuests, اعضا: $totalMembers',
      name: 'eventDetails_eventOrdersBanner_totalCapacity',
      desc: 'Report about capacity',
      args: [totalOrders, totalGuests, totalMembers],
    );
  }

  /// `بدون سفارش`
  String get eventDetails_eventOrdersBanner_notAttended {
    return Intl.message(
      'بدون سفارش',
      name: 'eventDetails_eventOrdersBanner_notAttended',
      desc: '',
      args: [],
    );
  }

  /// `دفتر یادداشت`
  String get eventStory_appBarTitle {
    return Intl.message(
      'دفتر یادداشت',
      name: 'eventStory_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `از اینجا شروع به نوشتن کنید...`
  String get eventStory_writeHere {
    return Intl.message(
      'از اینجا شروع به نوشتن کنید...',
      name: 'eventStory_writeHere',
      desc: '',
      args: [],
    );
  }

  /// `هنوز تراکنشی اضافه نشده است!`
  String get transaction_emptyStateContent {
    return Intl.message(
      'هنوز تراکنشی اضافه نشده است!',
      name: 'transaction_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `هنوز نسبتی اضافه نشده است!`
  String get ratio_emptyStateContent {
    return Intl.message(
      'هنوز نسبتی اضافه نشده است!',
      name: 'ratio_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `هنوز سفارشی اضافه نشده است!`
  String get order_emptyStateContent {
    return Intl.message(
      'هنوز سفارشی اضافه نشده است!',
      name: 'order_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات مهمان`
  String get guestDetails_appBarTitle {
    return Intl.message(
      'جزئیات مهمان',
      name: 'guestDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `مهمانان`
  String get guest_appBarTitle {
    return Intl.message(
      'مهمانان',
      name: 'guest_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز مهمانی اضافه نشده است!`
  String get guest_emptyStateContent {
    return Intl.message(
      'هنوز مهمانی اضافه نشده است!',
      name: 'guest_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش مهمان`
  String get guest_editGuest {
    return Intl.message(
      'ویرایش مهمان',
      name: 'guest_editGuest',
      desc: '',
      args: [],
    );
  }

  /// `افزودن مهمان جدید`
  String get guest_addGuest {
    return Intl.message(
      'افزودن مهمان جدید',
      name: 'guest_addGuest',
      desc: '',
      args: [],
    );
  }

  /// `موارد منو`
  String get menu_appBarTitle {
    return Intl.message(
      'موارد منو',
      name: 'menu_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز موردی اضافه نشده است!`
  String get menu_emptyStateContent {
    return Intl.message(
      'هنوز موردی اضافه نشده است!',
      name: 'menu_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن مورد منو`
  String get menu_addItem {
    return Intl.message(
      'افزودن مورد منو',
      name: 'menu_addItem',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش مورد`
  String get menu_editItem {
    return Intl.message(
      'ویرایش مورد',
      name: 'menu_editItem',
      desc: '',
      args: [],
    );
  }

  /// `رویدادها`
  String get event_appBarTitle {
    return Intl.message(
      'رویدادها',
      name: 'event_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز رویدادی اضافه نشده است!`
  String get event_emptyStateContent {
    return Intl.message(
      'هنوز رویدادی اضافه نشده است!',
      name: 'event_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن رویداد جدید`
  String get event_addEvent {
    return Intl.message(
      'افزودن رویداد جدید',
      name: 'event_addEvent',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش رویداد`
  String get event_editEvent {
    return Intl.message(
      'ویرایش رویداد',
      name: 'event_editEvent',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات گزارش`
  String get reportDetails_appBarTitle {
    return Intl.message(
      'جزئیات گزارش',
      name: 'reportDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `رویدادهای انتخاب‌شده`
  String get reportDetails_selectedEvents {
    return Intl.message(
      'رویدادهای انتخاب‌شده',
      name: 'reportDetails_selectedEvents',
      desc: '',
      args: [],
    );
  }

  /// `این گزارش برای تولید شده است`
  String get reportDetails_reportGeneratedFor {
    return Intl.message(
      'این گزارش برای تولید شده است',
      name: 'reportDetails_reportGeneratedFor',
      desc: '',
      args: [],
    );
  }

  /// `گزارش‌ها`
  String get report_appBarTitle {
    return Intl.message(
      'گزارش‌ها',
      name: 'report_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز گزارشی اضافه نشده است!`
  String get report_emptyStateContent {
    return Intl.message(
      'هنوز گزارشی اضافه نشده است!',
      name: 'report_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `ایجاد گزارش جدید`
  String get report_addReport {
    return Intl.message(
      'ایجاد گزارش جدید',
      name: 'report_addReport',
      desc: '',
      args: [],
    );
  }

  /// `هیچ رویدادی یافت نشد`
  String get report_selectingEvents_noEvent {
    return Intl.message(
      'هیچ رویدادی یافت نشد',
      name: 'report_selectingEvents_noEvent',
      desc: '',
      args: [],
    );
  }

  /// `شرح سند`
  String get journal_description {
    return Intl.message(
      'شرح سند',
      name: 'journal_description',
      desc: '',
      args: [],
    );
  }

  /// `بدهکار`
  String get journal_debit {
    return Intl.message('بدهکار', name: 'journal_debit', desc: '', args: []);
  }

  /// `بستانکار`
  String get journal_credit {
    return Intl.message('بستانکار', name: 'journal_credit', desc: '', args: []);
  }

  /// `حساب معین`
  String get journal_subsidiaryAccount {
    return Intl.message(
      'حساب معین',
      name: 'journal_subsidiaryAccount',
      desc: '',
      args: [],
    );
  }

  /// `تفضیلی ۱`
  String get journal_firstDetailed {
    return Intl.message(
      'تفضیلی ۱',
      name: 'journal_firstDetailed',
      desc: '',
      args: [],
    );
  }

  /// `تفضیلی ۲`
  String get journal_secondDetailed {
    return Intl.message(
      'تفضیلی ۲',
      name: 'journal_secondDetailed',
      desc: '',
      args: [],
    );
  }

  /// `گروه حساب`
  String get journal_accountGroup {
    return Intl.message(
      'گروه حساب',
      name: 'journal_accountGroup',
      desc: '',
      args: [],
    );
  }

  /// `حساب کل`
  String get journal_generalAccount {
    return Intl.message(
      'حساب کل',
      name: 'journal_generalAccount',
      desc: '',
      args: [],
    );
  }

  /// `سریال`
  String get journal_series {
    return Intl.message('سریال', name: 'journal_series', desc: '', args: []);
  }

  /// `هیچ موردی برای نمایش وجود ندارد`
  String get common_noItemToShow {
    return Intl.message(
      'هیچ موردی برای نمایش وجود ندارد',
      name: 'common_noItemToShow',
      desc: '',
      args: [],
    );
  }

  /// `جستجو`
  String get textField_hint_search {
    return Intl.message(
      'جستجو',
      name: 'textField_hint_search',
      desc: '',
      args: [],
    );
  }

  /// `گردش حساب`
  String get balance_appBarTitle {
    return Intl.message(
      'گردش حساب',
      name: 'balance_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هیچ تراکنشی برای این بانک ثبت نشده!`
  String get bankBalance_emptyStateContent {
    return Intl.message(
      'هیچ تراکنشی برای این بانک ثبت نشده!',
      name: 'bankBalance_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `واریز`
  String get bankBalance_deposit {
    return Intl.message(
      'واریز',
      name: 'bankBalance_deposit',
      desc: '',
      args: [],
    );
  }

  /// `برداشت`
  String get bankBalance_withdrawal {
    return Intl.message(
      'برداشت',
      name: 'bankBalance_withdrawal',
      desc: '',
      args: [],
    );
  }

  /// `پاسارگاد`
  String get textField_hint_bankName {
    return Intl.message(
      'پاسارگاد',
      name: 'textField_hint_bankName',
      desc: '',
      args: [],
    );
  }

  /// `موجودی اولیه`
  String get textField_label_openingBalance {
    return Intl.message(
      'موجودی اولیه',
      name: 'textField_label_openingBalance',
      desc: '',
      args: [],
    );
  }

  /// `شماره کارت / حساب`
  String get textField_label_cardOrAccountNumber {
    return Intl.message(
      'شماره کارت / حساب',
      name: 'textField_label_cardOrAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `۶۰۲۱۳۳۲۵۴۲۵۸۳۶۴۸`
  String get textField_hint_cardNumber {
    return Intl.message(
      '۶۰۲۱۳۳۲۵۴۲۵۸۳۶۴۸',
      name: 'textField_hint_cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `هیچ صندوقی ثبت نشده!`
  String get bankBalance_noFundRecorded {
    return Intl.message(
      'هیچ صندوقی ثبت نشده!',
      name: 'bankBalance_noFundRecorded',
      desc: '',
      args: [],
    );
  }

  /// `شماره حساب`
  String get bankBalance_accountNumber {
    return Intl.message(
      'شماره حساب',
      name: 'bankBalance_accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ افتتاحیه`
  String get balance_openingAmount {
    return Intl.message(
      'مبلغ افتتاحیه',
      name: 'balance_openingAmount',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت به`
  String get payTo_label {
    return Intl.message('پرداخت به', name: 'payTo_label', desc: '', args: []);
  }

  /// `مهدیار ارباب زی`
  String get textField_hint_mahdiyarArbabzi {
    return Intl.message(
      'مهدیار ارباب زی',
      name: 'textField_hint_mahdiyarArbabzi',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب طرف حساب`
  String get modalBottom_title_selectCounterparty {
    return Intl.message(
      'انتخاب طرف حساب',
      name: 'modalBottom_title_selectCounterparty',
      desc: '',
      args: [],
    );
  }

  /// `مربوط به رویداد (اختیاری)`
  String get textField_label_relatedEventOptional {
    return Intl.message(
      'مربوط به رویداد (اختیاری)',
      name: 'textField_label_relatedEventOptional',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب رویداد`
  String get modalBottom_title_selectEvent {
    return Intl.message(
      'انتخاب رویداد',
      name: 'modalBottom_title_selectEvent',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت از ذخیره (اختیاری)`
  String get textField_label_payFromFundOptional {
    return Intl.message(
      'پرداخت از ذخیره (اختیاری)',
      name: 'textField_label_payFromFundOptional',
      desc: '',
      args: [],
    );
  }

  /// `تبلیغات`
  String get textField_hint_advertising {
    return Intl.message(
      'تبلیغات',
      name: 'textField_hint_advertising',
      desc: '',
      args: [],
    );
  }

  /// `کارمزد انتقال`
  String get textField_label_transferFee {
    return Intl.message(
      'کارمزد انتقال',
      name: 'textField_label_transferFee',
      desc: '',
      args: [],
    );
  }

  /// `توضیحات سند`
  String get textField_label_journalDescription {
    return Intl.message(
      'توضیحات سند',
      name: 'textField_label_journalDescription',
      desc: '',
      args: [],
    );
  }

  /// `دریافت از`
  String get receiveFrom_label {
    return Intl.message(
      'دریافت از',
      name: 'receiveFrom_label',
      desc: '',
      args: [],
    );
  }

  /// `دریافت به ذخیره (اختیاری)`
  String get textField_label_receiveToFundOptional {
    return Intl.message(
      'دریافت به ذخیره (اختیاری)',
      name: 'textField_label_receiveToFundOptional',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب کیف ذخیره`
  String get modalBottom_title_selectFundWallet {
    return Intl.message(
      'انتخاب کیف ذخیره',
      name: 'modalBottom_title_selectFundWallet',
      desc: '',
      args: [],
    );
  }

  /// `مهمانان`
  String get eventDetails_tab_guests {
    return Intl.message(
      'مهمانان',
      name: 'eventDetails_tab_guests',
      desc: '',
      args: [],
    );
  }

  /// `هزینه ها`
  String get eventDetails_tab_expenses {
    return Intl.message(
      'هزینه ها',
      name: 'eventDetails_tab_expenses',
      desc: '',
      args: [],
    );
  }

  /// `درصدها`
  String get eventDetails_tab_ratios {
    return Intl.message(
      'درصدها',
      name: 'eventDetails_tab_ratios',
      desc: '',
      args: [],
    );
  }

  /// `هیچ هزینه ای ثبت نشده!`
  String get expense_emptyStateContent {
    return Intl.message(
      'هیچ هزینه ای ثبت نشده!',
      name: 'expense_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت از بانک`
  String get expense_paidFromBank {
    return Intl.message(
      'پرداخت از بانک',
      name: 'expense_paidFromBank',
      desc: '',
      args: [],
    );
  }

  /// `واگذاری به حساب`
  String get expense_assignedToAccount {
    return Intl.message(
      'واگذاری به حساب',
      name: 'expense_assignedToAccount',
      desc: '',
      args: [],
    );
  }

  /// `در تاریخ`
  String get expense_onDate {
    return Intl.message('در تاریخ', name: 'expense_onDate', desc: '', args: []);
  }

  /// `کسر از کیف ذخیره`
  String get expense_deductedFromFundWallet {
    return Intl.message(
      'کسر از کیف ذخیره',
      name: 'expense_deductedFromFundWallet',
      desc: '',
      args: [],
    );
  }

  /// `بزودی`
  String get common_comingSoon {
    return Intl.message('بزودی', name: 'common_comingSoon', desc: '', args: []);
  }

  /// `هیچ مهمانی ثبت نام نشده!`
  String get registration_emptyStateContent {
    return Intl.message(
      'هیچ مهمانی ثبت نام نشده!',
      name: 'registration_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `هیچ درصدی از صندوق مشخص نشده!`
  String get sharePartner_noFundRatio {
    return Intl.message(
      'هیچ درصدی از صندوق مشخص نشده!',
      name: 'sharePartner_noFundRatio',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش صندوق`
  String get sharePartner_editFund {
    return Intl.message(
      'ویرایش صندوق',
      name: 'sharePartner_editFund',
      desc: '',
      args: [],
    );
  }

  /// `هیچ درصدی از اعضا مشخص نشده!`
  String get sharePartner_noMemberRatio {
    return Intl.message(
      'هیچ درصدی از اعضا مشخص نشده!',
      name: 'sharePartner_noMemberRatio',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت هزینه رویداد توسط بانک`
  String get button_title_payEventExpenseByBank {
    return Intl.message(
      'پرداخت هزینه رویداد توسط بانک',
      name: 'button_title_payEventExpenseByBank',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت هزینه رویداد توسط اعضا`
  String get button_title_payEventExpenseByStaff {
    return Intl.message(
      'پرداخت هزینه رویداد توسط اعضا',
      name: 'button_title_payEventExpenseByStaff',
      desc: '',
      args: [],
    );
  }

  /// `اضافه کردن درصد جدید`
  String get button_title_addNewRatio {
    return Intl.message(
      'اضافه کردن درصد جدید',
      name: 'button_title_addNewRatio',
      desc: '',
      args: [],
    );
  }

  /// `ثبت نام مهمان`
  String get button_title_registerGuest {
    return Intl.message(
      'ثبت نام مهمان',
      name: 'button_title_registerGuest',
      desc: '',
      args: [],
    );
  }

  /// `میزبان`
  String get eventDetails_host {
    return Intl.message(
      'میزبان',
      name: 'eventDetails_host',
      desc: '',
      args: [],
    );
  }

  /// `برگزاری در روز`
  String get eventDetails_heldOnDay {
    return Intl.message(
      'برگزاری در روز',
      name: 'eventDetails_heldOnDay',
      desc: '',
      args: [],
    );
  }

  /// `تعداد مهمانان`
  String get eventDetails_guestsCount {
    return Intl.message(
      'تعداد مهمانان',
      name: 'eventDetails_guestsCount',
      desc: '',
      args: [],
    );
  }

  /// `درآمد ناخالص`
  String get eventDetails_grossIncome {
    return Intl.message(
      'درآمد ناخالص',
      name: 'eventDetails_grossIncome',
      desc: '',
      args: [],
    );
  }

  /// `تخفیفات`
  String get eventDetails_discounts {
    return Intl.message(
      'تخفیفات',
      name: 'eventDetails_discounts',
      desc: '',
      args: [],
    );
  }

  /// `مانده`
  String get common_balance {
    return Intl.message('مانده', name: 'common_balance', desc: '', args: []);
  }

  /// `صندوق`
  String get fund_label {
    return Intl.message('صندوق', name: 'fund_label', desc: '', args: []);
  }

  /// `انتخاب صندوق`
  String get modalBottom_title_selectFund {
    return Intl.message(
      'انتخاب صندوق',
      name: 'modalBottom_title_selectFund',
      desc: '',
      args: [],
    );
  }

  /// `سرفصل هزینه`
  String get expense_categoryLabel {
    return Intl.message(
      'سرفصل هزینه',
      name: 'expense_categoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `یک گیزینه انتخاب کنید`
  String get dropDownButton_hint_selectOption {
    return Intl.message(
      'یک گیزینه انتخاب کنید',
      name: 'dropDownButton_hint_selectOption',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب سرفصل هزینه`
  String get modalBottom_title_selectExpenseCategory {
    return Intl.message(
      'انتخاب سرفصل هزینه',
      name: 'modalBottom_title_selectExpenseCategory',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ پرداخت`
  String get textField_label_paymentDate {
    return Intl.message(
      'تاریخ پرداخت',
      name: 'textField_label_paymentDate',
      desc: '',
      args: [],
    );
  }

  /// `بانک`
  String get bank_label {
    return Intl.message('بانک', name: 'bank_label', desc: '', args: []);
  }

  /// `انتخاب بانک`
  String get modalBottom_title_selectBank {
    return Intl.message(
      'انتخاب بانک',
      name: 'modalBottom_title_selectBank',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت کننده`
  String get expense_payer {
    return Intl.message(
      'پرداخت کننده',
      name: 'expense_payer',
      desc: '',
      args: [],
    );
  }

  /// `زینب جدیدی`
  String get textField_hint_zeinabJadidi {
    return Intl.message(
      'زینب جدیدی',
      name: 'textField_hint_zeinabJadidi',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب شخص`
  String get modalBottom_title_selectPerson {
    return Intl.message(
      'انتخاب شخص',
      name: 'modalBottom_title_selectPerson',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب اعضا`
  String get modalBottom_title_selectMembers {
    return Intl.message(
      'انتخاب اعضا',
      name: 'modalBottom_title_selectMembers',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب مهمانان این رویداد`
  String get attendGuest_selectGuestsHint {
    return Intl.message(
      'انتخاب مهمانان این رویداد',
      name: 'attendGuest_selectGuestsHint',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب مهمانان`
  String get modalBottom_title_selectGuests {
    return Intl.message(
      'انتخاب مهمانان',
      name: 'modalBottom_title_selectGuests',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ کل بدون تخفیف`
  String get textField_label_grossAmount {
    return Intl.message(
      'مبلغ کل بدون تخفیف',
      name: 'textField_label_grossAmount',
      desc: '',
      args: [],
    );
  }

  /// `تخفیف`
  String get textField_label_discount {
    return Intl.message(
      'تخفیف',
      name: 'textField_label_discount',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ نهایی`
  String get textField_label_finalAmount {
    return Intl.message(
      'مبلغ نهایی',
      name: 'textField_label_finalAmount',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت پرداختی`
  String get attendGuest_paymentStatus {
    return Intl.message(
      'وضعیت پرداختی',
      name: 'attendGuest_paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت تسویه مهمانان`
  String get modalBottom_title_guestSettlementStatus {
    return Intl.message(
      'وضعیت تسویه مهمانان',
      name: 'modalBottom_title_guestSettlementStatus',
      desc: '',
      args: [],
    );
  }

  /// `اشخاص`
  String get dropDownButton_label_persons {
    return Intl.message(
      'اشخاص',
      name: 'dropDownButton_label_persons',
      desc: '',
      args: [],
    );
  }

  /// `کسر هزینه پذیرایی`
  String get attendGuest_cateringDeduction {
    return Intl.message(
      'کسر هزینه پذیرایی',
      name: 'attendGuest_cateringDeduction',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت تسویه حساب پذیرایی`
  String get modalBottom_title_cateringSettlementStatus {
    return Intl.message(
      'وضعیت تسویه حساب پذیرایی',
      name: 'modalBottom_title_cateringSettlementStatus',
      desc: '',
      args: [],
    );
  }

  /// `کیف ذخیره`
  String get fundWallet_label {
    return Intl.message(
      'کیف ذخیره',
      name: 'fundWallet_label',
      desc: '',
      args: [],
    );
  }

  /// `واریز به بانک`
  String get settlementStatus_depositToBank {
    return Intl.message(
      'واریز به بانک',
      name: 'settlementStatus_depositToBank',
      desc: '',
      args: [],
    );
  }

  /// `بستن حساب رویداد`
  String get event_closeEventAccount {
    return Intl.message(
      'بستن حساب رویداد',
      name: 'event_closeEventAccount',
      desc: '',
      args: [],
    );
  }

  /// `بستن حساب`
  String get event_closeAccount {
    return Intl.message(
      'بستن حساب',
      name: 'event_closeAccount',
      desc: '',
      args: [],
    );
  }

  /// `دسترسی به حساب این رویداد`
  String get event_accessEventAccount {
    return Intl.message(
      'دسترسی به حساب این رویداد',
      name: 'event_accessEventAccount',
      desc: '',
      args: [],
    );
  }

  /// `بازگشایی حساب`
  String get event_reopenAccount {
    return Intl.message(
      'بازگشایی حساب',
      name: 'event_reopenAccount',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب تیم`
  String get modalBottom_title_selectTeam {
    return Intl.message(
      'انتخاب تیم',
      name: 'modalBottom_title_selectTeam',
      desc: '',
      args: [],
    );
  }

  /// `میزبان این رویداد رو انتخاب کنید`
  String get event_selectHostHint {
    return Intl.message(
      'میزبان این رویداد رو انتخاب کنید',
      name: 'event_selectHostHint',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب میزبان`
  String get modalBottom_title_selectHost {
    return Intl.message(
      'انتخاب میزبان',
      name: 'modalBottom_title_selectHost',
      desc: '',
      args: [],
    );
  }

  /// `تعداد کلی مهمانان این رویداد`
  String get closeEvent_totalGuests {
    return Intl.message(
      'تعداد کلی مهمانان این رویداد',
      name: 'closeEvent_totalGuests',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ برگزاری`
  String get closeEvent_heldDate {
    return Intl.message(
      'تاریخ برگزاری',
      name: 'closeEvent_heldDate',
      desc: '',
      args: [],
    );
  }

  /// `برگزار کنندگان`
  String get closeEvent_organizers {
    return Intl.message(
      'برگزار کنندگان',
      name: 'closeEvent_organizers',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب برگزار کنندگان این رویداد`
  String get closeEvent_selectOrganizersHint {
    return Intl.message(
      'انتخاب برگزار کنندگان این رویداد',
      name: 'closeEvent_selectOrganizersHint',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب برگزار کنندگان`
  String get modalBottom_title_selectOrganizers {
    return Intl.message(
      'انتخاب برگزار کنندگان',
      name: 'modalBottom_title_selectOrganizers',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ ورودی`
  String get closeEvent_inputAmount {
    return Intl.message(
      'مبلغ ورودی',
      name: 'closeEvent_inputAmount',
      desc: '',
      args: [],
    );
  }

  /// `پذیرایی`
  String get closeEvent_catering {
    return Intl.message(
      'پذیرایی',
      name: 'closeEvent_catering',
      desc: '',
      args: [],
    );
  }

  /// `جمع پذیرایی`
  String get closeEvent_totalCatering {
    return Intl.message(
      'جمع پذیرایی',
      name: 'closeEvent_totalCatering',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ کلی هزینه`
  String get closeEvent_totalExpenseAmount {
    return Intl.message(
      'مبلغ کلی هزینه',
      name: 'closeEvent_totalExpenseAmount',
      desc: '',
      args: [],
    );
  }

  /// `برای انجام این عملیات و باز شدن حساب این رویداد برروی تایید کلیک کنید.`
  String get event_openAccountConfirmation {
    return Intl.message(
      'برای انجام این عملیات و باز شدن حساب این رویداد برروی تایید کلیک کنید.',
      name: 'event_openAccountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `هیچ تراکنشی برای این صندوق ثبت نشده!`
  String get fundBalance_emptyStateContent {
    return Intl.message(
      'هیچ تراکنشی برای این صندوق ثبت نشده!',
      name: 'fundBalance_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `اضافه شده`
  String get fundBalance_added {
    return Intl.message(
      'اضافه شده',
      name: 'fundBalance_added',
      desc: '',
      args: [],
    );
  }

  /// `کسر شده`
  String get fundBalance_deducted {
    return Intl.message(
      'کسر شده',
      name: 'fundBalance_deducted',
      desc: '',
      args: [],
    );
  }

  /// `ذخایر`
  String get fund_appBarTitle {
    return Intl.message('ذخایر', name: 'fund_appBarTitle', desc: '', args: []);
  }

  /// `هنوز هیچ صندوقی اضافه نشده است!`
  String get fund_emptyStateContent {
    return Intl.message(
      'هنوز هیچ صندوقی اضافه نشده است!',
      name: 'fund_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `نام کیف ذخیره`
  String get textField_label_fundWalletName {
    return Intl.message(
      'نام کیف ذخیره',
      name: 'textField_label_fundWalletName',
      desc: '',
      args: [],
    );
  }

  /// `هیچ تراکنشی برای این کاربر ثبت نشده!`
  String get balance_emptyUserTransactions {
    return Intl.message(
      'هیچ تراکنشی برای این کاربر ثبت نشده!',
      name: 'balance_emptyUserTransactions',
      desc: '',
      args: [],
    );
  }

  /// `دریافت نشده`
  String get guestBalance_notReceived {
    return Intl.message(
      'دریافت نشده',
      name: 'guestBalance_notReceived',
      desc: '',
      args: [],
    );
  }

  /// `دریافتی`
  String get guestBalance_received {
    return Intl.message(
      'دریافتی',
      name: 'guestBalance_received',
      desc: '',
      args: [],
    );
  }

  /// `نشان دهنده مقدار طلبی است که باید از شخص دریافت شود.`
  String get guestBalance_creditDescription {
    return Intl.message(
      'نشان دهنده مقدار طلبی است که باید از شخص دریافت شود.',
      name: 'guestBalance_creditDescription',
      desc: '',
      args: [],
    );
  }

  /// `نشان دهنده ی مقدار بدهی است که باید به شخص پرداخت شود.`
  String get guestBalance_debitDescription {
    return Intl.message(
      'نشان دهنده ی مقدار بدهی است که باید به شخص پرداخت شود.',
      name: 'guestBalance_debitDescription',
      desc: '',
      args: [],
    );
  }

  /// `پرداختی`
  String get memberBalance_paid {
    return Intl.message(
      'پرداختی',
      name: 'memberBalance_paid',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت نشده`
  String get memberBalance_notPaid {
    return Intl.message(
      'پرداخت نشده',
      name: 'memberBalance_notPaid',
      desc: '',
      args: [],
    );
  }

  /// `نشان دهنده مقدار طلبی است که میتوان از شخص دریافت کرد.`
  String get memberBalance_creditDescription {
    return Intl.message(
      'نشان دهنده مقدار طلبی است که میتوان از شخص دریافت کرد.',
      name: 'memberBalance_creditDescription',
      desc: '',
      args: [],
    );
  }

  /// `نشان دهنده ی مقدار بدهی است که باید به این شخص پرداخت شود.`
  String get memberBalance_debitDescription {
    return Intl.message(
      'نشان دهنده ی مقدار بدهی است که باید به این شخص پرداخت شود.',
      name: 'memberBalance_debitDescription',
      desc: '',
      args: [],
    );
  }

  /// `میزبانان`
  String get host_appBarTitle {
    return Intl.message(
      'میزبانان',
      name: 'host_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش اطلاعات میزبان`
  String get host_editHost {
    return Intl.message(
      'ویرایش اطلاعات میزبان',
      name: 'host_editHost',
      desc: '',
      args: [],
    );
  }

  /// `اضافه کردن میزبان جدید`
  String get host_addHost {
    return Intl.message(
      'اضافه کردن میزبان جدید',
      name: 'host_addHost',
      desc: '',
      args: [],
    );
  }

  /// `اسناد حسابداری`
  String get header_appBarTitle {
    return Intl.message(
      'اسناد حسابداری',
      name: 'header_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هیچ سندی یافت نشد!`
  String get header_emptyStateContent {
    return Intl.message(
      'هیچ سندی یافت نشد!',
      name: 'header_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `نوع سند`
  String get header_type {
    return Intl.message('نوع سند', name: 'header_type', desc: '', args: []);
  }

  /// `جزییات سند`
  String get journal_appBarTitle {
    return Intl.message(
      'جزییات سند',
      name: 'journal_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `شماره سند`
  String get header_number {
    return Intl.message('شماره سند', name: 'header_number', desc: '', args: []);
  }

  /// `بانک ها`
  String get button_title_banks {
    return Intl.message(
      'بانک ها',
      name: 'button_title_banks',
      desc: '',
      args: [],
    );
  }

  /// `کیف ذخایر`
  String get button_title_funds {
    return Intl.message(
      'کیف ذخایر',
      name: 'button_title_funds',
      desc: '',
      args: [],
    );
  }

  /// `گزارش‌های مدیریتی`
  String get button_title_simpleReports {
    return Intl.message(
      'گزارش‌های مدیریتی',
      name: 'button_title_simpleReports',
      desc: '',
      args: [],
    );
  }

  /// `اسناد`
  String get button_title_journals {
    return Intl.message(
      'اسناد',
      name: 'button_title_journals',
      desc: '',
      args: [],
    );
  }

  /// `خطا در دریافت گزارش!`
  String get report_fetchFailed {
    return Intl.message(
      'خطا در دریافت گزارش!',
      name: 'report_fetchFailed',
      desc: '',
      args: [],
    );
  }

  /// `هیچ ردیفی برای این گزارش یافت نشد!`
  String get report_noRows {
    return Intl.message(
      'هیچ ردیفی برای این گزارش یافت نشد!',
      name: 'report_noRows',
      desc: '',
      args: [],
    );
  }

  /// `از تاریخ`
  String get report_fromDate {
    return Intl.message(
      'از تاریخ',
      name: 'report_fromDate',
      desc: '',
      args: [],
    );
  }

  /// `تا تاریخ`
  String get report_toDate {
    return Intl.message('تا تاریخ', name: 'report_toDate', desc: '', args: []);
  }

  /// `انتخاب حساب معین`
  String get modalBottom_title_selectSubsidiary {
    return Intl.message(
      'انتخاب حساب معین',
      name: 'modalBottom_title_selectSubsidiary',
      desc: '',
      args: [],
    );
  }

  /// `حساب تفصیلی`
  String get report_detailedAccount {
    return Intl.message(
      'حساب تفصیلی',
      name: 'report_detailedAccount',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب حساب تفصیلی`
  String get modalBottom_title_selectDetailed {
    return Intl.message(
      'انتخاب حساب تفصیلی',
      name: 'modalBottom_title_selectDetailed',
      desc: '',
      args: [],
    );
  }

  /// `حذف فیلترها`
  String get report_clearFilters {
    return Intl.message(
      'حذف فیلترها',
      name: 'report_clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `تعداد ردیف‌ها`
  String get report_rowsCount {
    return Intl.message(
      'تعداد ردیف‌ها',
      name: 'report_rowsCount',
      desc: '',
      args: [],
    );
  }

  /// `جمع بدهکار`
  String get report_totalDebit {
    return Intl.message(
      'جمع بدهکار',
      name: 'report_totalDebit',
      desc: '',
      args: [],
    );
  }

  /// `جمع بستانکار`
  String get report_totalCredit {
    return Intl.message(
      'جمع بستانکار',
      name: 'report_totalCredit',
      desc: '',
      args: [],
    );
  }

  /// `جزییات حقوق`
  String get simpleReport_salaryDetails {
    return Intl.message(
      'جزییات حقوق',
      name: 'simpleReport_salaryDetails',
      desc: '',
      args: [],
    );
  }

  /// `جمع حقوق`
  String get simpleReport_totalSalary {
    return Intl.message(
      'جمع حقوق',
      name: 'simpleReport_totalSalary',
      desc: '',
      args: [],
    );
  }

  /// `تعداد رویدادها`
  String get simpleReport_eventsCount {
    return Intl.message(
      'تعداد رویدادها',
      name: 'simpleReport_eventsCount',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت حساب`
  String get simpleReport_accountStatus {
    return Intl.message(
      'وضعیت حساب',
      name: 'simpleReport_accountStatus',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت حساب شامل همه پرداخت‌ها و طلب‌های عضو است، نه فقط حقوق.`
  String get simpleReport_accountStatusNote {
    return Intl.message(
      'وضعیت حساب شامل همه پرداخت‌ها و طلب‌های عضو است، نه فقط حقوق.',
      name: 'simpleReport_accountStatusNote',
      desc: '',
      args: [],
    );
  }

  /// `حقوقی ثبت نشده است!`
  String get simpleReport_noSalary {
    return Intl.message(
      'حقوقی ثبت نشده است!',
      name: 'simpleReport_noSalary',
      desc: '',
      args: [],
    );
  }

  /// `بدون رویداد`
  String get simpleReport_noEvent {
    return Intl.message(
      'بدون رویداد',
      name: 'simpleReport_noEvent',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ حقوق`
  String get simpleReport_salaryAmount {
    return Intl.message(
      'مبلغ حقوق',
      name: 'simpleReport_salaryAmount',
      desc: '',
      args: [],
    );
  }

  /// `حقوق اعضا`
  String get simpleReport_memberSalaries {
    return Intl.message(
      'حقوق اعضا',
      name: 'simpleReport_memberSalaries',
      desc: '',
      args: [],
    );
  }

  /// `جمع حقوق همه اعضا`
  String get simpleReport_totalAllSalaries {
    return Intl.message(
      'جمع حقوق همه اعضا',
      name: 'simpleReport_totalAllSalaries',
      desc: '',
      args: [],
    );
  }

  /// `تعداد اعضا`
  String get simpleReport_membersCount {
    return Intl.message(
      'تعداد اعضا',
      name: 'simpleReport_membersCount',
      desc: '',
      args: [],
    );
  }

  /// `در این بازه حقوقی ثبت نشده است!`
  String get simpleReport_noSalaryInRange {
    return Intl.message(
      'در این بازه حقوقی ثبت نشده است!',
      name: 'simpleReport_noSalaryInRange',
      desc: '',
      args: [],
    );
  }

  /// `حقوق هر عضو از رویدادها و وضعیت حساب او`
  String get simpleReport_salaryDescription {
    return Intl.message(
      'حقوق هر عضو از رویدادها و وضعیت حساب او',
      name: 'simpleReport_salaryDescription',
      desc: '',
      args: [],
    );
  }

  /// `گزارشی برای نمایش وجود ندارد!`
  String get simpleReport_empty {
    return Intl.message(
      'گزارشی برای نمایش وجود ندارد!',
      name: 'simpleReport_empty',
      desc: '',
      args: [],
    );
  }

  /// `تسویه شده`
  String get balance_settled {
    return Intl.message(
      'تسویه شده',
      name: 'balance_settled',
      desc: '',
      args: [],
    );
  }

  /// `همه رویدادها`
  String get simpleReport_allEvents {
    return Intl.message(
      'همه رویدادها',
      name: 'simpleReport_allEvents',
      desc: '',
      args: [],
    );
  }

  /// `هنوز صندوقی اضافه نشده است!`
  String get teamDetails_noFundAdded {
    return Intl.message(
      'هنوز صندوقی اضافه نشده است!',
      name: 'teamDetails_noFundAdded',
      desc: '',
      args: [],
    );
  }

  /// `اضافه کردن صندوق`
  String get teamDetails_addFund {
    return Intl.message(
      'اضافه کردن صندوق',
      name: 'teamDetails_addFund',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب صندوق ذخیره`
  String get modalBottom_title_selectReserveFund {
    return Intl.message(
      'انتخاب صندوق ذخیره',
      name: 'modalBottom_title_selectReserveFund',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت از {name}`
  String bankBalance_payFrom(String name) {
    return Intl.message(
      'پرداخت از $name',
      name: 'bankBalance_payFrom',
      desc: '',
      args: [name],
    );
  }

  /// `پرداخت به {name}`
  String bankBalance_payTo(String name) {
    return Intl.message(
      'پرداخت به $name',
      name: 'bankBalance_payTo',
      desc: '',
      args: [name],
    );
  }

  /// `{count} مهمان انتخاب شده`
  String attendGuest_selectedGuestsCount(int count) {
    return Intl.message(
      '$count مهمان انتخاب شده',
      name: 'attendGuest_selectedGuestsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count} عضو انتخاب شده`
  String closeEvent_selectedMembersCount(int count) {
    return Intl.message(
      '$count عضو انتخاب شده',
      name: 'closeEvent_selectedMembersCount',
      desc: '',
      args: [count],
    );
  }

  /// `به گروه بدهکار است: {amount}`
  String balance_owesGroup(String amount) {
    return Intl.message(
      'به گروه بدهکار است: $amount',
      name: 'balance_owesGroup',
      desc: '',
      args: [amount],
    );
  }

  /// `از گروه طلب دارد: {amount}`
  String balance_groupOwes(String amount) {
    return Intl.message(
      'از گروه طلب دارد: $amount',
      name: 'balance_groupOwes',
      desc: '',
      args: [amount],
    );
  }

  /// `دارایی‌ها`
  String get accountGroup_assets {
    return Intl.message(
      'دارایی‌ها',
      name: 'accountGroup_assets',
      desc: '',
      args: [],
    );
  }

  /// `بدهی‌ها`
  String get accountGroup_liabilities {
    return Intl.message(
      'بدهی‌ها',
      name: 'accountGroup_liabilities',
      desc: '',
      args: [],
    );
  }

  /// `سرمایه`
  String get accountGroup_equity {
    return Intl.message(
      'سرمایه',
      name: 'accountGroup_equity',
      desc: '',
      args: [],
    );
  }

  /// `درآمدها`
  String get accountGroup_revenues {
    return Intl.message(
      'درآمدها',
      name: 'accountGroup_revenues',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌ها`
  String get accountGroup_expenses {
    return Intl.message(
      'هزینه‌ها',
      name: 'accountGroup_expenses',
      desc: '',
      args: [],
    );
  }

  /// `نقد و بانک`
  String get generalAccount_cashAndBank {
    return Intl.message(
      'نقد و بانک',
      name: 'generalAccount_cashAndBank',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های دریافتنی`
  String get generalAccount_accountsReceivable {
    return Intl.message(
      'حساب‌های دریافتنی',
      name: 'generalAccount_accountsReceivable',
      desc: '',
      args: [],
    );
  }

  /// `پیش پرداخت هزینه ها`
  String get generalAccount_prepaidExpenses {
    return Intl.message(
      'پیش پرداخت هزینه ها',
      name: 'generalAccount_prepaidExpenses',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های پرداختنی`
  String get generalAccount_accountsPayable {
    return Intl.message(
      'حساب‌های پرداختنی',
      name: 'generalAccount_accountsPayable',
      desc: '',
      args: [],
    );
  }

  /// `حقوق صاحبان سهام`
  String get generalAccount_ownerEquity {
    return Intl.message(
      'حقوق صاحبان سهام',
      name: 'generalAccount_ownerEquity',
      desc: '',
      args: [],
    );
  }

  /// `تراز افتتاحیه و اختتامیه`
  String get generalAccount_openingAndClosingBalances {
    return Intl.message(
      'تراز افتتاحیه و اختتامیه',
      name: 'generalAccount_openingAndClosingBalances',
      desc: '',
      args: [],
    );
  }

  /// `درآمد حاصل از ایونت‌ها`
  String get generalAccount_eventRevenueGroup {
    return Intl.message(
      'درآمد حاصل از ایونت‌ها',
      name: 'generalAccount_eventRevenueGroup',
      desc: '',
      args: [],
    );
  }

  /// `کاهنده درآمد`
  String get generalAccount_contraRevenue {
    return Intl.message(
      'کاهنده درآمد',
      name: 'generalAccount_contraRevenue',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های مستقیم ایونت‌ها`
  String get generalAccount_eventExpenses {
    return Intl.message(
      'هزینه‌های مستقیم ایونت‌ها',
      name: 'generalAccount_eventExpenses',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های عمومی و اداری`
  String get generalAccount_otherExpense {
    return Intl.message(
      'هزینه‌های عمومی و اداری',
      name: 'generalAccount_otherExpense',
      desc: '',
      args: [],
    );
  }

  /// `صندوق‌ها`
  String get subsidiaryAccount_cash {
    return Intl.message(
      'صندوق‌ها',
      name: 'subsidiaryAccount_cash',
      desc: '',
      args: [],
    );
  }

  /// `بانک‌ها`
  String get subsidiaryAccount_bank {
    return Intl.message(
      'بانک‌ها',
      name: 'subsidiaryAccount_bank',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های معین مهمانان (بدهکاران)`
  String get subsidiaryAccount_guestReceivables {
    return Intl.message(
      'حساب‌های معین مهمانان (بدهکاران)',
      name: 'subsidiaryAccount_guestReceivables',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های معین سایر (بدهکاران)`
  String get subsidiaryAccount_otherReceivables {
    return Intl.message(
      'حساب‌های معین سایر (بدهکاران)',
      name: 'subsidiaryAccount_otherReceivables',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های معین بستانکاران`
  String get subsidiaryAccount_accountsPayable {
    return Intl.message(
      'حساب‌های معین بستانکاران',
      name: 'subsidiaryAccount_accountsPayable',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های معین مالیات پرداختنی`
  String get subsidiaryAccount_taxPayable {
    return Intl.message(
      'حساب‌های معین مالیات پرداختنی',
      name: 'subsidiaryAccount_taxPayable',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های معین سایر (بستانکاران)`
  String get subsidiaryAccount_otherPayables {
    return Intl.message(
      'حساب‌های معین سایر (بستانکاران)',
      name: 'subsidiaryAccount_otherPayables',
      desc: '',
      args: [],
    );
  }

  /// `حساب‌های معین اعضا و شرکا`
  String get subsidiaryAccount_partnerEquity {
    return Intl.message(
      'حساب‌های معین اعضا و شرکا',
      name: 'subsidiaryAccount_partnerEquity',
      desc: '',
      args: [],
    );
  }

  /// `تراز افتتاحیه`
  String get subsidiaryAccount_openingBalance {
    return Intl.message(
      'تراز افتتاحیه',
      name: 'subsidiaryAccount_openingBalance',
      desc: '',
      args: [],
    );
  }

  /// `تراز اختتامیه`
  String get subsidiaryAccount_closingBalance {
    return Intl.message(
      'تراز اختتامیه',
      name: 'subsidiaryAccount_closingBalance',
      desc: '',
      args: [],
    );
  }

  /// `درآمد مستقیم از ایونت‌ها`
  String get subsidiaryAccount_eventRevenue {
    return Intl.message(
      'درآمد مستقیم از ایونت‌ها',
      name: 'subsidiaryAccount_eventRevenue',
      desc: '',
      args: [],
    );
  }

  /// `درآمد حاصل از اسپانسرشیپ`
  String get subsidiaryAccount_sponsorshipRevenue {
    return Intl.message(
      'درآمد حاصل از اسپانسرشیپ',
      name: 'subsidiaryAccount_sponsorshipRevenue',
      desc: '',
      args: [],
    );
  }

  /// `سایر درآمدها`
  String get subsidiaryAccount_otherRevenue {
    return Intl.message(
      'سایر درآمدها',
      name: 'subsidiaryAccount_otherRevenue',
      desc: '',
      args: [],
    );
  }

  /// `تخفیفات ایونت`
  String get subsidiaryAccount_saleDiscounts {
    return Intl.message(
      'تخفیفات ایونت',
      name: 'subsidiaryAccount_saleDiscounts',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های ورودی`
  String get subsidiaryAccount_entranceExpenses {
    return Intl.message(
      'هزینه‌های ورودی',
      name: 'subsidiaryAccount_entranceExpenses',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های پذیرایی`
  String get subsidiaryAccount_snacksExpenses {
    return Intl.message(
      'هزینه‌های پذیرایی',
      name: 'subsidiaryAccount_snacksExpenses',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های حقوق و دستمزد`
  String get subsidiaryAccount_salaryExpense {
    return Intl.message(
      'هزینه‌های حقوق و دستمزد',
      name: 'subsidiaryAccount_salaryExpense',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های تبلیغات`
  String get subsidiaryAccount_adsExpenses {
    return Intl.message(
      'هزینه‌های تبلیغات',
      name: 'subsidiaryAccount_adsExpenses',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های کارمزد بانکی`
  String get subsidiaryAccount_feeExpenses {
    return Intl.message(
      'هزینه‌های کارمزد بانکی',
      name: 'subsidiaryAccount_feeExpenses',
      desc: '',
      args: [],
    );
  }

  /// `سایر هزینه‌ها`
  String get subsidiaryAccount_otherExpenses {
    return Intl.message(
      'سایر هزینه‌ها',
      name: 'subsidiaryAccount_otherExpenses',
      desc: '',
      args: [],
    );
  }

  /// `سود این رویداد`
  String get snacksAssignment_unassign {
    return Intl.message(
      'سود این رویداد',
      name: 'snacksAssignment_unassign',
      desc: '',
      args: [],
    );
  }

  /// `از حساب پرسنلی`
  String get snacksAssignment_assignmentToStaff {
    return Intl.message(
      'از حساب پرسنلی',
      name: 'snacksAssignment_assignmentToStaff',
      desc: '',
      args: [],
    );
  }

  /// `از کیف ذخیره`
  String get snacksAssignment_assignmentToFund {
    return Intl.message(
      'از کیف ذخیره',
      name: 'snacksAssignment_assignmentToFund',
      desc: '',
      args: [],
    );
  }

  /// `عادی`
  String get journalType_normal {
    return Intl.message('عادی', name: 'journalType_normal', desc: '', args: []);
  }

  /// `افتتاحیه`
  String get journalType_opening {
    return Intl.message(
      'افتتاحیه',
      name: 'journalType_opening',
      desc: '',
      args: [],
    );
  }

  /// `اختتامیه`
  String get journalType_closing {
    return Intl.message(
      'اختتامیه',
      name: 'journalType_closing',
      desc: '',
      args: [],
    );
  }

  /// `بی حساب`
  String get common_noBalance {
    return Intl.message(
      'بی حساب',
      name: 'common_noBalance',
      desc: '',
      args: [],
    );
  }

  /// `مشکلی پیش آمده است!`
  String get error_generic {
    return Intl.message(
      'مشکلی پیش آمده است!',
      name: 'error_generic',
      desc: '',
      args: [],
    );
  }

  /// `نام {name} تکراری است، نام دیگری ثبت کنید.`
  String error_duplicateName(String name) {
    return Intl.message(
      'نام $name تکراری است، نام دیگری ثبت کنید.',
      name: 'error_duplicateName',
      desc: '',
      args: [name],
    );
  }

  /// `عدم تراز سند: مجموع بدهکار ({totalDebit}) با بستانکار ({totalCredit}) برابر نیست.`
  String error_journalUnbalanced(String totalDebit, String totalCredit) {
    return Intl.message(
      'عدم تراز سند: مجموع بدهکار ($totalDebit) با بستانکار ($totalCredit) برابر نیست.',
      name: 'error_journalUnbalanced',
      desc: '',
      args: [totalDebit, totalCredit],
    );
  }

  /// `سند مورد نظر پیدا نشد!`
  String get error_journalNotFound {
    return Intl.message(
      'سند مورد نظر پیدا نشد!',
      name: 'error_journalNotFound',
      desc: '',
      args: [],
    );
  }

  /// `مشخصات کاربر نمیتواند خالی باشد!`
  String get error_userInfoRequired {
    return Intl.message(
      'مشخصات کاربر نمیتواند خالی باشد!',
      name: 'error_userInfoRequired',
      desc: '',
      args: [],
    );
  }

  /// `مشخصات بانک نمیتواند خالی باشد!`
  String get error_bankInfoRequired {
    return Intl.message(
      'مشخصات بانک نمیتواند خالی باشد!',
      name: 'error_bankInfoRequired',
      desc: '',
      args: [],
    );
  }

  /// `گردش حساب`
  String get guestBalance_tab_account {
    return Intl.message(
      'گردش حساب',
      name: 'guestBalance_tab_account',
      desc: '',
      args: [],
    );
  }

  /// `رویدادها`
  String get guestBalance_tab_events {
    return Intl.message(
      'رویدادها',
      name: 'guestBalance_tab_events',
      desc: '',
      args: [],
    );
  }

  /// `تعداد رویداد`
  String get guestBalance_eventsCount {
    return Intl.message(
      'تعداد رویداد',
      name: 'guestBalance_eventsCount',
      desc: '',
      args: [],
    );
  }

  /// `جمع تخفیف`
  String get guestBalance_totalDiscount {
    return Intl.message(
      'جمع تخفیف',
      name: 'guestBalance_totalDiscount',
      desc: '',
      args: [],
    );
  }

  /// `جمع مبلغ کل`
  String get guestBalance_totalGross {
    return Intl.message(
      'جمع مبلغ کل',
      name: 'guestBalance_totalGross',
      desc: '',
      args: [],
    );
  }

  /// `جمع مبلغ نهایی`
  String get guestBalance_totalNet {
    return Intl.message(
      'جمع مبلغ نهایی',
      name: 'guestBalance_totalNet',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ نهایی`
  String get guestBalance_netAmount {
    return Intl.message(
      'مبلغ نهایی',
      name: 'guestBalance_netAmount',
      desc: '',
      args: [],
    );
  }

  /// `حاضر`
  String get guestBalance_present {
    return Intl.message(
      'حاضر',
      name: 'guestBalance_present',
      desc: '',
      args: [],
    );
  }

  /// `غایب`
  String get guestBalance_absent {
    return Intl.message(
      'غایب',
      name: 'guestBalance_absent',
      desc: '',
      args: [],
    );
  }

  /// `این مهمان در هیچ رویدادی ثبت‌نام نکرده!`
  String get guestBalance_emptyEvents {
    return Intl.message(
      'این مهمان در هیچ رویدادی ثبت‌نام نکرده!',
      name: 'guestBalance_emptyEvents',
      desc: '',
      args: [],
    );
  }

  /// `در انتظار`
  String get registrationStatus_pending {
    return Intl.message(
      'در انتظار',
      name: 'registrationStatus_pending',
      desc: '',
      args: [],
    );
  }

  /// `تأیید شده`
  String get registrationStatus_confirmed {
    return Intl.message(
      'تأیید شده',
      name: 'registrationStatus_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `لغو شده`
  String get registrationStatus_cancelled {
    return Intl.message(
      'لغو شده',
      name: 'registrationStatus_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `{count} رویداد انتخاب شده`
  String guestBalance_selectedCount(int count) {
    return Intl.message(
      '$count رویداد انتخاب شده',
      name: 'guestBalance_selectedCount',
      desc: '',
      args: [count],
    );
  }

  /// `لغو انتخاب`
  String get guestBalance_clearSelection {
    return Intl.message(
      'لغو انتخاب',
      name: 'guestBalance_clearSelection',
      desc: '',
      args: [],
    );
  }

  /// `ابزارهای حسابداری`
  String get button_title_accountingTools {
    return Intl.message(
      'ابزارهای حسابداری',
      name: 'button_title_accountingTools',
      desc: '',
      args: [],
    );
  }

  /// `افراد`
  String get mainMenu_people {
    return Intl.message('افراد', name: 'mainMenu_people', desc: '', args: []);
  }

  /// `مالی`
  String get mainMenu_money {
    return Intl.message('مالی', name: 'mainMenu_money', desc: '', args: []);
  }

  /// `گزارش‌ها`
  String get mainMenu_reports {
    return Intl.message(
      'گزارش‌ها',
      name: 'mainMenu_reports',
      desc: '',
      args: [],
    );
  }

  /// `اطلاعات پایه`
  String get mainMenu_basicData {
    return Intl.message(
      'اطلاعات پایه',
      name: 'mainMenu_basicData',
      desc: '',
      args: [],
    );
  }

  /// `ثبت‌نام‌ها، هزینه‌ها و تسویه‌ها`
  String get mainMenu_eventsSubtitle {
    return Intl.message(
      'ثبت‌نام‌ها، هزینه‌ها و تسویه‌ها',
      name: 'mainMenu_eventsSubtitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
