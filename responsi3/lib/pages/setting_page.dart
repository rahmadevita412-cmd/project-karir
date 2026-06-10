import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/custom_drawer.dart';
import 'profile_page.dart';
import '../theme/app_theme.dart'; 

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool get isDark => !isLightTheme.value;

  Color get bgColor =>
      isDark ? const Color(0xFF121212) : Colors.white;

  Color get cardColor {
    if (isDark) return const Color(0xFF1E1E1E);
    return const Color(0xFFE8EDF7);
  }

  Color get textColor =>
      isDark ? Colors.white : Colors.black;

  Color get subTextColor =>
      isDark ? Colors.white70 : const Color(0xFF666666);

  String colorToHex(Color c) {
    return "#${c.value.toRadixString(16).substring(2).toUpperCase()}";
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      return Color(int.parse("FF$hex", radix: 16));
    }
    return primaryColor.value;
  }

  final TextEditingController hexController = TextEditingController();

  final List<Map<String, dynamic>> colors = [
    {"name": "Red", "color": const Color(0xFFD32F2F)},
    {"name": "Green", "color": const Color(0xFF2E7D32)},
    {"name": "Blue", "color": const Color(0xFF1565C0)},
    {"name": "Pink", "color": const Color(0xFFC2185B)},
    {"name": "Yellow", "color": const Color(0xFFF9A825)},
    {"name": "Orange", "color": const Color(0xFFEF6C00)},
    {"name": "Purple", "color": const Color(0xFF8E24AA)},
    {"name": "Deeppurple", "color": const Color(0xFF5E35B1)},
    {"name": "Lightblue", "color": const Color(0xFF039BE5)},
    {"name": "Teal", "color": const Color(0xFF00695C)},
    {"name": "Lime", "color": const Color(0xFF827717)},
    {"name": "Deeporange", "color": const Color(0xFFD84315)},
  ];

  @override
  void initState() {
    super.initState();
    hexController.text = colorToHex(primaryColor.value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    
    return ValueListenableBuilder<bool>(
      valueListenable: isLightTheme, 
      builder: (context, isLightMode, _) {
        return ValueListenableBuilder<Color>(
          valueListenable: primaryColor,
          builder: (context, selectedColor, child) {
            return Scaffold(
              backgroundColor: bgColor,
              drawer: const CustomDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: textColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  "Color Themes",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                actions: [
                  Builder(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selectedColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.tune,
                            color: textColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 24,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Layout Themes",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1565C0))),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selectedColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Framework7 comes with 2 main layout themes: Light (default) and Dark:",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(child: _themeBox(true)),
                                  const SizedBox(width: 12),
                                  Expanded(child: _themeBox(false)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text("Default Color Themes",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1565C0))),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selectedColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Framework7 comes with 12 color themes set.",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: colors.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isMobile ? 2 : isTablet ? 3 : 4,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 3.5,
                                ),
                                itemBuilder: (_, i) {
                                  final item = colors[i];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        primaryColor.value = item["color"];
                                        hexController.text = colorToHex(item["color"]);
                                      });
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: item["color"],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        item["name"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text("Custom Color Theme",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1565C0))),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selectedColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "HEX Color",
                                style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: _showColorPickerDialog,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: selectedColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      controller: hexController,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                      onSubmitted: (value) {
                                        setState(() {
                                          primaryColor.value = hexToColor(value);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.3),
                                height: 20,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: selectedColor.withOpacity(0.15),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _bottomNavItem(
                            icon: Icons.mail,
                            label: "Inbox",
                            onTap: () {},
                          ),
                          _bottomNavItem(
                            icon: Icons.calendar_today,
                            label: "Calendar",
                            badge: "5",
                            onTap: () {},
                          ),
                          _bottomNavItem(
                            icon: Icons.cloud_upload,
                            label: "Upload",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _bottomNavItem({
    required IconData icon,
    required String label,
    String? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color: textColor,
                size: 24,
              ),
              if (badge != null)
                Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPickerDialog() {
    Color tempColor = primaryColor.value;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: SizedBox(
                height: 400,
                width: 400,
                child: _CircularColorPicker(
                  color: tempColor,
                  onColorChanged: (color) {
                    setDialogState(() {
                      tempColor = color;
                    });
                    setState(() {
                      primaryColor.value = tempColor;
                      hexController.text = colorToHex(tempColor);
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _themeBox(bool light) {
    bool selected = isLightTheme.value == light;

    return GestureDetector(
      onTap: () {
        isLightTheme.value = light; 
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: light ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: selected
            ? const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, bottom: 12),
                  child: Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    hexController.dispose();
    super.dispose();
  }
}

// 🎨 CUSTOM CIRCULAR COLOR PICKER
class _CircularColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const _CircularColorPicker({
    required this.color,
    required this.onColorChanged,
  });

  @override
  State<_CircularColorPicker> createState() => _CircularColorPickerState();
}

class _CircularColorPickerState extends State<_CircularColorPicker> {
  late double hue;
  late double saturation;
  late double brightness;

  @override
  void initState() {
    super.initState();
    _updateHSB(widget.color);
  }

  void _updateHSB(Color color) {
    final hsb = _rgbToHsv(color);
    hue = hsb[0];
    saturation = hsb[1];
    brightness = hsb[2];
  }

  List<double> _rgbToHsv(Color color) {
    final r = color.red / 255.0;
    final g = color.green / 255.0;
    final b = color.blue / 255.0;

    final max = [r, g, b].reduce((a, b) => a > b ? a : b);
    final min = [r, g, b].reduce((a, b) => a < b ? a : b);
    final delta = max - min;

    double hue = 0.0;
    if (delta != 0) {
      if (max == r) {
        hue = 60 * (((g - b) / delta) % 6);
      } else if (max == g) {
        hue = 60 * (((b - r) / delta) + 2);
      } else {
        hue = 60 * (((r - g) / delta) + 4);
      }
    }

    if (hue < 0) hue += 360;

    final saturation = max == 0 ? 0.0 : (delta / max);
    final brightness = max;

    return [hue, saturation, brightness];
  }

  Color _hsvToRgb(double hue, double saturation, double brightness) {
    final c = brightness * saturation;
    final x = c * (1 - ((hue / 60) % 2 - 1).abs());
    final m = brightness - c;

    late double r, g, b;

    if (hue < 60) {
      r = c;
      g = x;
      b = 0;
    } else if (hue < 120) {
      r = x;
      g = c;
      b = 0;
    } else if (hue < 180) {
      r = 0;
      g = c;
      b = x;
    } else if (hue < 240) {
      r = 0;
      g = x;
      b = c;
    } else if (hue < 300) {
      r = x;
      g = 0;
      b = c;
    } else {
      r = c;
      g = 0;
      b = x;
    }

    return Color.fromARGB(
      255,
      ((r + m) * 255).toInt(),
      ((g + m) * 255).toInt(),
      ((b + m) * 255).toInt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        const center = Offset(200, 200);
        final position = details.localPosition;
        final dx = position.dx - center.dx;
        final dy = position.dy - center.dy;
        final distance = sqrt(dx * dx + dy * dy);
        final angle = atan2(dy, dx) * 180 / pi + 90;

        if (distance < 160) {
          setState(() {
            hue = angle % 360;
            saturation = (distance / 160).clamp(0.0, 1.0);
            final color = _hsvToRgb(hue, saturation, brightness);
            widget.onColorChanged(color);
          });
        } else if (distance < 180 && distance > 140) {
          setState(() {
            hue = angle % 360;
            final color = _hsvToRgb(hue, 1.0, brightness);
            widget.onColorChanged(color);
          });
        }
      },
      child: CustomPaint(
        painter: _CircularColorWheelPainter(
          hue: hue,
          saturation: saturation,
          brightness: brightness,
        ),
        size: const Size(400, 400),
      ),
    );
  }
}

class _CircularColorWheelPainter extends CustomPainter {
  final double hue;
  final double saturation;
  final double brightness;

  _CircularColorWheelPainter({
    required this.hue,
    required this.saturation,
    required this.brightness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 160.0;
    const innerRadius = 140.0;

    for (int i = 0; i < 360; i += 1) {
      final angle = i * pi / 180;
      final x = cos(angle - pi / 2);
      final y = sin(angle - pi / 2);

      for (double r = innerRadius; r < radius; r += 0.5) {
        final sat = (r - innerRadius) / (radius - innerRadius);
        final colorHsv = HSVColor.fromAHSV(1.0, i.toDouble(), sat, 1.0);

        final paint = Paint()
          ..color = colorHsv.toColor()
          ..style = PaintingStyle.fill;

        final px = center.dx + x * r;
        final py = center.dy + y * r;
        canvas.drawCircle(Offset(px, py), 1.5, paint);
      }
    }

    final saturationPaint = Paint();
    const squareSize = 160.0;
    for (int x = 0; x < squareSize.toInt(); x += 1) {
      for (int y = 0; y < squareSize.toInt(); y += 1) {
        final px = (x / squareSize);
        final py = (y / squareSize);
        final colorHsv = HSVColor.fromAHSV(1.0, hue, px, 1 - py);
        saturationPaint.color = colorHsv.toColor();

        canvas.drawRect(
          Rect.fromLTWH(
            center.dx - 80 + x.toDouble(),
            center.dy - 80 + y.toDouble(),
            1,
            1,
          ),
          saturationPaint,
        );
      }
    }

    final selectorPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.white;

    final selectedX = center.dx - 80 + (saturation * squareSize);
    final selectedY = center.dy - 80 + ((1 - brightness) * squareSize);

    canvas.drawCircle(Offset(selectedX, selectedY), 8, selectorPaint);

    final hueAngle = hue * pi / 180 - pi / 2;
    const hueDistance = (innerRadius + radius) / 2;
    final hueX = center.dx + cos(hueAngle) * hueDistance;
    final hueY = center.dy + sin(hueAngle) * hueDistance;

    canvas.drawCircle(Offset(hueX, hueY), 10, selectorPaint);
  }

  @override
  bool shouldRepaint(_CircularColorWheelPainter oldDelegate) {
    return oldDelegate.hue != hue ||
        oldDelegate.saturation != saturation ||
        oldDelegate.brightness != brightness;
  }
}