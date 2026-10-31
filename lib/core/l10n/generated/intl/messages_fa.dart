// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fa locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fa';

  static String m0(count) => "${count} مهمان انتخاب شده";

  static String m1(amount) => "از گروه طلب دارد: ${amount}";

  static String m2(amount) => "به گروه بدهکار است: ${amount}";

  static String m3(name) => "پرداخت از ${name}";

  static String m4(name) => "پرداخت به ${name}";

  static String m5(count) => "${count} عضو انتخاب شده";

  static String m6(name) => "نام ${name} تکراری است، نام دیگری ثبت کنید.";

  static String m7(totalDebit, totalCredit) =>
      "عدم تراز سند: مجموع بدهکار (${totalDebit}) با بستانکار (${totalCredit}) برابر نیست.";

  static String m8(totalOrders, totalGuests, totalMembers) =>
      "ظرفیت کل: ${totalOrders} / مهمانان: ${totalGuests}, اعضا: ${totalMembers}";

  static String m9(ratio) => "• نسبت نمی‌تواند بیشتر از ${ratio} باشد";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountGroup_assets": MessageLookupByLibrary.simpleMessage("دارایی‌ها"),
    "accountGroup_equity": MessageLookupByLibrary.simpleMessage("سرمایه"),
    "accountGroup_expenses": MessageLookupByLibrary.simpleMessage("هزینه‌ها"),
    "accountGroup_liabilities": MessageLookupByLibrary.simpleMessage("بدهی‌ها"),
    "accountGroup_revenues": MessageLookupByLibrary.simpleMessage("درآمدها"),
    "alertDialog_areYouSure": MessageLookupByLibrary.simpleMessage(
      "درباره انجام این عملیات اطمینان دارید؟",
    ),
    "alertDialog_discardChanges": MessageLookupByLibrary.simpleMessage(
      "در صورت تایید تغییرات اعمال شده ذخیره نخواهد شد!",
    ),
    "alertDialog_noticeThisAboutAction": MessageLookupByLibrary.simpleMessage(
      "توجه کنید که در صورت حذف این آیتم، تمامی اطلاعات مربوط به این آیتم هم به صورت اتوماتیک حذف خواهد شد.",
    ),
    "attendGuest_cateringDeduction": MessageLookupByLibrary.simpleMessage(
      "کسر هزینه پذیرایی",
    ),
    "attendGuest_paymentStatus": MessageLookupByLibrary.simpleMessage(
      "وضعیت پرداختی",
    ),
    "attendGuest_selectGuestsHint": MessageLookupByLibrary.simpleMessage(
      "انتخاب مهمانان این رویداد",
    ),
    "attendGuest_selectedGuestsCount": m0,
    "balance_appBarTitle": MessageLookupByLibrary.simpleMessage("گردش حساب"),
    "balance_emptyUserTransactions": MessageLookupByLibrary.simpleMessage(
      "هیچ تراکنشی برای این کاربر ثبت نشده!",
    ),
    "balance_groupOwes": m1,
    "balance_openingAmount": MessageLookupByLibrary.simpleMessage(
      "مبلغ افتتاحیه",
    ),
    "balance_owesGroup": m2,
    "balance_settled": MessageLookupByLibrary.simpleMessage("تسویه شده"),
    "bankBalance_accountNumber": MessageLookupByLibrary.simpleMessage(
      "شماره حساب",
    ),
    "bankBalance_deposit": MessageLookupByLibrary.simpleMessage("واریز"),
    "bankBalance_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هیچ تراکنشی برای این بانک ثبت نشده!",
    ),
    "bankBalance_noFundRecorded": MessageLookupByLibrary.simpleMessage(
      "هیچ صندوقی ثبت نشده!",
    ),
    "bankBalance_payFrom": m3,
    "bankBalance_payTo": m4,
    "bankBalance_withdrawal": MessageLookupByLibrary.simpleMessage("برداشت"),
    "bank_label": MessageLookupByLibrary.simpleMessage("بانک"),
    "button_title_addNewRatio": MessageLookupByLibrary.simpleMessage(
      "اضافه کردن درصد جدید",
    ),
    "button_title_backToLogin": MessageLookupByLibrary.simpleMessage(
      "بازگشت به ورود",
    ),
    "button_title_backup": MessageLookupByLibrary.simpleMessage(
      "تولید پشتیبان",
    ),
    "button_title_banks": MessageLookupByLibrary.simpleMessage("بانک ها"),
    "button_title_cancel": MessageLookupByLibrary.simpleMessage("انصراف"),
    "button_title_changeLanguage": MessageLookupByLibrary.simpleMessage(
      "تغییر زبان",
    ),
    "button_title_delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "button_title_edit": MessageLookupByLibrary.simpleMessage("ویرایش"),
    "button_title_events": MessageLookupByLibrary.simpleMessage("رویدادها"),
    "button_title_funds": MessageLookupByLibrary.simpleMessage("کیف ذخایر"),
    "button_title_generate": MessageLookupByLibrary.simpleMessage("تولید"),
    "button_title_guests": MessageLookupByLibrary.simpleMessage("مهمانان"),
    "button_title_journals": MessageLookupByLibrary.simpleMessage("اسناد"),
    "button_title_login": MessageLookupByLibrary.simpleMessage("ورود"),
    "button_title_members": MessageLookupByLibrary.simpleMessage("اعضا"),
    "button_title_menuItems": MessageLookupByLibrary.simpleMessage("منو"),
    "button_title_next": MessageLookupByLibrary.simpleMessage("بعدی"),
    "button_title_offlineMode": MessageLookupByLibrary.simpleMessage(
      "حالت آفلاین",
    ),
    "button_title_onlineMode": MessageLookupByLibrary.simpleMessage(
      "حالت آنلاین",
    ),
    "button_title_payEventExpenseByBank": MessageLookupByLibrary.simpleMessage(
      "پرداخت هزینه رویداد توسط بانک",
    ),
    "button_title_payEventExpenseByStaff": MessageLookupByLibrary.simpleMessage(
      "پرداخت هزینه رویداد توسط اعضا",
    ),
    "button_title_preview": MessageLookupByLibrary.simpleMessage("پیش‌نمایش"),
    "button_title_previous": MessageLookupByLibrary.simpleMessage("قبلی"),
    "button_title_register": MessageLookupByLibrary.simpleMessage("ثبت‌نام"),
    "button_title_registerGuest": MessageLookupByLibrary.simpleMessage(
      "ثبت نام مهمان",
    ),
    "button_title_reports": MessageLookupByLibrary.simpleMessage("گزارش‌ها"),
    "button_title_restore": MessageLookupByLibrary.simpleMessage(
      "بازیابی داده",
    ),
    "button_title_salaryReport": MessageLookupByLibrary.simpleMessage(
      "گزارش حقوق",
    ),
    "button_title_settings": MessageLookupByLibrary.simpleMessage("تنظیمات"),
    "button_title_simpleReports": MessageLookupByLibrary.simpleMessage(
      "گزارش‌های ساده",
    ),
    "button_title_submit": MessageLookupByLibrary.simpleMessage("تایید"),
    "button_title_switchToOfflineMode": MessageLookupByLibrary.simpleMessage(
      "تغییر به حالت آفلاین",
    ),
    "button_title_teamMember": MessageLookupByLibrary.simpleMessage(
      "اعضای تیم",
    ),
    "button_title_teams": MessageLookupByLibrary.simpleMessage("تیم ها"),
    "button_title_today": MessageLookupByLibrary.simpleMessage("امروز"),
    "closeEvent_catering": MessageLookupByLibrary.simpleMessage("پذیرایی"),
    "closeEvent_heldDate": MessageLookupByLibrary.simpleMessage(
      "تاریخ برگزاری",
    ),
    "closeEvent_inputAmount": MessageLookupByLibrary.simpleMessage(
      "مبلغ ورودی",
    ),
    "closeEvent_organizers": MessageLookupByLibrary.simpleMessage(
      "برگزار کنندگان",
    ),
    "closeEvent_selectOrganizersHint": MessageLookupByLibrary.simpleMessage(
      "انتخاب برگزار کنندگان این رویداد",
    ),
    "closeEvent_selectedMembersCount": m5,
    "closeEvent_totalCatering": MessageLookupByLibrary.simpleMessage(
      "جمع پذیرایی",
    ),
    "closeEvent_totalExpenseAmount": MessageLookupByLibrary.simpleMessage(
      "مبلغ کلی هزینه",
    ),
    "closeEvent_totalGuests": MessageLookupByLibrary.simpleMessage(
      "تعداد کلی مهمانان این رویداد",
    ),
    "common_balance": MessageLookupByLibrary.simpleMessage("مانده"),
    "common_comingSoon": MessageLookupByLibrary.simpleMessage("بزودی"),
    "common_noBalance": MessageLookupByLibrary.simpleMessage("بی حساب"),
    "common_noItemToShow": MessageLookupByLibrary.simpleMessage(
      "هیچ موردی برای نمایش وجود ندارد",
    ),
    "contentTitle_active": MessageLookupByLibrary.simpleMessage("فعال: "),
    "contentTitle_balance": MessageLookupByLibrary.simpleMessage("مانده: "),
    "contentTitle_birthday": MessageLookupByLibrary.simpleMessage(
      "تاریخ تولد: ",
    ),
    "contentTitle_byWho": MessageLookupByLibrary.simpleMessage("توسط "),
    "contentTitle_date": MessageLookupByLibrary.simpleMessage("تاریخ: "),
    "contentTitle_description": MessageLookupByLibrary.simpleMessage(
      "توضیحات: ",
    ),
    "contentTitle_engagedTeam": MessageLookupByLibrary.simpleMessage(
      "تیم درگیر: ",
    ),
    "contentTitle_expense": MessageLookupByLibrary.simpleMessage("هزینه "),
    "contentTitle_income": MessageLookupByLibrary.simpleMessage("درآمد "),
    "contentTitle_instagram": MessageLookupByLibrary.simpleMessage(
      "آی‌دی اینستاگرام: ",
    ),
    "contentTitle_joinAt": MessageLookupByLibrary.simpleMessage(
      "تاریخ عضویت: ",
    ),
    "contentTitle_onDate": MessageLookupByLibrary.simpleMessage("در "),
    "contentTitle_paidExpenses": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های پرداخت‌شده ",
    ),
    "contentTitle_phone": MessageLookupByLibrary.simpleMessage("تلفن: "),
    "contentTitle_salary": MessageLookupByLibrary.simpleMessage("حقوق "),
    "contentTitle_telegram": MessageLookupByLibrary.simpleMessage(
      "آی‌دی تلگرام: ",
    ),
    "contentTitle_totalExpense": MessageLookupByLibrary.simpleMessage(
      "کل هزینه: ",
    ),
    "contentTitle_totalIncome": MessageLookupByLibrary.simpleMessage(
      "کل درآمد: ",
    ),
    "contentTitle_unknown": MessageLookupByLibrary.simpleMessage("نامشخص"),
    "contentTitle_unpaid": MessageLookupByLibrary.simpleMessage("پرداخت‌نشده"),
    "dropDownButton_hint_selectGuest": MessageLookupByLibrary.simpleMessage(
      "یک مهمان انتخاب کنید",
    ),
    "dropDownButton_hint_selectItem": MessageLookupByLibrary.simpleMessage(
      "یک آیتم انتخاب کنید",
    ),
    "dropDownButton_hint_selectMember": MessageLookupByLibrary.simpleMessage(
      "یک عضو انتخاب کنید",
    ),
    "dropDownButton_hint_selectOption": MessageLookupByLibrary.simpleMessage(
      "یک گیزینه انتخاب کنید",
    ),
    "dropDownButton_hint_selectTeam": MessageLookupByLibrary.simpleMessage(
      "یک تیم انتخاب کنید",
    ),
    "dropDownButton_hint_selectType": MessageLookupByLibrary.simpleMessage(
      "یک نوع انتخاب کنید",
    ),
    "dropDownButton_label_guests": MessageLookupByLibrary.simpleMessage(
      "مهمانان",
    ),
    "dropDownButton_label_members": MessageLookupByLibrary.simpleMessage(
      "اعضا",
    ),
    "dropDownButton_label_persons": MessageLookupByLibrary.simpleMessage(
      "اشخاص",
    ),
    "dropDownButton_label_teams": MessageLookupByLibrary.simpleMessage(
      "تیم‌ها",
    ),
    "dropDownButton_label_transactionType":
        MessageLookupByLibrary.simpleMessage("نوع تراکنش"),
    "error_bankInfoRequired": MessageLookupByLibrary.simpleMessage(
      "مشخصات بانک نمیتواند خالی باشد!",
    ),
    "error_duplicateName": m6,
    "error_generic": MessageLookupByLibrary.simpleMessage(
      "مشکلی پیش آمده است!",
    ),
    "error_journalNotFound": MessageLookupByLibrary.simpleMessage(
      "سند مورد نظر پیدا نشد!",
    ),
    "error_journalUnbalanced": m7,
    "error_userInfoRequired": MessageLookupByLibrary.simpleMessage(
      "مشخصات کاربر نمیتواند خالی باشد!",
    ),
    "eventDetails_addEventOrder": MessageLookupByLibrary.simpleMessage(
      "افزودن سفارش جدید",
    ),
    "eventDetails_addEventRatio": MessageLookupByLibrary.simpleMessage(
      "افزودن نسبت عضو جدید",
    ),
    "eventDetails_addEventTransaction": MessageLookupByLibrary.simpleMessage(
      "افزودن تراکنش جدید",
    ),
    "eventDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات رویداد",
    ),
    "eventDetails_discounts": MessageLookupByLibrary.simpleMessage("تخفیفات"),
    "eventDetails_editEventOrder": MessageLookupByLibrary.simpleMessage(
      "ویرایش سفارش",
    ),
    "eventDetails_editEventRatio": MessageLookupByLibrary.simpleMessage(
      "ویرایش نسبت",
    ),
    "eventDetails_editEventTransaction": MessageLookupByLibrary.simpleMessage(
      "ویرایش تراکنش",
    ),
    "eventDetails_eventOrdersBanner_all": MessageLookupByLibrary.simpleMessage(
      "همه",
    ),
    "eventDetails_eventOrdersBanner_notAttended":
        MessageLookupByLibrary.simpleMessage("بدون سفارش"),
    "eventDetails_eventOrdersBanner_totalCapacity": m8,
    "eventDetails_grossIncome": MessageLookupByLibrary.simpleMessage(
      "درآمد ناخالص",
    ),
    "eventDetails_guestsCount": MessageLookupByLibrary.simpleMessage(
      "تعداد مهمانان",
    ),
    "eventDetails_heldOnDay": MessageLookupByLibrary.simpleMessage(
      "برگزاری در روز",
    ),
    "eventDetails_host": MessageLookupByLibrary.simpleMessage("میزبان"),
    "eventDetails_orderBy": MessageLookupByLibrary.simpleMessage("سفارش‌دهنده"),
    "eventDetails_selectOrder": MessageLookupByLibrary.simpleMessage(
      "لطفاً انتخاب کنید...",
    ),
    "eventDetails_tabBar_guest": MessageLookupByLibrary.simpleMessage("مهمان"),
    "eventDetails_tabBar_member": MessageLookupByLibrary.simpleMessage("عضو"),
    "eventDetails_tabBar_members": MessageLookupByLibrary.simpleMessage("اعضا"),
    "eventDetails_tabBar_orders": MessageLookupByLibrary.simpleMessage(
      "سفارش‌ها",
    ),
    "eventDetails_tabBar_report": MessageLookupByLibrary.simpleMessage("گزارش"),
    "eventDetails_tabBar_transactions": MessageLookupByLibrary.simpleMessage(
      "تراکنش‌ها",
    ),
    "eventDetails_tab_expenses": MessageLookupByLibrary.simpleMessage(
      "هزینه ها",
    ),
    "eventDetails_tab_guests": MessageLookupByLibrary.simpleMessage("مهمانان"),
    "eventDetails_tab_ratios": MessageLookupByLibrary.simpleMessage("درصدها"),
    "eventStory_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "دفتر یادداشت",
    ),
    "eventStory_writeHere": MessageLookupByLibrary.simpleMessage(
      "از اینجا شروع به نوشتن کنید...",
    ),
    "event_accessEventAccount": MessageLookupByLibrary.simpleMessage(
      "دسترسی به حساب این رویداد",
    ),
    "event_addEvent": MessageLookupByLibrary.simpleMessage(
      "افزودن رویداد جدید",
    ),
    "event_appBarTitle": MessageLookupByLibrary.simpleMessage("رویدادها"),
    "event_closeAccount": MessageLookupByLibrary.simpleMessage("بستن حساب"),
    "event_closeEventAccount": MessageLookupByLibrary.simpleMessage(
      "بستن حساب رویداد",
    ),
    "event_editEvent": MessageLookupByLibrary.simpleMessage("ویرایش رویداد"),
    "event_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز رویدادی اضافه نشده است!",
    ),
    "event_openAccountConfirmation": MessageLookupByLibrary.simpleMessage(
      "برای انجام این عملیات و باز شدن حساب این رویداد برروی تایید کلیک کنید.",
    ),
    "event_reopenAccount": MessageLookupByLibrary.simpleMessage(
      "بازگشایی حساب",
    ),
    "event_selectHostHint": MessageLookupByLibrary.simpleMessage(
      "میزبان این رویداد رو انتخاب کنید",
    ),
    "expense_assignedToAccount": MessageLookupByLibrary.simpleMessage(
      "واگذاری به حساب",
    ),
    "expense_categoryLabel": MessageLookupByLibrary.simpleMessage(
      "سرفصل هزینه",
    ),
    "expense_deductedFromFundWallet": MessageLookupByLibrary.simpleMessage(
      "کسر از کیف ذخیره",
    ),
    "expense_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هیچ هزینه ای ثبت نشده!",
    ),
    "expense_onDate": MessageLookupByLibrary.simpleMessage("در تاریخ"),
    "expense_paidFromBank": MessageLookupByLibrary.simpleMessage(
      "پرداخت از بانک",
    ),
    "expense_payer": MessageLookupByLibrary.simpleMessage("پرداخت کننده"),
    "fundBalance_added": MessageLookupByLibrary.simpleMessage("اضافه شده"),
    "fundBalance_deducted": MessageLookupByLibrary.simpleMessage("کسر شده"),
    "fundBalance_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هیچ تراکنشی برای این صندوق ثبت نشده!",
    ),
    "fundWallet_label": MessageLookupByLibrary.simpleMessage("کیف ذخیره"),
    "fund_appBarTitle": MessageLookupByLibrary.simpleMessage("ذخایر"),
    "fund_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز هیچ صندوقی اضافه نشده است!",
    ),
    "fund_label": MessageLookupByLibrary.simpleMessage("صندوق"),
    "generalAccount_accountsPayable": MessageLookupByLibrary.simpleMessage(
      "حساب‌های پرداختنی",
    ),
    "generalAccount_accountsReceivable": MessageLookupByLibrary.simpleMessage(
      "حساب‌های دریافتنی",
    ),
    "generalAccount_cashAndBank": MessageLookupByLibrary.simpleMessage(
      "نقد و بانک",
    ),
    "generalAccount_contraRevenue": MessageLookupByLibrary.simpleMessage(
      "کاهنده درآمد",
    ),
    "generalAccount_eventExpenses": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های مستقیم ایونت‌ها",
    ),
    "generalAccount_eventRevenueGroup": MessageLookupByLibrary.simpleMessage(
      "درآمد حاصل از ایونت‌ها",
    ),
    "generalAccount_openingAndClosingBalances":
        MessageLookupByLibrary.simpleMessage("تراز افتتاحیه و اختتامیه"),
    "generalAccount_otherExpense": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های عمومی و اداری",
    ),
    "generalAccount_ownerEquity": MessageLookupByLibrary.simpleMessage(
      "حقوق صاحبان سهام",
    ),
    "generalAccount_prepaidExpenses": MessageLookupByLibrary.simpleMessage(
      "پیش پرداخت هزینه ها",
    ),
    "guestBalance_absent": MessageLookupByLibrary.simpleMessage("غایب"),
    "guestBalance_creditDescription": MessageLookupByLibrary.simpleMessage(
      "نشان دهنده مقدار طلبی است که باید از شخص دریافت شود.",
    ),
    "guestBalance_debitDescription": MessageLookupByLibrary.simpleMessage(
      "نشان دهنده ی مقدار بدهی است که باید به شخص پرداخت شود.",
    ),
    "guestBalance_emptyEvents": MessageLookupByLibrary.simpleMessage(
      "این مهمان در هیچ رویدادی ثبت‌نام نکرده!",
    ),
    "guestBalance_eventsCount": MessageLookupByLibrary.simpleMessage(
      "تعداد رویداد",
    ),
    "guestBalance_netAmount": MessageLookupByLibrary.simpleMessage(
      "مبلغ نهایی",
    ),
    "guestBalance_notReceived": MessageLookupByLibrary.simpleMessage(
      "دریافت نشده",
    ),
    "guestBalance_present": MessageLookupByLibrary.simpleMessage("حاضر"),
    "guestBalance_received": MessageLookupByLibrary.simpleMessage("دریافتی"),
    "guestBalance_tab_account": MessageLookupByLibrary.simpleMessage(
      "گردش حساب",
    ),
    "guestBalance_tab_events": MessageLookupByLibrary.simpleMessage("رویدادها"),
    "guestBalance_totalDiscount": MessageLookupByLibrary.simpleMessage(
      "جمع تخفیف",
    ),
    "guestBalance_totalGross": MessageLookupByLibrary.simpleMessage(
      "جمع مبلغ کل",
    ),
    "guestBalance_totalNet": MessageLookupByLibrary.simpleMessage(
      "جمع مبلغ نهایی",
    ),
    "guestDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات مهمان",
    ),
    "guest_addGuest": MessageLookupByLibrary.simpleMessage("افزودن مهمان جدید"),
    "guest_appBarTitle": MessageLookupByLibrary.simpleMessage("مهمانان"),
    "guest_editGuest": MessageLookupByLibrary.simpleMessage("ویرایش مهمان"),
    "guest_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز مهمانی اضافه نشده است!",
    ),
    "header_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "اسناد حسابداری",
    ),
    "header_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هیچ سندی یافت نشد!",
    ),
    "header_number": MessageLookupByLibrary.simpleMessage("شماره سند"),
    "header_type": MessageLookupByLibrary.simpleMessage("نوع سند"),
    "host_addHost": MessageLookupByLibrary.simpleMessage(
      "اضافه کردن میزبان جدید",
    ),
    "host_appBarTitle": MessageLookupByLibrary.simpleMessage("میزبانان"),
    "host_editHost": MessageLookupByLibrary.simpleMessage(
      "ویرایش اطلاعات میزبان",
    ),
    "journalType_closing": MessageLookupByLibrary.simpleMessage("اختتامیه"),
    "journalType_normal": MessageLookupByLibrary.simpleMessage("عادی"),
    "journalType_opening": MessageLookupByLibrary.simpleMessage("افتتاحیه"),
    "journal_accountGroup": MessageLookupByLibrary.simpleMessage("گروه حساب"),
    "journal_appBarTitle": MessageLookupByLibrary.simpleMessage("جزییات سند"),
    "journal_credit": MessageLookupByLibrary.simpleMessage("بستانکار"),
    "journal_debit": MessageLookupByLibrary.simpleMessage("بدهکار"),
    "journal_description": MessageLookupByLibrary.simpleMessage("شرح سند"),
    "journal_firstDetailed": MessageLookupByLibrary.simpleMessage("تفضیلی ۱"),
    "journal_generalAccount": MessageLookupByLibrary.simpleMessage("حساب کل"),
    "journal_secondDetailed": MessageLookupByLibrary.simpleMessage("تفضیلی ۲"),
    "journal_series": MessageLookupByLibrary.simpleMessage("سریال"),
    "journal_subsidiaryAccount": MessageLookupByLibrary.simpleMessage(
      "حساب معین",
    ),
    "login_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "ورود به حساب کاربری...",
    ),
    "memberBalance_creditDescription": MessageLookupByLibrary.simpleMessage(
      "نشان دهنده مقدار طلبی است که میتوان از شخص دریافت کرد.",
    ),
    "memberBalance_debitDescription": MessageLookupByLibrary.simpleMessage(
      "نشان دهنده ی مقدار بدهی است که باید به این شخص پرداخت شود.",
    ),
    "memberBalance_notPaid": MessageLookupByLibrary.simpleMessage(
      "پرداخت نشده",
    ),
    "memberBalance_paid": MessageLookupByLibrary.simpleMessage("پرداختی"),
    "memberDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات عضو",
    ),
    "member_addMember": MessageLookupByLibrary.simpleMessage("افزودن عضو جدید"),
    "member_appBarTitle": MessageLookupByLibrary.simpleMessage("اعضا"),
    "member_editMember": MessageLookupByLibrary.simpleMessage("ویرایش عضو"),
    "member_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز عضوی اضافه نشده است!",
    ),
    "menu_addItem": MessageLookupByLibrary.simpleMessage("افزودن مورد منو"),
    "menu_appBarTitle": MessageLookupByLibrary.simpleMessage("موارد منو"),
    "menu_editItem": MessageLookupByLibrary.simpleMessage("ویرایش مورد"),
    "menu_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز موردی اضافه نشده است!",
    ),
    "modalBottom_title_cateringSettlementStatus":
        MessageLookupByLibrary.simpleMessage("وضعیت تسویه حساب پذیرایی"),
    "modalBottom_title_changeLanguage": MessageLookupByLibrary.simpleMessage(
      "تغییر زبان",
    ),
    "modalBottom_title_guestSettlementStatus":
        MessageLookupByLibrary.simpleMessage("وضعیت تسویه مهمانان"),
    "modalBottom_title_selectBank": MessageLookupByLibrary.simpleMessage(
      "انتخاب بانک",
    ),
    "modalBottom_title_selectCounterparty":
        MessageLookupByLibrary.simpleMessage("انتخاب طرف حساب"),
    "modalBottom_title_selectDetailed": MessageLookupByLibrary.simpleMessage(
      "انتخاب حساب تفصیلی",
    ),
    "modalBottom_title_selectEvent": MessageLookupByLibrary.simpleMessage(
      "انتخاب رویداد",
    ),
    "modalBottom_title_selectExpenseCategory":
        MessageLookupByLibrary.simpleMessage("انتخاب سرفصل هزینه"),
    "modalBottom_title_selectFund": MessageLookupByLibrary.simpleMessage(
      "انتخاب صندوق",
    ),
    "modalBottom_title_selectFundWallet": MessageLookupByLibrary.simpleMessage(
      "انتخاب کیف ذخیره",
    ),
    "modalBottom_title_selectGuests": MessageLookupByLibrary.simpleMessage(
      "انتخاب مهمانان",
    ),
    "modalBottom_title_selectHost": MessageLookupByLibrary.simpleMessage(
      "انتخاب میزبان",
    ),
    "modalBottom_title_selectMembers": MessageLookupByLibrary.simpleMessage(
      "انتخاب اعضا",
    ),
    "modalBottom_title_selectOrganizers": MessageLookupByLibrary.simpleMessage(
      "انتخاب برگزار کنندگان",
    ),
    "modalBottom_title_selectPerson": MessageLookupByLibrary.simpleMessage(
      "انتخاب شخص",
    ),
    "modalBottom_title_selectReserveFund": MessageLookupByLibrary.simpleMessage(
      "انتخاب صندوق ذخیره",
    ),
    "modalBottom_title_selectSubsidiary": MessageLookupByLibrary.simpleMessage(
      "انتخاب حساب معین",
    ),
    "modalBottom_title_selectTeam": MessageLookupByLibrary.simpleMessage(
      "انتخاب تیم",
    ),
    "monthTitle_aban": MessageLookupByLibrary.simpleMessage("آبان"),
    "monthTitle_azar": MessageLookupByLibrary.simpleMessage("آذر"),
    "monthTitle_bahman": MessageLookupByLibrary.simpleMessage("بهمن"),
    "monthTitle_dey": MessageLookupByLibrary.simpleMessage("دی"),
    "monthTitle_esfand": MessageLookupByLibrary.simpleMessage("اسفند"),
    "monthTitle_farvardin": MessageLookupByLibrary.simpleMessage("فروردین"),
    "monthTitle_khordad": MessageLookupByLibrary.simpleMessage("خرداد"),
    "monthTitle_mehr": MessageLookupByLibrary.simpleMessage("مهر"),
    "monthTitle_mordad": MessageLookupByLibrary.simpleMessage("مرداد"),
    "monthTitle_ordibehesht": MessageLookupByLibrary.simpleMessage("اردیبهشت"),
    "monthTitle_shahrivar": MessageLookupByLibrary.simpleMessage("شهریور"),
    "monthTitle_tir": MessageLookupByLibrary.simpleMessage("تیر"),
    "order_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز سفارشی اضافه نشده است!",
    ),
    "payTo_label": MessageLookupByLibrary.simpleMessage("پرداخت به"),
    "ratio_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز نسبتی اضافه نشده است!",
    ),
    "receiveFrom_label": MessageLookupByLibrary.simpleMessage("دریافت از"),
    "register_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "ثبت یک حساب جدید...",
    ),
    "registrationStatus_cancelled": MessageLookupByLibrary.simpleMessage(
      "لغو شده",
    ),
    "registrationStatus_confirmed": MessageLookupByLibrary.simpleMessage(
      "تأیید شده",
    ),
    "registrationStatus_pending": MessageLookupByLibrary.simpleMessage(
      "در انتظار",
    ),
    "registration_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هیچ مهمانی ثبت نام نشده!",
    ),
    "reportDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات گزارش",
    ),
    "reportDetails_reportGeneratedFor": MessageLookupByLibrary.simpleMessage(
      "این گزارش برای تولید شده است",
    ),
    "reportDetails_selectedEvents": MessageLookupByLibrary.simpleMessage(
      "رویدادهای انتخاب‌شده",
    ),
    "report_addReport": MessageLookupByLibrary.simpleMessage(
      "ایجاد گزارش جدید",
    ),
    "report_appBarTitle": MessageLookupByLibrary.simpleMessage("گزارش‌ها"),
    "report_clearFilters": MessageLookupByLibrary.simpleMessage("حذف فیلترها"),
    "report_detailedAccount": MessageLookupByLibrary.simpleMessage(
      "حساب تفصیلی",
    ),
    "report_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز گزارشی اضافه نشده است!",
    ),
    "report_fetchFailed": MessageLookupByLibrary.simpleMessage(
      "خطا در دریافت گزارش!",
    ),
    "report_fromDate": MessageLookupByLibrary.simpleMessage("از تاریخ"),
    "report_noRows": MessageLookupByLibrary.simpleMessage(
      "هیچ ردیفی برای این گزارش یافت نشد!",
    ),
    "report_rowsCount": MessageLookupByLibrary.simpleMessage("تعداد ردیف‌ها"),
    "report_selectingEvents_noEvent": MessageLookupByLibrary.simpleMessage(
      "هیچ رویدادی یافت نشد",
    ),
    "report_toDate": MessageLookupByLibrary.simpleMessage("تا تاریخ"),
    "report_totalCredit": MessageLookupByLibrary.simpleMessage("جمع بستانکار"),
    "report_totalDebit": MessageLookupByLibrary.simpleMessage("جمع بدهکار"),
    "settings_appBarTitle": MessageLookupByLibrary.simpleMessage("تنظیمات"),
    "settlementStatus_depositToBank": MessageLookupByLibrary.simpleMessage(
      "واریز به بانک",
    ),
    "sharePartner_editFund": MessageLookupByLibrary.simpleMessage(
      "ویرایش صندوق",
    ),
    "sharePartner_noFundRatio": MessageLookupByLibrary.simpleMessage(
      "هیچ درصدی از صندوق مشخص نشده!",
    ),
    "sharePartner_noMemberRatio": MessageLookupByLibrary.simpleMessage(
      "هیچ درصدی از اعضا مشخص نشده!",
    ),
    "simpleReport_accountStatus": MessageLookupByLibrary.simpleMessage(
      "وضعیت حساب",
    ),
    "simpleReport_accountStatusNote": MessageLookupByLibrary.simpleMessage(
      "وضعیت حساب شامل همه پرداخت‌ها و طلب‌های عضو است، نه فقط حقوق.",
    ),
    "simpleReport_allEvents": MessageLookupByLibrary.simpleMessage(
      "همه رویدادها",
    ),
    "simpleReport_empty": MessageLookupByLibrary.simpleMessage(
      "گزارشی برای نمایش وجود ندارد!",
    ),
    "simpleReport_eventsCount": MessageLookupByLibrary.simpleMessage(
      "تعداد رویدادها",
    ),
    "simpleReport_memberSalaries": MessageLookupByLibrary.simpleMessage(
      "حقوق اعضا",
    ),
    "simpleReport_membersCount": MessageLookupByLibrary.simpleMessage(
      "تعداد اعضا",
    ),
    "simpleReport_noEvent": MessageLookupByLibrary.simpleMessage("بدون رویداد"),
    "simpleReport_noSalary": MessageLookupByLibrary.simpleMessage(
      "حقوقی ثبت نشده است!",
    ),
    "simpleReport_noSalaryInRange": MessageLookupByLibrary.simpleMessage(
      "در این بازه حقوقی ثبت نشده است!",
    ),
    "simpleReport_salaryAmount": MessageLookupByLibrary.simpleMessage(
      "مبلغ حقوق",
    ),
    "simpleReport_salaryDescription": MessageLookupByLibrary.simpleMessage(
      "حقوق هر عضو از رویدادها و وضعیت حساب او",
    ),
    "simpleReport_salaryDetails": MessageLookupByLibrary.simpleMessage(
      "جزییات حقوق",
    ),
    "simpleReport_totalAllSalaries": MessageLookupByLibrary.simpleMessage(
      "جمع حقوق همه اعضا",
    ),
    "simpleReport_totalSalary": MessageLookupByLibrary.simpleMessage(
      "جمع حقوق",
    ),
    "snacksAssignment_assignmentToFund": MessageLookupByLibrary.simpleMessage(
      "از کیف ذخیره",
    ),
    "snacksAssignment_assignmentToStaff": MessageLookupByLibrary.simpleMessage(
      "از حساب پرسنلی",
    ),
    "snacksAssignment_unassign": MessageLookupByLibrary.simpleMessage(
      "سود این رویداد",
    ),
    "subsidiaryAccount_accountsPayable": MessageLookupByLibrary.simpleMessage(
      "حساب‌های معین بستانکاران",
    ),
    "subsidiaryAccount_adsExpenses": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های تبلیغات",
    ),
    "subsidiaryAccount_bank": MessageLookupByLibrary.simpleMessage("بانک‌ها"),
    "subsidiaryAccount_cash": MessageLookupByLibrary.simpleMessage("صندوق‌ها"),
    "subsidiaryAccount_closingBalance": MessageLookupByLibrary.simpleMessage(
      "تراز اختتامیه",
    ),
    "subsidiaryAccount_entranceExpenses": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های ورودی",
    ),
    "subsidiaryAccount_eventRevenue": MessageLookupByLibrary.simpleMessage(
      "درآمد مستقیم از ایونت‌ها",
    ),
    "subsidiaryAccount_feeExpenses": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های کارمزد بانکی",
    ),
    "subsidiaryAccount_guestReceivables": MessageLookupByLibrary.simpleMessage(
      "حساب‌های معین مهمانان (بدهکاران)",
    ),
    "subsidiaryAccount_openingBalance": MessageLookupByLibrary.simpleMessage(
      "تراز افتتاحیه",
    ),
    "subsidiaryAccount_otherExpenses": MessageLookupByLibrary.simpleMessage(
      "سایر هزینه‌ها",
    ),
    "subsidiaryAccount_otherPayables": MessageLookupByLibrary.simpleMessage(
      "حساب‌های معین سایر (بستانکاران)",
    ),
    "subsidiaryAccount_otherReceivables": MessageLookupByLibrary.simpleMessage(
      "حساب‌های معین سایر (بدهکاران)",
    ),
    "subsidiaryAccount_otherRevenue": MessageLookupByLibrary.simpleMessage(
      "سایر درآمدها",
    ),
    "subsidiaryAccount_partnerEquity": MessageLookupByLibrary.simpleMessage(
      "حساب‌های معین اعضا و شرکا",
    ),
    "subsidiaryAccount_salaryExpense": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های حقوق و دستمزد",
    ),
    "subsidiaryAccount_saleDiscounts": MessageLookupByLibrary.simpleMessage(
      "تخفیفات ایونت",
    ),
    "subsidiaryAccount_snacksExpenses": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های پذیرایی",
    ),
    "subsidiaryAccount_sponsorshipRevenue":
        MessageLookupByLibrary.simpleMessage("درآمد حاصل از اسپانسرشیپ"),
    "subsidiaryAccount_taxPayable": MessageLookupByLibrary.simpleMessage(
      "حساب‌های معین مالیات پرداختنی",
    ),
    "teamDetails_addFund": MessageLookupByLibrary.simpleMessage(
      "اضافه کردن صندوق",
    ),
    "teamDetails_addMembers": MessageLookupByLibrary.simpleMessage(
      "افزودن عضو جدید",
    ),
    "teamDetails_editMembers": MessageLookupByLibrary.simpleMessage(
      "ویرایش عضو",
    ),
    "teamDetails_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز عضوی اضافه نشده است!",
    ),
    "teamDetails_noFundAdded": MessageLookupByLibrary.simpleMessage(
      "هنوز صندوقی اضافه نشده است!",
    ),
    "teamDetials_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "اعضای تیم",
    ),
    "team_addTeam": MessageLookupByLibrary.simpleMessage("افزودن تیم جدید"),
    "team_appBarTitle": MessageLookupByLibrary.simpleMessage("تیم‌ها"),
    "team_editTeam": MessageLookupByLibrary.simpleMessage("ویرایش تیم"),
    "team_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز تیمی اضافه نشده است!",
    ),
    "textField_hint_advertising": MessageLookupByLibrary.simpleMessage(
      "تبلیغات",
    ),
    "textField_hint_bankName": MessageLookupByLibrary.simpleMessage("پاسارگاد"),
    "textField_hint_cardNumber": MessageLookupByLibrary.simpleMessage(
      "۶۰۲۱۳۳۲۵۴۲۵۸۳۶۴۸",
    ),
    "textField_hint_castAwayMovie": MessageLookupByLibrary.simpleMessage(
      "فیلم Cast Away",
    ),
    "textField_hint_chocolateCake": MessageLookupByLibrary.simpleMessage(
      "کیک شکلاتی",
    ),
    "textField_hint_id": MessageLookupByLibrary.simpleMessage("@mahdiyar"),
    "textField_hint_mahdiyar": MessageLookupByLibrary.simpleMessage("مهدیار"),
    "textField_hint_mahdiyarArbabzi": MessageLookupByLibrary.simpleMessage(
      "مهدیار ارباب زی",
    ),
    "textField_hint_movieAnalyze": MessageLookupByLibrary.simpleMessage(
      "تحلیل فیلم",
    ),
    "textField_hint_phone": MessageLookupByLibrary.simpleMessage("09391543702"),
    "textField_hint_search": MessageLookupByLibrary.simpleMessage("جستجو"),
    "textField_hint_thisMonthSalary": MessageLookupByLibrary.simpleMessage(
      "حقوق این ماه",
    ),
    "textField_hint_zeinabJadidi": MessageLookupByLibrary.simpleMessage(
      "زینب جدیدی",
    ),
    "textField_label_amount": MessageLookupByLibrary.simpleMessage("مبلغ"),
    "textField_label_birthday": MessageLookupByLibrary.simpleMessage(
      "تاریخ تولد",
    ),
    "textField_label_cardOrAccountNumber": MessageLookupByLibrary.simpleMessage(
      "شماره کارت / حساب",
    ),
    "textField_label_date": MessageLookupByLibrary.simpleMessage("تاریخ"),
    "textField_label_description": MessageLookupByLibrary.simpleMessage(
      "توضیحات",
    ),
    "textField_label_discount": MessageLookupByLibrary.simpleMessage("تخفیف"),
    "textField_label_email": MessageLookupByLibrary.simpleMessage("ایمیل"),
    "textField_label_finalAmount": MessageLookupByLibrary.simpleMessage(
      "مبلغ نهایی",
    ),
    "textField_label_fundWalletName": MessageLookupByLibrary.simpleMessage(
      "نام کیف ذخیره",
    ),
    "textField_label_generateFor": MessageLookupByLibrary.simpleMessage(
      "تولید برای",
    ),
    "textField_label_grossAmount": MessageLookupByLibrary.simpleMessage(
      "مبلغ کل بدون تخفیف",
    ),
    "textField_label_instagramId": MessageLookupByLibrary.simpleMessage(
      "آی‌دی اینستاگرام",
    ),
    "textField_label_joinAt": MessageLookupByLibrary.simpleMessage(
      "تاریخ عضویت",
    ),
    "textField_label_journalDescription": MessageLookupByLibrary.simpleMessage(
      "توضیحات سند",
    ),
    "textField_label_name": MessageLookupByLibrary.simpleMessage("نام"),
    "textField_label_openingBalance": MessageLookupByLibrary.simpleMessage(
      "موجودی اولیه",
    ),
    "textField_label_optional": MessageLookupByLibrary.simpleMessage(
      "(اختیاری)",
    ),
    "textField_label_password": MessageLookupByLibrary.simpleMessage(
      "رمز عبور",
    ),
    "textField_label_payFromFundOptional": MessageLookupByLibrary.simpleMessage(
      "پرداخت از ذخیره (اختیاری)",
    ),
    "textField_label_paymentDate": MessageLookupByLibrary.simpleMessage(
      "تاریخ پرداخت",
    ),
    "textField_label_phone": MessageLookupByLibrary.simpleMessage("تلفن"),
    "textField_label_ratio": MessageLookupByLibrary.simpleMessage("نسبت"),
    "textField_label_receiveToFundOptional":
        MessageLookupByLibrary.simpleMessage("دریافت به ذخیره (اختیاری)"),
    "textField_label_relatedEventOptional":
        MessageLookupByLibrary.simpleMessage("مربوط به رویداد (اختیاری)"),
    "textField_label_repeatPassword": MessageLookupByLibrary.simpleMessage(
      "تکرار رمز عبور",
    ),
    "textField_label_team": MessageLookupByLibrary.simpleMessage("تیم"),
    "textField_label_telegramId": MessageLookupByLibrary.simpleMessage(
      "آی‌دی تلگرام",
    ),
    "textField_label_title": MessageLookupByLibrary.simpleMessage("عنوان"),
    "textField_label_transferFee": MessageLookupByLibrary.simpleMessage(
      "کارمزد انتقال",
    ),
    "transaction_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز تراکنشی اضافه نشده است!",
    ),
    "validator_noMemberToAddTeam": MessageLookupByLibrary.simpleMessage(
      "• هیچ عضوی برای اضافه کردن وجود ندارد",
    ),
    "validator_passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "• رمز عبور مطابقت ندارد",
    ),
    "validator_ratioCanNotMoreThan": m9,
    "validator_required": MessageLookupByLibrary.simpleMessage("• الزامی"),
    "validator_thereIsNoRatio": MessageLookupByLibrary.simpleMessage(
      "• هیچ نسبتی برای اضافه کردن وجود ندارد",
    ),
    "warning_calculatingSalaryGoesWrong": MessageLookupByLibrary.simpleMessage(
      "خطا در محاسبه حقوق اعضا!",
    ),
    "warning_operationFailure": MessageLookupByLibrary.simpleMessage(
      "عملیات ناموفق بود:",
    ),
    "warning_operationSuccessful": MessageLookupByLibrary.simpleMessage(
      "عملیات با موفقیت انجام شد!",
    ),
    "warning_selectEvent": MessageLookupByLibrary.simpleMessage(
      "لطفاً یک رویداد انتخاب کنید!",
    ),
    "warning_somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "مشکلی پیش آمد، بعداً دوباره تلاش کنید...",
    ),
  };
}
