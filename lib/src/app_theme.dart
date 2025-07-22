import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get lightTheme;
  ThemeData get darkTheme;
}

class MySpaceTheme extends AppTheme {
  final double? borderRadius;
  final ColorScheme _colorSchemeLight;
  final Color? _scaffoldBackgroundColorLight;
  final ColorScheme _colorSchemeDark;
  final Color? _scaffoldBackgroundColorDark;

  MySpaceTheme({
    this.borderRadius,
    ColorScheme? colorSchemeDark,
    ColorScheme? colorSchemeLight,
    Color? scaffoldBackgroundColorLight,
    Color? scaffoldBackgroundColorDark,
  }) : _colorSchemeDark = colorSchemeDark ?? const ColorScheme.dark(),
       _colorSchemeLight = colorSchemeLight ?? const ColorScheme.light(),
       _scaffoldBackgroundColorLight = scaffoldBackgroundColorLight,
       _scaffoldBackgroundColorDark = scaffoldBackgroundColorDark;

  final _textThemeLight = ThemeData.light().textTheme;
  final _textThemeDark = ThemeData.dark().textTheme;

  late final _border = RoundedRectangleBorder(
    borderRadius: borderRadius != null
        ? BorderRadius.circular(borderRadius!)
        : BorderRadius.zero,
  );

  //! Filled Button Theme Data

  late final _filledButtonThemeDataLight = FilledButtonThemeData(
    style: FilledButton.styleFrom(shape: _border),
  );
  late final _filledButtonThemeDataDark = FilledButtonThemeData(
    style: FilledButton.styleFrom(shape: _border),
  );

  //? Filled Button Theme Data End

  //! Outlined Button Theme Data

  late final _outlinedButtonThemeDataLight = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.grey.shade500),
      shape: _border,
    ),
  );
  late final _outlinedButtonThemeDataDark = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(shape: _border),
  );

  //? Outlined Button Theme Data End

  //! Text Button Theme Data

  late final _textButtonThemeDataLight = TextButtonThemeData(
    style: TextButton.styleFrom(shape: _border),
  );
  late final _textButtonThemeDataDark = TextButtonThemeData(
    style: TextButton.styleFrom(shape: _border),
  );

  //? Text Button Theme Data End

  //! Icon Button Theme Data

  late final _iconButtonThemeDataLight = IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: _border,
      backgroundColor: _colorSchemeLight.primary,
      foregroundColor: _colorSchemeLight.onPrimary,
    ),
  );
  late final _iconButtonThemeDataDark = IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: _border,
      backgroundColor: _colorSchemeDark.primary,
      foregroundColor: _colorSchemeDark.onPrimary,
    ),
  );

  //? Icon Button Theme Data End

  //! Input Theme Data Start

  late final _textFieldThemeDataLight = InputDecorationTheme(
    filled: true,
    // contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    fillColor: _colorSchemeLight.surface,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: TextStyle(
      // fontSize: 14,
      color: _colorSchemeLight.onSurface.withValues(alpha: 0.38),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _colorSchemeLight.primary, width: 1.5),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _colorSchemeLight.error, width: 1),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _colorSchemeLight.error, width: 1),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 1),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
  );
  late final _textFieldThemeDataDark = InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    fillColor: _colorSchemeDark.surfaceContainer,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: TextStyle(
      fontSize: 14,
      color: _colorSchemeDark.onSurface.withValues(alpha: 0.38),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _colorSchemeDark.primary, width: 1.5),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _colorSchemeDark.error, width: 1),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _colorSchemeDark.error, width: 1),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _colorSchemeDark.outline, width: 1),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
      borderRadius: _border.borderRadius as BorderRadius,
    ),
  );

  //? Input Theme Data End

  //! Dropdown Menu Theme Data Start

  late final _dropdownMenuThemeDataLight = DropdownMenuThemeData(
    inputDecorationTheme: _textFieldThemeDataLight,
    menuStyle: MenuStyle(
      side: WidgetStatePropertyAll(
        BorderSide(color: _colorSchemeLight.outline),
      ),
    ),
  );
  late final _dropdownMenuThemeDataDark = DropdownMenuThemeData(
    inputDecorationTheme: _textFieldThemeDataDark,
    menuStyle: MenuStyle(
      side: WidgetStatePropertyAll(BorderSide(color: _colorSchemeDark.outline)),
    ),
  );

  //? Dropdown Menu Theme Data End

  //! Popup Menu Theme Data Start

  late final _popupMenuThemeDataLight = PopupMenuThemeData(
    shape: _border,
    position: PopupMenuPosition.under,
    elevation: 4,
  );
  late final _popupMenuThemeDataDark = PopupMenuThemeData(
    shape: _border,
    position: PopupMenuPosition.under,
    elevation: 4,
  );

  //? Popup Menu Theme Data End

  //! Card Theme Data Start

  late final _cardThemeDataLight = CardThemeData(
    shape: RoundedRectangleBorder(borderRadius: _border.borderRadius),
  );
  late final _cardThemeDataDark = CardThemeData(
    shape: RoundedRectangleBorder(borderRadius: _border.borderRadius),
  );

  //? Card Theme Data End

  //! Expansion Panel Theme Data Start

  late final _expansionPanelThemeDataLight = ExpansionTileThemeData(
    backgroundColor: _colorSchemeLight.surfaceContainerHighest,
    collapsedBackgroundColor: _colorSchemeLight.surfaceContainerHighest,
    shape: RoundedRectangleBorder(borderRadius: _border.borderRadius / 2),
    collapsedShape: RoundedRectangleBorder(borderRadius: _border.borderRadius),
  );
  late final _expansionPanelThemeDataDark = ExpansionTileThemeData(
    backgroundColor: _colorSchemeDark.surfaceContainerHighest,
    collapsedBackgroundColor: _colorSchemeDark.surfaceContainerHighest,
    shape: RoundedRectangleBorder(borderRadius: _border.borderRadius / 2),
    collapsedShape: RoundedRectangleBorder(borderRadius: _border.borderRadius),
  );

  //? Expansion Panel Theme Data End

  //! Slider Theme Data Start

  late final _sliderThemeDataLight = SliderThemeData(
    activeTrackColor: _colorSchemeLight.primary,
    inactiveTrackColor: _colorSchemeLight.primaryFixedDim,
  );
  late final _sliderThemeDataDark = SliderThemeData(
    activeTrackColor: _colorSchemeDark.primary,
    inactiveTrackColor: _colorSchemeDark.primaryFixedDim,
  );

  //? Slider Theme Data End

  //! AppBar Theme Data Start

  late final _appBarThemeDataLight = AppBarTheme(
    backgroundColor: _colorSchemeLight.surface,
    // color: _colorSchemeLight.surface,
    elevation: 0,
  );

  //? AppBar Theme Data End

  //! Floating Action Button Theme Data Start

  late final _floatingActionButtonThemeDataLight =
      FloatingActionButtonThemeData(
        backgroundColor: _colorSchemeLight.primary,
        foregroundColor: _colorSchemeLight.onPrimary,
      );

  //? Floating Action Button Theme Data End

  //! Bottom Navigation Bar Theme Data Start

  late final _bottomNavigationBarThemeDataLight = BottomNavigationBarThemeData(
    backgroundColor: _colorSchemeLight.surface,
    selectedItemColor: _colorSchemeLight.primary,
    unselectedItemColor: _colorSchemeLight.onSurfaceVariant,
  );

  //? Bottom Navigation Bar Theme Data End

  //! Divider Theme Data Start

  late final _dividerThemeDataLight = DividerThemeData(
    color: Colors.grey.shade400,
  );

  //? Divider Theme Data End

  //? Dialog Theme Data Start

  late final _dialogThemeDataLight = DialogThemeData(
    shape: RoundedRectangleBorder(borderRadius: _border.borderRadius),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _colorSchemeLight.onSurface,
    ),
  );

  //? Dialog Theme Data End

  @override
  late final ThemeData lightTheme = ThemeData.light().copyWith(
    dividerTheme: _dividerThemeDataLight,
    floatingActionButtonTheme: _floatingActionButtonThemeDataLight,
    scaffoldBackgroundColor:
        _scaffoldBackgroundColorLight ?? _colorSchemeLight.surface,
    appBarTheme: _appBarThemeDataLight,
    colorScheme: _colorSchemeLight,
    textTheme: _textThemeLight,
    filledButtonTheme: _filledButtonThemeDataLight,
    outlinedButtonTheme: _outlinedButtonThemeDataLight,
    textButtonTheme: _textButtonThemeDataLight,
    iconButtonTheme: _iconButtonThemeDataLight,
    inputDecorationTheme: _textFieldThemeDataLight,
    dropdownMenuTheme: _dropdownMenuThemeDataLight,
    popupMenuTheme: _popupMenuThemeDataLight,
    cardTheme: _cardThemeDataLight,
    expansionTileTheme: _expansionPanelThemeDataLight,
    sliderTheme: _sliderThemeDataLight,
    bottomNavigationBarTheme: _bottomNavigationBarThemeDataLight,
    dialogTheme: _dialogThemeDataLight,
  );

  @override
  late final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor:
        _scaffoldBackgroundColorDark ?? _colorSchemeDark.surface,
    colorScheme: _colorSchemeDark,
    textTheme: _textThemeDark,
    filledButtonTheme: _filledButtonThemeDataDark,
    outlinedButtonTheme: _outlinedButtonThemeDataDark,
    textButtonTheme: _textButtonThemeDataDark,
    iconButtonTheme: _iconButtonThemeDataDark,
    inputDecorationTheme: _textFieldThemeDataDark,
    dropdownMenuTheme: _dropdownMenuThemeDataDark,
    popupMenuTheme: _popupMenuThemeDataDark,
    cardTheme: _cardThemeDataDark,
    expansionTileTheme: _expansionPanelThemeDataDark,
    sliderTheme: _sliderThemeDataDark,
  );
}
