import 'package:flutter/material.dart';

import '../models/field_config.dart';

abstract class GBaseField extends StatelessWidget {
  final GFieldConfig config;

  const GBaseField({super.key, required this.config});

  @override
  Widget build(BuildContext context);
}
