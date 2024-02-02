import 'package:stairs/loom/loom_package.dart';

const _kIndicatorSpaceWidth = 12.0;
const _kIndicatorSize = 10.0;

class CarouselDisplay extends StatelessWidget {
  const CarouselDisplay({
    Key? key,
    required this.displayedWidgetIdx,
    required this.widgets,
    required this.controller,
    this.indicatorColor,
  }) : super(key: key);
  final int displayedWidgetIdx;
  final List<Widget> widgets;
  final ScrollController controller;
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final spaceWidth = MediaQuery.of(context).size.width * 0.05;
    final color = indicatorColor ?? theme.colorDisabled;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          child: Row(
            children: [
              if (widgets.length == 1)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: widgets[0],
                )
              else ...[
                SizedBox(
                  width: spaceWidth * 3,
                ),
                for (final item in widgets) ...[
                  item,
                  SizedBox(
                    width: spaceWidth,
                  ),
                ]
              ],
              if (widgets.length != 1)
                SizedBox(
                  width: spaceWidth * 2,
                ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widgets.length; i++) ...[
                _Indicator(
                  indicatorColor:
                      i == displayedWidgetIdx ? color : theme.colorFgDisabled,
                ),
                if (i != widgets.length - 1)
                  const SizedBox(
                    width: _kIndicatorSpaceWidth,
                  ),
              ]
            ],
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
