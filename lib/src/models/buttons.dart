import 'package:flutter/material.dart';

class CustomButtons extends StatefulWidget {
  const CustomButtons({
    super.key,
    this.firstButtonIcon,
    this.centerButtonIcon,
    this.endButtonIcon,
    this.firstButtonPressed,
    this.secondButtonPressed,
    this.thirdButtonPressed,
    this.color200,
    this.color400,
    this.color900,
  });

  final IconData? firstButtonIcon;
  final IconData? centerButtonIcon;
  final IconData? endButtonIcon;
  final VoidCallback? firstButtonPressed;
  final VoidCallback? secondButtonPressed;
  final VoidCallback? thirdButtonPressed;
  final Color? color200, color400, color900;

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: widget.firstButtonPressed,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: widget.color200,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                widget.firstButtonIcon,
                size: 32,
                color: widget.color900,
              ),
            ),
          ),
          TextButton(
            onPressed: widget.secondButtonPressed,
            child: Container(
              width: 108,
              height: 86,
              decoration: BoxDecoration(
                color: widget.color400,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                widget.centerButtonIcon,
                size: 42,
                color: widget.color900,
              ),
            ),
          ),
          TextButton(
            onPressed: widget.thirdButtonPressed,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: widget.color200,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                widget.endButtonIcon,
                size: 32,
                color: widget.color900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
