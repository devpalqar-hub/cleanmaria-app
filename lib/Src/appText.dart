import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class appText {
  static Widget primaryText(
      {required var text,
      int? maxLines,
      FontWeight? fontWeight,
      Color? color,
      TextAlign? align,
      FontStyle? fontStyle,
      double? lineHeight,
      double? fontSize}) {
    return Text(
      text.toString(),
      maxLines: maxLines,
      textAlign: align,
      style: GoogleFonts.poppins(
          height: lineHeight,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color),
    );
  }
}
