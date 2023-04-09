import 'package:flutter/material.dart';
import 'package:pomodoro/src/models/switch_colors.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.indexOf,
    required this.onPressed,
    required this.text,
  });

  final int indexOf;
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            widget.icon,
            color: colorData900(widget.indexOf),
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: colorData900(widget.indexOf),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
