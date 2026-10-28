// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) => "${count} guests selected";

  static String m1(amount) => "The group owes them: ${amount}";

  static String m2(amount) => "Owes the group: ${amount}";

  static String m3(name) => "Payment from ${name}";

  static String m4(name) => "Payment to ${name}";

  static String m5(count) => "${count} members selected";

  static String m6(name) =>
      "The name ${name} is already taken, please choose another name.";

  static String m7(totalDebit, totalCredit) =>
      "Journal is unbalanced: total debit (${totalDebit}) does not equal total credit (${totalCredit}).";

  static String m8(totalOrders, totalGuests, totalMembers) =>
      "Total Capacity: ${totalOrders} / Guests: ${totalGuests}, Members: ${totalMembers}";

  static String m9(ratio) => "• Ratio can not be more than ${ratio}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountGroup_assets": MessageLookupByLibrary.simpleMessage("Assets"),
    "accountGroup_equity": MessageLookupByLibrary.simpleMessage("Equity"),
    "accountGroup_expenses": MessageLookupByLibrary.simpleMessage("Expenses"),
    "accountGroup_liabilities": MessageLookupByLibrary.simpleMessage(
      "Liabilities",
    ),
    "accountGroup_revenues": MessageLookupByLibrary.simpleMessage("Revenues"),
    "alertDialog_areYouSure": MessageLookupByLibrary.simpleMessage(
      "Are sure about this action?",
    ),
    "alertDialog_discardChanges": MessageLookupByLibrary.simpleMessage(
      "If you proceed this action, all your changes will be discard!",
    ),
    "alertDialog_noticeThisAboutAction": MessageLookupByLibrary.simpleMessage(
      "Notice that if you used this item, it effects those and delete all data that related to this item too.",
    ),
    "attendGuest_cateringDeduction": MessageLookupByLibrary.simpleMessage(
      "Catering cost deduction",
    ),
    "attendGuest_paymentStatus": MessageLookupByLibrary.simpleMessage(
      "Payment status",
    ),
    "attendGuest_selectGuestsHint": MessageLookupByLibrary.simpleMessage(
      "Select the guests of this event",
    ),
    "attendGuest_selectedGuestsCount": m0,
    "balance_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Account activity",
    ),
    "balance_emptyUserTransactions": MessageLookupByLibrary.simpleMessage(
      "No transactions have been recorded for this user!",
    ),
    "balance_groupOwes": m1,
    "balance_openingAmount": MessageLookupByLibrary.simpleMessage(
      "Opening amount",
    ),
    "balance_owesGroup": m2,
    "balance_settled": MessageLookupByLibrary.simpleMessage("Settled"),
    "bankBalance_accountNumber": MessageLookupByLibrary.simpleMessage(
      "Account number",
    ),
    "bankBalance_deposit": MessageLookupByLibrary.simpleMessage("Deposit"),
    "bankBalance_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "No transactions have been recorded for this bank!",
    ),
    "bankBalance_noFundRecorded": MessageLookupByLibrary.simpleMessage(
      "No fund has been recorded!",
    ),
    "bankBalance_payFrom": m3,
    "bankBalance_payTo": m4,
    "bankBalance_withdrawal": MessageLookupByLibrary.simpleMessage(
      "Withdrawal",
    ),
    "bank_label": MessageLookupByLibrary.simpleMessage("Bank"),
    "button_title_addNewRatio": MessageLookupByLibrary.simpleMessage(
      "Add new percentage",
    ),
    "button_title_backToLogin": MessageLookupByLibrary.simpleMessage(
      "Back to login",
    ),
    "button_title_backup": MessageLookupByLibrary.simpleMessage(
      "Generate Backup",
    ),
    "button_title_banks": MessageLookupByLibrary.simpleMessage("Banks"),
    "button_title_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "button_title_changeLanguage": MessageLookupByLibrary.simpleMessage(
      "Change Language",
    ),
    "button_title_delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "button_title_edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "button_title_events": MessageLookupByLibrary.simpleMessage("Events"),
    "button_title_funds": MessageLookupByLibrary.simpleMessage("Fund wallets"),
    "button_title_generate": MessageLookupByLibrary.simpleMessage("Generate"),
    "button_title_guests": MessageLookupByLibrary.simpleMessage("Teams"),
    "button_title_journals": MessageLookupByLibrary.simpleMessage("Journals"),
    "button_title_login": MessageLookupByLibrary.simpleMessage("Login"),
    "button_title_members": MessageLookupByLibrary.simpleMessage("Members"),
    "button_title_menuItems": MessageLookupByLibrary.simpleMessage(
      "Menu Items",
    ),
    "button_title_next": MessageLookupByLibrary.simpleMessage("Next"),
    "button_title_offlineMode": MessageLookupByLibrary.simpleMessage(
      "Offline Mode",
    ),
    "button_title_onlineMode": MessageLookupByLibrary.simpleMessage(
      "Online Mode",
    ),
    "button_title_payEventExpenseByBank": MessageLookupByLibrary.simpleMessage(
      "Pay event expense by bank",
    ),
    "button_title_payEventExpenseByStaff": MessageLookupByLibrary.simpleMessage(
      "Pay event expense by members",
    ),
    "button_title_preview": MessageLookupByLibrary.simpleMessage("Preview"),
    "button_title_previous": MessageLookupByLibrary.simpleMessage("Previous"),
    "button_title_register": MessageLookupByLibrary.simpleMessage("Register"),
    "button_title_registerGuest": MessageLookupByLibrary.simpleMessage(
      "Register guest",
    ),
    "button_title_reports": MessageLookupByLibrary.simpleMessage("Reports"),
    "button_title_restore": MessageLookupByLibrary.simpleMessage(
      "Restore Data",
    ),
    "button_title_salaryReport": MessageLookupByLibrary.simpleMessage(
      "Salary\'s Report",
    ),
    "button_title_settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "button_title_simpleReports": MessageLookupByLibrary.simpleMessage(
      "Simple reports",
    ),
    "button_title_submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "button_title_switchToOfflineMode": MessageLookupByLibrary.simpleMessage(
      "Switch to Offline Mode",
    ),
    "button_title_teamMember": MessageLookupByLibrary.simpleMessage(
      "Team\'s Member",
    ),
    "button_title_teams": MessageLookupByLibrary.simpleMessage("Guests"),
    "button_title_today": MessageLookupByLibrary.simpleMessage("today"),
    "closeEvent_catering": MessageLookupByLibrary.simpleMessage("Catering"),
    "closeEvent_heldDate": MessageLookupByLibrary.simpleMessage("Event date"),
    "closeEvent_inputAmount": MessageLookupByLibrary.simpleMessage(
      "Input amount",
    ),
    "closeEvent_organizers": MessageLookupByLibrary.simpleMessage("Organizers"),
    "closeEvent_selectOrganizersHint": MessageLookupByLibrary.simpleMessage(
      "Select the organizers of this event",
    ),
    "closeEvent_selectedMembersCount": m5,
    "closeEvent_totalCatering": MessageLookupByLibrary.simpleMessage(
      "Total catering",
    ),
    "closeEvent_totalExpenseAmount": MessageLookupByLibrary.simpleMessage(
      "Total expense amount",
    ),
    "closeEvent_totalGuests": MessageLookupByLibrary.simpleMessage(
      "Total number of guests of this event",
    ),
    "common_balance": MessageLookupByLibrary.simpleMessage("Balance"),
    "common_comingSoon": MessageLookupByLibrary.simpleMessage("Coming soon"),
    "common_noBalance": MessageLookupByLibrary.simpleMessage("No balance"),
    "common_noItemToShow": MessageLookupByLibrary.simpleMessage(
      "There is nothing to show",
    ),
    "contentTitle_active": MessageLookupByLibrary.simpleMessage("Active: "),
    "contentTitle_balance": MessageLookupByLibrary.simpleMessage("Balance: "),
    "contentTitle_birthday": MessageLookupByLibrary.simpleMessage("Birthday: "),
    "contentTitle_byWho": MessageLookupByLibrary.simpleMessage("by "),
    "contentTitle_date": MessageLookupByLibrary.simpleMessage("Date: "),
    "contentTitle_description": MessageLookupByLibrary.simpleMessage(
      "Description: ",
    ),
    "contentTitle_engagedTeam": MessageLookupByLibrary.simpleMessage(
      "Engaged Team: ",
    ),
    "contentTitle_expense": MessageLookupByLibrary.simpleMessage("Expense: "),
    "contentTitle_income": MessageLookupByLibrary.simpleMessage("Income: "),
    "contentTitle_instagram": MessageLookupByLibrary.simpleMessage(
      "Instagram ID: ",
    ),
    "contentTitle_joinAt": MessageLookupByLibrary.simpleMessage("Join at: "),
    "contentTitle_onDate": MessageLookupByLibrary.simpleMessage("on: "),
    "contentTitle_paidExpenses": MessageLookupByLibrary.simpleMessage(
      "Paid Expenses ",
    ),
    "contentTitle_phone": MessageLookupByLibrary.simpleMessage("Phone: "),
    "contentTitle_salary": MessageLookupByLibrary.simpleMessage("Salary "),
    "contentTitle_telegram": MessageLookupByLibrary.simpleMessage(
      "Telegram ID: ",
    ),
    "contentTitle_totalExpense": MessageLookupByLibrary.simpleMessage(
      "Total Expense: ",
    ),
    "contentTitle_totalIncome": MessageLookupByLibrary.simpleMessage(
      "Total Income: ",
    ),
    "contentTitle_unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "contentTitle_unpaid": MessageLookupByLibrary.simpleMessage("Unpaid"),
    "dropDownButton_hint_selectGuest": MessageLookupByLibrary.simpleMessage(
      "Select a guest",
    ),
    "dropDownButton_hint_selectItem": MessageLookupByLibrary.simpleMessage(
      "Select a item",
    ),
    "dropDownButton_hint_selectMember": MessageLookupByLibrary.simpleMessage(
      "Select a member",
    ),
    "dropDownButton_hint_selectOption": MessageLookupByLibrary.simpleMessage(
      "Select an option",
    ),
    "dropDownButton_hint_selectTeam": MessageLookupByLibrary.simpleMessage(
      "Select a team",
    ),
    "dropDownButton_hint_selectType": MessageLookupByLibrary.simpleMessage(
      "Select a type",
    ),
    "dropDownButton_label_guests": MessageLookupByLibrary.simpleMessage(
      "Guests",
    ),
    "dropDownButton_label_members": MessageLookupByLibrary.simpleMessage(
      "Members",
    ),
    "dropDownButton_label_persons": MessageLookupByLibrary.simpleMessage(
      "Persons",
    ),
    "dropDownButton_label_teams": MessageLookupByLibrary.simpleMessage("Teams"),
    "dropDownButton_label_transactionType":
        MessageLookupByLibrary.simpleMessage("Transaction Type"),
    "error_bankInfoRequired": MessageLookupByLibrary.simpleMessage(
      "Bank information cannot be empty!",
    ),
    "error_duplicateName": m6,
    "error_generic": MessageLookupByLibrary.simpleMessage(
      "Something went wrong!",
    ),
    "error_journalNotFound": MessageLookupByLibrary.simpleMessage(
      "The journal was not found!",
    ),
    "error_journalUnbalanced": m7,
    "error_userInfoRequired": MessageLookupByLibrary.simpleMessage(
      "User information cannot be empty!",
    ),
    "eventDetails_addEventOrder": MessageLookupByLibrary.simpleMessage(
      "Add New Order",
    ),
    "eventDetails_addEventRatio": MessageLookupByLibrary.simpleMessage(
      "Add New Member\'s Ratio",
    ),
    "eventDetails_addEventTransaction": MessageLookupByLibrary.simpleMessage(
      "Add New Transaction",
    ),
    "eventDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Event Details",
    ),
    "eventDetails_discounts": MessageLookupByLibrary.simpleMessage("Discounts"),
    "eventDetails_editEventOrder": MessageLookupByLibrary.simpleMessage(
      "Edit Order",
    ),
    "eventDetails_editEventRatio": MessageLookupByLibrary.simpleMessage(
      "Edit Ratio",
    ),
    "eventDetails_editEventTransaction": MessageLookupByLibrary.simpleMessage(
      "Edit Transaction",
    ),
    "eventDetails_eventOrdersBanner_all": MessageLookupByLibrary.simpleMessage(
      "All",
    ),
    "eventDetails_eventOrdersBanner_notAttended":
        MessageLookupByLibrary.simpleMessage("Not Attended"),
    "eventDetails_eventOrdersBanner_totalCapacity": m8,
    "eventDetails_grossIncome": MessageLookupByLibrary.simpleMessage(
      "Gross income",
    ),
    "eventDetails_guestsCount": MessageLookupByLibrary.simpleMessage(
      "Number of guests",
    ),
    "eventDetails_heldOnDay": MessageLookupByLibrary.simpleMessage("Held on"),
    "eventDetails_host": MessageLookupByLibrary.simpleMessage("Host"),
    "eventDetails_orderBy": MessageLookupByLibrary.simpleMessage("Ordered By"),
    "eventDetails_selectOrder": MessageLookupByLibrary.simpleMessage(
      "Please Select...",
    ),
    "eventDetails_tabBar_guest": MessageLookupByLibrary.simpleMessage("Guest"),
    "eventDetails_tabBar_member": MessageLookupByLibrary.simpleMessage(
      "Member",
    ),
    "eventDetails_tabBar_members": MessageLookupByLibrary.simpleMessage(
      "Members",
    ),
    "eventDetails_tabBar_orders": MessageLookupByLibrary.simpleMessage(
      "Orders",
    ),
    "eventDetails_tabBar_report": MessageLookupByLibrary.simpleMessage(
      "Report",
    ),
    "eventDetails_tabBar_transactions": MessageLookupByLibrary.simpleMessage(
      "Transactions",
    ),
    "eventDetails_tab_expenses": MessageLookupByLibrary.simpleMessage(
      "Expenses",
    ),
    "eventDetails_tab_guests": MessageLookupByLibrary.simpleMessage("Guests"),
    "eventDetails_tab_ratios": MessageLookupByLibrary.simpleMessage(
      "Percentages",
    ),
    "eventStory_appBarTitle": MessageLookupByLibrary.simpleMessage("Notebook"),
    "eventStory_writeHere": MessageLookupByLibrary.simpleMessage(
      "Start writing from here...",
    ),
    "event_accessEventAccount": MessageLookupByLibrary.simpleMessage(
      "Access this event\'s account",
    ),
    "event_addEvent": MessageLookupByLibrary.simpleMessage("Add new event"),
    "event_appBarTitle": MessageLookupByLibrary.simpleMessage("Events"),
    "event_closeAccount": MessageLookupByLibrary.simpleMessage("Close account"),
    "event_closeEventAccount": MessageLookupByLibrary.simpleMessage(
      "Close event account",
    ),
    "event_editEvent": MessageLookupByLibrary.simpleMessage("Edit event"),
    "event_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no event added yet!",
    ),
    "event_openAccountConfirmation": MessageLookupByLibrary.simpleMessage(
      "Click confirm to proceed and reopen this event\'s account.",
    ),
    "event_reopenAccount": MessageLookupByLibrary.simpleMessage(
      "Reopen account",
    ),
    "event_selectHostHint": MessageLookupByLibrary.simpleMessage(
      "Select the host of this event",
    ),
    "expense_assignedToAccount": MessageLookupByLibrary.simpleMessage(
      "Assigned to account",
    ),
    "expense_categoryLabel": MessageLookupByLibrary.simpleMessage(
      "Expense category",
    ),
    "expense_deductedFromFundWallet": MessageLookupByLibrary.simpleMessage(
      "Deducted from fund wallet",
    ),
    "expense_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "No expense has been recorded!",
    ),
    "expense_onDate": MessageLookupByLibrary.simpleMessage("On date"),
    "expense_paidFromBank": MessageLookupByLibrary.simpleMessage(
      "Paid from bank",
    ),
    "expense_payer": MessageLookupByLibrary.simpleMessage("Payer"),
    "fundBalance_added": MessageLookupByLibrary.simpleMessage("Added"),
    "fundBalance_deducted": MessageLookupByLibrary.simpleMessage("Deducted"),
    "fundBalance_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "No transactions have been recorded for this fund!",
    ),
    "fundWallet_label": MessageLookupByLibrary.simpleMessage("Fund wallet"),
    "fund_appBarTitle": MessageLookupByLibrary.simpleMessage("Reserves"),
    "fund_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "No fund has been added yet!",
    ),
    "fund_label": MessageLookupByLibrary.simpleMessage("Fund"),
    "generalAccount_accountsPayable": MessageLookupByLibrary.simpleMessage(
      "Accounts payable",
    ),
    "generalAccount_accountsReceivable": MessageLookupByLibrary.simpleMessage(
      "Accounts receivable",
    ),
    "generalAccount_cashAndBank": MessageLookupByLibrary.simpleMessage(
      "Cash and bank",
    ),
    "generalAccount_contraRevenue": MessageLookupByLibrary.simpleMessage(
      "Revenue deductions",
    ),
    "generalAccount_eventExpenses": MessageLookupByLibrary.simpleMessage(
      "Direct event expenses",
    ),
    "generalAccount_eventRevenueGroup": MessageLookupByLibrary.simpleMessage(
      "Event revenue",
    ),
    "generalAccount_openingAndClosingBalances":
        MessageLookupByLibrary.simpleMessage("Opening and closing balances"),
    "generalAccount_otherExpense": MessageLookupByLibrary.simpleMessage(
      "General and administrative expenses",
    ),
    "generalAccount_ownerEquity": MessageLookupByLibrary.simpleMessage(
      "Owners\' equity",
    ),
    "generalAccount_prepaidExpenses": MessageLookupByLibrary.simpleMessage(
      "Prepaid expenses",
    ),
    "guestBalance_creditDescription": MessageLookupByLibrary.simpleMessage(
      "Shows the amount receivable from this person.",
    ),
    "guestBalance_debitDescription": MessageLookupByLibrary.simpleMessage(
      "Shows the amount payable to this person.",
    ),
    "guestBalance_notReceived": MessageLookupByLibrary.simpleMessage(
      "Not received",
    ),
    "guestBalance_received": MessageLookupByLibrary.simpleMessage("Received"),
    "guestDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Guests Details",
    ),
    "guest_addGuest": MessageLookupByLibrary.simpleMessage("Add new guest"),
    "guest_appBarTitle": MessageLookupByLibrary.simpleMessage("Guests"),
    "guest_editGuest": MessageLookupByLibrary.simpleMessage("Edit guest"),
    "guest_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no guest added yet!",
    ),
    "header_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Accounting journals",
    ),
    "header_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "No journal found!",
    ),
    "header_number": MessageLookupByLibrary.simpleMessage("Journal number"),
    "header_type": MessageLookupByLibrary.simpleMessage("Journal type"),
    "host_addHost": MessageLookupByLibrary.simpleMessage("Add new host"),
    "host_appBarTitle": MessageLookupByLibrary.simpleMessage("Hosts"),
    "host_editHost": MessageLookupByLibrary.simpleMessage(
      "Edit host information",
    ),
    "journalType_closing": MessageLookupByLibrary.simpleMessage("Closing"),
    "journalType_normal": MessageLookupByLibrary.simpleMessage("Normal"),
    "journalType_opening": MessageLookupByLibrary.simpleMessage("Opening"),
    "journal_accountGroup": MessageLookupByLibrary.simpleMessage(
      "Account group",
    ),
    "journal_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Journal details",
    ),
    "journal_credit": MessageLookupByLibrary.simpleMessage("Credit"),
    "journal_debit": MessageLookupByLibrary.simpleMessage("Debit"),
    "journal_description": MessageLookupByLibrary.simpleMessage(
      "Journal description",
    ),
    "journal_firstDetailed": MessageLookupByLibrary.simpleMessage(
      "Detailed account 1",
    ),
    "journal_generalAccount": MessageLookupByLibrary.simpleMessage(
      "General account",
    ),
    "journal_secondDetailed": MessageLookupByLibrary.simpleMessage(
      "Detailed account 2",
    ),
    "journal_series": MessageLookupByLibrary.simpleMessage("Series"),
    "journal_subsidiaryAccount": MessageLookupByLibrary.simpleMessage(
      "Subsidiary account",
    ),
    "login_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Login to your account...",
    ),
    "memberBalance_creditDescription": MessageLookupByLibrary.simpleMessage(
      "Shows the receivable amount that can be collected from this person.",
    ),
    "memberBalance_debitDescription": MessageLookupByLibrary.simpleMessage(
      "Shows the amount payable to this person.",
    ),
    "memberBalance_notPaid": MessageLookupByLibrary.simpleMessage("Not paid"),
    "memberBalance_paid": MessageLookupByLibrary.simpleMessage("Paid"),
    "memberDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Member Details",
    ),
    "member_addMember": MessageLookupByLibrary.simpleMessage("Add new member"),
    "member_appBarTitle": MessageLookupByLibrary.simpleMessage("Members"),
    "member_editMember": MessageLookupByLibrary.simpleMessage("Edit member"),
    "member_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no member added yet!",
    ),
    "menu_addItem": MessageLookupByLibrary.simpleMessage("Add Menu Item"),
    "menu_appBarTitle": MessageLookupByLibrary.simpleMessage("Menu Items"),
    "menu_editItem": MessageLookupByLibrary.simpleMessage("Edit Menu Item"),
    "menu_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no item added yet!",
    ),
    "modalBottom_title_cateringSettlementStatus":
        MessageLookupByLibrary.simpleMessage("Catering settlement status"),
    "modalBottom_title_changeLanguage": MessageLookupByLibrary.simpleMessage(
      "Change Language",
    ),
    "modalBottom_title_guestSettlementStatus":
        MessageLookupByLibrary.simpleMessage("Guests settlement status"),
    "modalBottom_title_selectBank": MessageLookupByLibrary.simpleMessage(
      "Select bank",
    ),
    "modalBottom_title_selectCounterparty":
        MessageLookupByLibrary.simpleMessage("Select counterparty"),
    "modalBottom_title_selectDetailed": MessageLookupByLibrary.simpleMessage(
      "Select detailed account",
    ),
    "modalBottom_title_selectEvent": MessageLookupByLibrary.simpleMessage(
      "Select event",
    ),
    "modalBottom_title_selectExpenseCategory":
        MessageLookupByLibrary.simpleMessage("Select expense category"),
    "modalBottom_title_selectFund": MessageLookupByLibrary.simpleMessage(
      "Select fund",
    ),
    "modalBottom_title_selectFundWallet": MessageLookupByLibrary.simpleMessage(
      "Select fund wallet",
    ),
    "modalBottom_title_selectGuests": MessageLookupByLibrary.simpleMessage(
      "Select guests",
    ),
    "modalBottom_title_selectHost": MessageLookupByLibrary.simpleMessage(
      "Select host",
    ),
    "modalBottom_title_selectMembers": MessageLookupByLibrary.simpleMessage(
      "Select members",
    ),
    "modalBottom_title_selectOrganizers": MessageLookupByLibrary.simpleMessage(
      "Select organizers",
    ),
    "modalBottom_title_selectPerson": MessageLookupByLibrary.simpleMessage(
      "Select person",
    ),
    "modalBottom_title_selectReserveFund": MessageLookupByLibrary.simpleMessage(
      "Select reserve fund",
    ),
    "modalBottom_title_selectSubsidiary": MessageLookupByLibrary.simpleMessage(
      "Select subsidiary account",
    ),
    "modalBottom_title_selectTeam": MessageLookupByLibrary.simpleMessage(
      "Select team",
    ),
    "monthTitle_aban": MessageLookupByLibrary.simpleMessage("Aban: "),
    "monthTitle_azar": MessageLookupByLibrary.simpleMessage("Azar: "),
    "monthTitle_bahman": MessageLookupByLibrary.simpleMessage("Bahman: "),
    "monthTitle_dey": MessageLookupByLibrary.simpleMessage("Day: "),
    "monthTitle_esfand": MessageLookupByLibrary.simpleMessage("Esfand: "),
    "monthTitle_farvardin": MessageLookupByLibrary.simpleMessage("Farvardin: "),
    "monthTitle_khordad": MessageLookupByLibrary.simpleMessage("Khordad: "),
    "monthTitle_mehr": MessageLookupByLibrary.simpleMessage("Mehr: "),
    "monthTitle_mordad": MessageLookupByLibrary.simpleMessage("Mordad: "),
    "monthTitle_ordibehesht": MessageLookupByLibrary.simpleMessage(
      "Ordibehesht: ",
    ),
    "monthTitle_shahrivar": MessageLookupByLibrary.simpleMessage("Shahrivar: "),
    "monthTitle_tir": MessageLookupByLibrary.simpleMessage("Tir: "),
    "order_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no order added yet!",
    ),
    "payTo_label": MessageLookupByLibrary.simpleMessage("Pay to"),
    "ratio_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no ratio added yet!",
    ),
    "receiveFrom_label": MessageLookupByLibrary.simpleMessage("Receive from"),
    "register_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Register a new account...",
    ),
    "registration_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "No guest has been registered!",
    ),
    "reportDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Report Details",
    ),
    "reportDetails_reportGeneratedFor": MessageLookupByLibrary.simpleMessage(
      "This report generated for",
    ),
    "reportDetails_selectedEvents": MessageLookupByLibrary.simpleMessage(
      "Selected Events",
    ),
    "report_addReport": MessageLookupByLibrary.simpleMessage(
      "Create new report",
    ),
    "report_appBarTitle": MessageLookupByLibrary.simpleMessage("Reports"),
    "report_clearFilters": MessageLookupByLibrary.simpleMessage(
      "Clear filters",
    ),
    "report_detailedAccount": MessageLookupByLibrary.simpleMessage(
      "Detailed account",
    ),
    "report_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no report added yet!",
    ),
    "report_fetchFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to load the report!",
    ),
    "report_fromDate": MessageLookupByLibrary.simpleMessage("From date"),
    "report_noRows": MessageLookupByLibrary.simpleMessage(
      "No rows found for this report!",
    ),
    "report_rowsCount": MessageLookupByLibrary.simpleMessage("Number of rows"),
    "report_selectingEvents_noEvent": MessageLookupByLibrary.simpleMessage(
      "No events found on",
    ),
    "report_toDate": MessageLookupByLibrary.simpleMessage("To date"),
    "report_totalCredit": MessageLookupByLibrary.simpleMessage("Total credit"),
    "report_totalDebit": MessageLookupByLibrary.simpleMessage("Total debit"),
    "settings_appBarTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "settlementStatus_depositToBank": MessageLookupByLibrary.simpleMessage(
      "Deposit to bank",
    ),
    "sharePartner_editFund": MessageLookupByLibrary.simpleMessage("Edit fund"),
    "sharePartner_noFundRatio": MessageLookupByLibrary.simpleMessage(
      "No fund percentage has been specified!",
    ),
    "sharePartner_noMemberRatio": MessageLookupByLibrary.simpleMessage(
      "No member percentage has been specified!",
    ),
    "simpleReport_accountStatus": MessageLookupByLibrary.simpleMessage(
      "Account status",
    ),
    "simpleReport_accountStatusNote": MessageLookupByLibrary.simpleMessage(
      "Account status includes all of the member\'s payments and receivables, not just salary.",
    ),
    "simpleReport_allEvents": MessageLookupByLibrary.simpleMessage(
      "All events",
    ),
    "simpleReport_empty": MessageLookupByLibrary.simpleMessage(
      "There is no report to show!",
    ),
    "simpleReport_eventsCount": MessageLookupByLibrary.simpleMessage(
      "Number of events",
    ),
    "simpleReport_memberSalaries": MessageLookupByLibrary.simpleMessage(
      "Member salaries",
    ),
    "simpleReport_membersCount": MessageLookupByLibrary.simpleMessage(
      "Number of members",
    ),
    "simpleReport_noEvent": MessageLookupByLibrary.simpleMessage("No event"),
    "simpleReport_noSalary": MessageLookupByLibrary.simpleMessage(
      "No salary has been recorded!",
    ),
    "simpleReport_noSalaryInRange": MessageLookupByLibrary.simpleMessage(
      "No salary has been recorded in this period!",
    ),
    "simpleReport_salaryAmount": MessageLookupByLibrary.simpleMessage(
      "Salary amount",
    ),
    "simpleReport_salaryDescription": MessageLookupByLibrary.simpleMessage(
      "Each member\'s salary from events and their account status",
    ),
    "simpleReport_salaryDetails": MessageLookupByLibrary.simpleMessage(
      "Salary details",
    ),
    "simpleReport_totalAllSalaries": MessageLookupByLibrary.simpleMessage(
      "Total salary of all members",
    ),
    "simpleReport_totalSalary": MessageLookupByLibrary.simpleMessage(
      "Total salary",
    ),
    "snacksAssignment_assignmentToFund": MessageLookupByLibrary.simpleMessage(
      "From fund wallet",
    ),
    "snacksAssignment_assignmentToStaff": MessageLookupByLibrary.simpleMessage(
      "From staff account",
    ),
    "snacksAssignment_unassign": MessageLookupByLibrary.simpleMessage(
      "Event profit",
    ),
    "subsidiaryAccount_accountsPayable": MessageLookupByLibrary.simpleMessage(
      "Creditor accounts",
    ),
    "subsidiaryAccount_adsExpenses": MessageLookupByLibrary.simpleMessage(
      "Advertising expenses",
    ),
    "subsidiaryAccount_bank": MessageLookupByLibrary.simpleMessage("Banks"),
    "subsidiaryAccount_cash": MessageLookupByLibrary.simpleMessage(
      "Cash funds",
    ),
    "subsidiaryAccount_closingBalance": MessageLookupByLibrary.simpleMessage(
      "Closing balance",
    ),
    "subsidiaryAccount_entranceExpenses": MessageLookupByLibrary.simpleMessage(
      "Entrance expenses",
    ),
    "subsidiaryAccount_eventRevenue": MessageLookupByLibrary.simpleMessage(
      "Direct event revenue",
    ),
    "subsidiaryAccount_feeExpenses": MessageLookupByLibrary.simpleMessage(
      "Bank fee expenses",
    ),
    "subsidiaryAccount_guestReceivables": MessageLookupByLibrary.simpleMessage(
      "Guest accounts (debtors)",
    ),
    "subsidiaryAccount_openingBalance": MessageLookupByLibrary.simpleMessage(
      "Opening balance",
    ),
    "subsidiaryAccount_otherExpenses": MessageLookupByLibrary.simpleMessage(
      "Other expenses",
    ),
    "subsidiaryAccount_otherPayables": MessageLookupByLibrary.simpleMessage(
      "Other accounts (creditors)",
    ),
    "subsidiaryAccount_otherReceivables": MessageLookupByLibrary.simpleMessage(
      "Other accounts (debtors)",
    ),
    "subsidiaryAccount_otherRevenue": MessageLookupByLibrary.simpleMessage(
      "Other revenue",
    ),
    "subsidiaryAccount_partnerEquity": MessageLookupByLibrary.simpleMessage(
      "Members and partners accounts",
    ),
    "subsidiaryAccount_salaryExpense": MessageLookupByLibrary.simpleMessage(
      "Salary and wages expenses",
    ),
    "subsidiaryAccount_saleDiscounts": MessageLookupByLibrary.simpleMessage(
      "Event discounts",
    ),
    "subsidiaryAccount_snacksExpenses": MessageLookupByLibrary.simpleMessage(
      "Catering expenses",
    ),
    "subsidiaryAccount_sponsorshipRevenue":
        MessageLookupByLibrary.simpleMessage("Sponsorship revenue"),
    "subsidiaryAccount_taxPayable": MessageLookupByLibrary.simpleMessage(
      "Tax payable accounts",
    ),
    "teamDetails_addFund": MessageLookupByLibrary.simpleMessage("Add fund"),
    "teamDetails_addMembers": MessageLookupByLibrary.simpleMessage(
      "Add new member",
    ),
    "teamDetails_editMembers": MessageLookupByLibrary.simpleMessage(
      "Edit member",
    ),
    "teamDetails_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no member added yet!",
    ),
    "teamDetails_noFundAdded": MessageLookupByLibrary.simpleMessage(
      "No fund has been added yet!",
    ),
    "teamDetials_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "Team\'s Member",
    ),
    "team_addTeam": MessageLookupByLibrary.simpleMessage("Add new team"),
    "team_appBarTitle": MessageLookupByLibrary.simpleMessage("Teams"),
    "team_editTeam": MessageLookupByLibrary.simpleMessage("Edit team"),
    "team_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no team added yet!",
    ),
    "textField_hint_advertising": MessageLookupByLibrary.simpleMessage(
      "Advertising",
    ),
    "textField_hint_bankName": MessageLookupByLibrary.simpleMessage("Pasargad"),
    "textField_hint_cardNumber": MessageLookupByLibrary.simpleMessage(
      "6021332542583648",
    ),
    "textField_hint_castAwayMovie": MessageLookupByLibrary.simpleMessage(
      "Cast Away Movie",
    ),
    "textField_hint_chocolateCake": MessageLookupByLibrary.simpleMessage(
      "Chocolate cake",
    ),
    "textField_hint_id": MessageLookupByLibrary.simpleMessage("@mahdiyar"),
    "textField_hint_mahdiyar": MessageLookupByLibrary.simpleMessage("Mahdiyar"),
    "textField_hint_mahdiyarArbabzi": MessageLookupByLibrary.simpleMessage(
      "Mahdiyar Arbabzi",
    ),
    "textField_hint_movieAnalyze": MessageLookupByLibrary.simpleMessage(
      "Movie Analyze",
    ),
    "textField_hint_phone": MessageLookupByLibrary.simpleMessage("09391543702"),
    "textField_hint_search": MessageLookupByLibrary.simpleMessage("Search"),
    "textField_hint_thisMonthSalary": MessageLookupByLibrary.simpleMessage(
      "This month salary",
    ),
    "textField_hint_zeinabJadidi": MessageLookupByLibrary.simpleMessage(
      "Zeinab Jadidi",
    ),
    "textField_label_amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "textField_label_birthday": MessageLookupByLibrary.simpleMessage(
      "Birthday",
    ),
    "textField_label_cardOrAccountNumber": MessageLookupByLibrary.simpleMessage(
      "Card / account number",
    ),
    "textField_label_date": MessageLookupByLibrary.simpleMessage("Date"),
    "textField_label_description": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "textField_label_discount": MessageLookupByLibrary.simpleMessage(
      "Discount",
    ),
    "textField_label_email": MessageLookupByLibrary.simpleMessage("Email"),
    "textField_label_finalAmount": MessageLookupByLibrary.simpleMessage(
      "Final amount",
    ),
    "textField_label_fundWalletName": MessageLookupByLibrary.simpleMessage(
      "Fund wallet name",
    ),
    "textField_label_generateFor": MessageLookupByLibrary.simpleMessage(
      "Generate for",
    ),
    "textField_label_grossAmount": MessageLookupByLibrary.simpleMessage(
      "Total amount without discount",
    ),
    "textField_label_instagramId": MessageLookupByLibrary.simpleMessage(
      "Instagram ID",
    ),
    "textField_label_joinAt": MessageLookupByLibrary.simpleMessage("Join at"),
    "textField_label_journalDescription": MessageLookupByLibrary.simpleMessage(
      "Journal description",
    ),
    "textField_label_name": MessageLookupByLibrary.simpleMessage("Name"),
    "textField_label_openingBalance": MessageLookupByLibrary.simpleMessage(
      "Opening balance",
    ),
    "textField_label_optional": MessageLookupByLibrary.simpleMessage(
      "(optional)",
    ),
    "textField_label_password": MessageLookupByLibrary.simpleMessage(
      "Password",
    ),
    "textField_label_payFromFundOptional": MessageLookupByLibrary.simpleMessage(
      "Pay from fund (optional)",
    ),
    "textField_label_paymentDate": MessageLookupByLibrary.simpleMessage(
      "Payment date",
    ),
    "textField_label_phone": MessageLookupByLibrary.simpleMessage("Phone"),
    "textField_label_ratio": MessageLookupByLibrary.simpleMessage("Ratio"),
    "textField_label_receiveToFundOptional":
        MessageLookupByLibrary.simpleMessage("Receive to fund (optional)"),
    "textField_label_relatedEventOptional":
        MessageLookupByLibrary.simpleMessage("Related event (optional)"),
    "textField_label_repeatPassword": MessageLookupByLibrary.simpleMessage(
      "Repeat Password",
    ),
    "textField_label_team": MessageLookupByLibrary.simpleMessage("Team"),
    "textField_label_telegramId": MessageLookupByLibrary.simpleMessage(
      "Telegram ID",
    ),
    "textField_label_title": MessageLookupByLibrary.simpleMessage("Title"),
    "textField_label_transferFee": MessageLookupByLibrary.simpleMessage(
      "Transfer fee",
    ),
    "transaction_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "There is no transaction added yet!",
    ),
    "validator_noMemberToAddTeam": MessageLookupByLibrary.simpleMessage(
      "• There is no member to add",
    ),
    "validator_passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "• Password not match",
    ),
    "validator_ratioCanNotMoreThan": m9,
    "validator_required": MessageLookupByLibrary.simpleMessage("• Required"),
    "validator_thereIsNoRatio": MessageLookupByLibrary.simpleMessage(
      "• There is no ratio to add",
    ),
    "warning_calculatingSalaryGoesWrong": MessageLookupByLibrary.simpleMessage(
      "Calculating members salary goes wrong!",
    ),
    "warning_operationFailure": MessageLookupByLibrary.simpleMessage(
      "Operation failed:",
    ),
    "warning_operationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Operation completed successfully!",
    ),
    "warning_selectEvent": MessageLookupByLibrary.simpleMessage(
      "Select event please!",
    ),
    "warning_somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong, try again later...",
    ),
  };
}
