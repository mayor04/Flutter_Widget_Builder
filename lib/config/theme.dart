import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = _baseTheme(_lightColorScheme);

  static ThemeData darkTheme = _baseTheme(_darkColorScheme);

  static final _darkColorScheme = const ColorScheme.dark().copyWith(
    background: AppColors.appDark,
  );

  static const _lightColorScheme = ColorScheme.light();

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: GoogleFonts.robotoTextTheme(
        _textTheme(colorScheme),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.appDark.withOpacity(0.7),
        border: _inputBorder(),
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(color: AppColors.focusedBorder),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.appDark.withOpacity(0.7),
        thickness: 1,
        endIndent: 0,
        indent: 0,
        space: 1,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: AppDecoration.radius(
          color: Colors.black.withOpacity(0.5),
          radius: 3,
        ),
        height: 28,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        waitDuration: const Duration(milliseconds: 200),
        textStyle: TextStyle(
          fontSize: 11,
          color: Colors.grey[200],
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.iconColor,
        size: 23,
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.hardEdge,
        elevation: 7,
        color: AppColors.appGrey,
        shadowColor: AppColors.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     maximumSize: const Size.fromHeight(46),
      //     textStyle: GoogleFonts.(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(6),
      //     ),
      //   ),
      // ),
    );
  }

  static InputBorder _inputBorder({Color color = AppColors.inputBorder}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(2),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    );
  }

  //TODO: implement for dark mode
  static TextTheme _textTheme(ColorScheme colorScheme) {
    return const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w300,
        // color: AppColors.bodyMedium,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        // color: AppColors.bodyMedium,
      ),
      titleMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w300,
        // color: AppColors.shadowColor,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        // color: AppColors.labelSmall,
      ),
    );
  }
}
