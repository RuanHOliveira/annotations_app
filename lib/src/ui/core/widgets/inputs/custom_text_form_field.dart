import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? enabled;
  final EdgeInsets? padding;
  final ValueChanged<String>? onChanged;
  final ValueSetter<PointerEvent>? onTapOutside;
  final VoidCallback? onEditingComplete;
  final AutovalidateMode? autovalidateMode;
  final double borderRadius;
  final bool labelTextUppercase;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final TextInputAction? textInputAction;
  final Color? fillColor;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.enabled,
    this.padding,
    this.onTapOutside,
    this.onChanged,
    this.onEditingComplete,
    this.autovalidateMode,
    this.borderRadius = 12,
    this.labelTextUppercase = false,
    this.maxLines = 1,
    this.expands = false,
    this.fillColor,
    this.textInputAction,
    this.minLines,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  OutlineInputBorder _outline(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final enabled = widget.enabled ?? true;

    return Padding(
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: TextFormField(
        autovalidateMode: widget.autovalidateMode,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        minLines: widget.expands ? null : widget.minLines,
        maxLines: widget.expands ? null : widget.maxLines,
        expands: widget.expands,
        onEditingComplete:
            widget.onEditingComplete ??
            () {
              final isMultiline =
                  widget.expands ||
                  (widget.maxLines != null && widget.maxLines! > 1);
              if (isMultiline) return;
              FocusScope.of(context).nextFocus();
            },

        onTapOutside:
            widget.onTapOutside ??
            (_) {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            },
        enabled: enabled,
        controller: widget.controller,
        validator: widget.validator,
        style: AppTextStyles.text14.copyWith(color: cs.primary),
        inputFormatters: widget.inputFormatters,
        keyboardType:
            widget.keyboardType ??
            ((widget.maxLines != null && widget.maxLines! > 1) || widget.expands
                ? TextInputType.multiline
                : TextInputType.text),
        obscureText: widget.obscureText ?? false,
        maxLength: widget.maxLength,
        cursorColor: cs.primary,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          filled: true,
          fillColor: widget.fillColor ?? cs.secondary,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: cs.primary),
          labelText: widget.labelTextUppercase
              ? widget.labelText?.toUpperCase()
              : widget.labelText,
          labelStyle: TextStyle(
            color: cs.primary,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
          ),

          // bordas: arredondadas, transparentes por padrão
          border: _outline(Colors.transparent),
          enabledBorder: _outline(Colors.transparent),
          disabledBorder: _outline(Colors.transparent),

          // foco e erro visíveis
          focusedBorder: _outline(cs.primary, width: 1),
          errorBorder: _outline(cs.error),
          focusedErrorBorder: _outline(cs.error, width: 1),

          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          counterText: widget.maxLength == null ? '' : null,
        ),
      ),
    );
  }
}
