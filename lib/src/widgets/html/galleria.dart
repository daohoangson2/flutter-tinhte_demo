part of '../html.dart';

const kColumns = 3;
const kSpacing = 3.0;

class Galleria {
  final TinhteWidgetFactory wf;

  BuildOp _buildOp;

  Galleria(this.wf);

  BuildOp get buildOp {
    _buildOp ??= BuildOp(
      onWidgets: (meta, iterable) {
        final widgets = iterable.toList();
        final rows = (widgets.length / kColumns).ceil();
        final List<Widget> newWidgets = List();

        for (int r = 0; r < rows; r++) {
          final List<Widget> rowWidgets = List();
          for (int c = 0; c < kColumns; c++) {
            final i = r * kColumns + c;
            if (i < widgets.length) {
              rowWidgets.add(Expanded(child: widgets[i]));
            }

            if (c < kColumns - 1) {
              rowWidgets.add(SizedBox(width: kSpacing));
            }
          }

          newWidgets.add(Row(children: rowWidgets));
          newWidgets.add(SizedBox(height: kSpacing));
        }

        return newWidgets;
      },
    );

    return _buildOp;
  }
}
