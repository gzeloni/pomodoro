import 'package:flutter/material.dart';
import 'package:pomodoro/src/models/switch_colors.dart';

class SettingsButtons extends StatefulWidget {
  const SettingsButtons({
    super.key,
    required this.indexOf,
    required this.upPressed,
    required this.downPressed,
    required this.text,
    required this.duration,
  });

  final int indexOf;
  final String text;
  final String duration;
  final VoidCallback? upPressed;
  final VoidCallback? downPressed;

  @override
  State<SettingsButtons> createState() => _SettingsButtonsState();
}

class _SettingsButtonsState extends State<SettingsButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            color: colorData900(widget.indexOf),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: 70,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: colorData800(widget.indexOf), width: 0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorData800(widget.indexOf),
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
                child: Text(
                  widget.duration.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: colorData900(widget.indexOf), fontSize: 20),
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorData800(widget.indexOf),
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: TextButton(
                      onPressed: widget.upPressed,
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 14,
                        color: colorData800(widget.indexOf),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorData800(widget.indexOf),
                      ),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8)),
                    ),
                    child: TextButton(
                      onPressed: widget.downPressed,
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 14,
                        color: colorData800(widget.indexOf),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
