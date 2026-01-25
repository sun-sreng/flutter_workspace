import 'package:flutter/material.dart';
import 'package:gmana_flutter/gmana_flutter.dart';

/// The main application widget.
class ColorExtensionExampleApp extends StatelessWidget {
  const ColorExtensionExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Extension Example',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue, // Default MaterialColor
      ),
      home: const ColorExtensionHomePage(),
    );
  }
}

/// The home page widget, demonstrating ColorExt functionalities.
class ColorExtensionHomePage extends StatefulWidget {
  const ColorExtensionHomePage({super.key});

  @override
  ColorExtensionHomePageState createState() => ColorExtensionHomePageState();
}

/// State for the home page, managing color selection and adjustments.
class ColorExtensionHomePageState extends State<ColorExtensionHomePage> {
  // Available base colors for selection (restricted to MaterialColor)
  final _colors = <String, MaterialColor>{
    'Red': Colors.red,
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Purple': Colors.purple,
  };

  // Current state
  String _selectedColorKey = 'Blue';
  double _lightnessAmount = ColorService.defaultAmount;
  bool _darken = false;
  double _opacity = 1.0;

  /// Updates the modified color based on current state.
  MaterialColor get _modifiedColor {
    var color = _colors[_selectedColorKey]!;
    // if (_darken) {
    //   color = color.darken(_lightnessAmount);
    // } else {
    //   color = color.lighten(_lightnessAmount);
    // }
    final adjustedColor = color.withAlphaOpacity(_opacity);
    return ColorService().createMaterialColor(adjustedColor);
  }

  @override
  Widget build(BuildContext context) {
    final modifiedColor = _modifiedColor;

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: modifiedColor, // Apply modified MaterialColor
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Color Extension Example'),
          backgroundColor:
              modifiedColor, // Works as MaterialColor extends Color
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Base color selection
              Text(
                'Select Base Color',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              DropdownButton<String>(
                value: _selectedColorKey,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedColorKey = newValue;
                    });
                  }
                },
                items:
                    _colors.keys.map<DropdownMenuItem<String>>((String key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              color: _colors[key],
                            ),
                            const SizedBox(width: 8),
                            Text(key),
                          ],
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 16),
              // Lightness adjustment
              Text(
                'Adjust Lightness (${_darken ? "Darken" : "Lighten"})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                children: [
                  const Text('Lighten'),
                  Switch(
                    value: _darken,
                    onChanged: (value) {
                      setState(() {
                        _darken = value;
                      });
                    },
                  ),
                  const Text('Darken'),
                ],
              ),
              Slider(
                value: _lightnessAmount,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: _lightnessAmount.toStringAsFixed(2),
                onChanged: (value) {
                  setState(() {
                    _lightnessAmount = value;
                  });
                },
              ),
              // Opacity adjustment
              Text(
                'Adjust Opacity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Slider(
                value: _opacity,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: _opacity.toStringAsFixed(2),
                onChanged: (value) {
                  setState(() {
                    _opacity = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Display modified color
              Container(
                width: double.infinity,
                height: 100,
                color: modifiedColor,
                child: Center(
                  child: Text(
                    'Modified Color',
                    style: TextStyle(
                      color: modifiedColor.contrastText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Display color properties
              Text(
                'Color Properties',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text('Hex: ${modifiedColor.toHex()}'),
              Text('Is Dark: ${modifiedColor.isDark}'),
              Text('Is Light: ${modifiedColor.isLight}'),
              Text('Contrast Text: ${modifiedColor.contrastText.toHex()}'),
              Text('Opacity: ${_opacity.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
