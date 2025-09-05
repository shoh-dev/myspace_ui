import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

extension UIConfigurationHelper on BuildContext {
  UiConfiguration get uiConfiguration => read();
}

class UiConfiguration extends ChangeNotifier {
  /// Currency format used for displaying currency values in [TextComponent.currency]
  NumberFormat _currencyFormat = NumberFormat.compactSimpleCurrency(
    locale: 'en_US',
    decimalDigits: 2,
  );
  NumberFormat get currencyFormat => _currencyFormat;
  void changeCurrencyFormat(NumberFormat newFormat, [bool notify = true]) {
    if (_currencyFormat != newFormat) {
      _currencyFormat = newFormat;
      if (notify) notifyListeners();
    }
  }

  /// Date format used for displaying dates in [TextComponent.date]
  DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat get dateFormat => _dateFormat;
  void changeDateFormat(DateFormat newFormat, [bool notify = true]) {
    if (_dateFormat != newFormat) {
      _dateFormat = newFormat;
      if (notify) notifyListeners();
    }
  }

  /// Number format
  NumberFormat _numberFormat = NumberFormat.decimalPattern();
  NumberFormat get numberFormat => _numberFormat;
  void changeNumberFormat(NumberFormat newFormat, [bool notify = true]) {
    if (_numberFormat != newFormat) {
      _numberFormat = newFormat;
      if (notify) notifyListeners();
    }
  }
}
