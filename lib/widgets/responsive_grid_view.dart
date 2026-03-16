import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final double spacing;
  final double runSpacing;
  final ScrollController? scrollController;

  const ResponsiveGridView({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(16),
    this.spacing = 16,
    this.runSpacing = 16,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.getGridColumns(context);

    return SingleChildScrollView(
      controller: scrollController,
      padding: padding,
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: List.generate(
          children.length,
          (index) => SizedBox(
            width:
                (MediaQuery.of(context).size.width -
                    (padding.horizontal) -
                    (spacing * (columns - 1))) /
                columns,
            child: children[index],
          ),
        ),
      ),
    );
  }
}
