import 'package:stairs/loom/loom_package.dart';

// const _kContentPadding = EdgeInsets.all(8.0);
const _kInputBorderRadius = BorderRadius.all(Radius.circular(10.0));
const _kMaxWidth = 1200.0;
const _kBorderWidth = 1.0;

@immutable
class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    this.icon,
    required this.textController,
    this.inputType = TextInputType.text,
    required this.hintText,
    this.maxLength = 100,
    this.autoFocus = false,
    required this.onSubmitted,
  });
  final Icon? icon;
  final TextEditingController textController;
  final TextInputType inputType;
  final String hintText;
  final int maxLength;
  final bool autoFocus;
  final Function(String) onSubmitted;

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
      constraints: const BoxConstraints(maxWidth: _kMaxWidth),
      child: TextField(
        key: ValueKey(widget.textController.hashCode),
        controller: widget.textController,
        style: theme.textStyleBody,
        maxLength: widget.maxLength,
        cursorColor: theme.colorSecondary,
        keyboardType: widget.inputType,
        textInputAction: TextInputAction.done,
        autofocus: widget.autoFocus,
        focusNode: focusNode,
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
