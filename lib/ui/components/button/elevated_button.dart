import 'package:flutter/material.dart';
import 'package:patrol_challenge/ui/style/colors.dart';
import 'package:patrol_challenge/ui/style/test_style.dart';
import 'package:patrol_challenge/ui/widgets/utils.dart';

class PTElevatedButton extends StatelessWidget {
  const PTElevatedButton({
    super.key,
    this.caption,
    this.trailing,
    required this.onPressed,
  });

  final String? caption;
  final Widget? trailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final caption = this.caption;
    final trailing = this.trailing;

    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: _textStyle,
          backgroundColor: _backgroundColor,
          padding: _padding,
          shape: _shape,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: trailing != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (caption != null) Center(child: Text(caption)),
            if (trailing != null)
              Align(
                alignment: Alignment.centerRight,
                child: trailing,
              ),
          ],
        ).horizontallyPadded24,
      ),
    );
  }

  WidgetStateProperty<EdgeInsetsGeometry?>? get _padding =>
      const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12));

  WidgetStateProperty<OutlinedBorder?>? get _shape =>
      const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      );

  WidgetStateProperty<Color?>? get _backgroundColor =>
      WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return PTColors.lcYellowPressed;
          } else if (states.contains(WidgetState.disabled)) {
            return PTColors.backgroundDisabled;
          }

          return PTColors.lcYellow;
        },
      );

  WidgetStateProperty<TextStyle?>? get _textStyle =>
      WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return PTTextStyles.bodyMedium
                .copyWith(foreground: Paint()..color = PTColors.textDark);
          } else if (states.contains(WidgetState.disabled)) {
            return PTTextStyles.bodyMedium
                .copyWith(foreground: Paint()..color = PTColors.textDisabled);
          }

          return PTTextStyles.bodyBold
              .copyWith(foreground: Paint()..color = PTColors.textDark);
        },
      );
}
