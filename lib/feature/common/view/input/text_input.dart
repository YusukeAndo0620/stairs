import 'package:stairs/loom/loom_package.dart';

// const _kContentPadding = EdgeInsets.all(8.0);
const _kInputBorderRadius = BorderRadius.all(Radius.circular(10.0));
const _kMaxWidth = 1200.0;
const _kBorderWidth = 1.0;

@immutable
class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    this.width = _kMaxWidth,
    this.icon,
    required this.textController,
    this.inputType = TextInputType.text,
    required this.hintText,
    this.maxLines = 1,
    this.maxLength = 100,
    this.autoFocus = false,
    this.isReadOnly = false,
    required this.onSubmitted,
    this.onChanged,
  });
  final double width;
  final Icon? icon;
  final TextEditingController textController;
  final TextInputType inputType;
  final String hintText;
  final int maxLines;
  final int maxLength;
  final bool autoFocus;
  final bool isReadOnly;
  final Function(String) onSubmitted;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(
      () {
        if (!focusNode.hasFocus) {
          widget.onSubmitted(widget.textController.text);
        }
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.width),
      child: TextField(
        key: ValueKey(widget.textController.hashCode),
        controller: widget.textController,
        style: theme.textStyleBody,
        enabled: !widget.isReadOnly,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        cursorColor: theme.colorSecondary,
        keyboardType: widget.inputType,
        textInputAction: TextInputAction.done,
        autofocus: widget.autoFocus,
        focusNode: focusNode,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        onSubmitted: (value) {
          widget.onSubmitted(value);
          FocusScope.of(context).unfocus();
        },
        onEditingComplete: () {
          widget.onSubmitted(widget.textController.text);
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          icon: widget.icon != null ? widget.icon! : null,
          counterText: '',
          hintStyle: theme.textStyleFootnote,
          hintText: widget.hintText,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: _kInputBorderRadius,
            borderSide: BorderSide(
              width: _kBorderWidth,
              color: theme.colorPrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: _kInputBorderRadius,
            borderSide: BorderSide(
              width: _kBorderWidth,
              color: theme.colorFgDisabled,
            ),
          ),
        ),
      ),
    );
  }
}
