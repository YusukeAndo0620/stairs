import 'package:stairs/loom/loom_package.dart';

const _kIndicatorSpaceWidth = 12.0;
const _kIndicatorSize = 10.0;

class CarouselDisplay extends StatefulWidget {
  const CarouselDisplay({
    Key? key,
    required this.widgets,
    required this.controller,
    this.indicatorColor,
  }) : super(key: key);
  final List<Widget> widgets;
  final PageController controller;
  final Color? indicatorColor;
  @override
  State<StatefulWidget> createState() => _CarouselDisplayState();
}

class _CarouselDisplayState extends State<CarouselDisplay> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final color = widget.indicatorColor ?? theme.colorDisabled;

    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        PageView(
          controller: widget.controller,
          children: widget.widgets,
          onPageChanged: (pageIndex) {
            setState(() {
              currentPage = pageIndex;
            });
          },
        ),
        Align(
          alignment: const Alignment(0, 0.95), // 相対的な表示位置を決める。
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.widgets.length; i++) ...[
                  _Indicator(
                    indicatorColor:
                        i == currentPage ? color : theme.colorFgDisabled,
                  ),
                  if (i != widget.widgets.length - 1)
                    const SizedBox(
                      width: _kIndicatorSpaceWidth,
                    ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
    this.indicatorColor,
  }) : super(key: key);
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final color = indicatorColor ?? theme.colorDisabled;
    return ColorBox(
      color: color,
      size: _kIndicatorSize,
    );
  }
}
