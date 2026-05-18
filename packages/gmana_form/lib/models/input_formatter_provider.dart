import 'package:flutter/services.dart';

/// Interface for providing input formatters.
abstract class InputFormatterProvider {
  List<TextInputFormatter> getFormatters();
}
