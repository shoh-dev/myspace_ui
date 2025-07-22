import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

extension UIConfigurationHelper on BuildContext {
  UiConfiguration get uiConfiguration => read();
}

class UiConfiguration extends ChangeNotifier {
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
}
