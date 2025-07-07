import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PopupMenuButtonComponent<T> extends StatelessWidget {
  const PopupMenuButtonComponent({
    super.key,
    required this.items,
    this.onSelected,
    this.child,
    this.tooltip = '',
  });

  final Iterable<DropdownItem<T>> items;
  final ValueChanged<DropdownItem<T>?>? onSelected;
  final String tooltip;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<DropdownItem<T>>(
      position: PopupMenuPosition.under,
      tooltip: tooltip,
      onSelected: onSelected,
      borderRadius: context.borderRadius,
      itemBuilder: (context) {
        return [
          for (final item in items) ...[
            PopupMenuItem(
              value: item,
              height: 32,
              child: item.icon != null
                  ? PointerInterceptor(
                      child: Theme(
                        data: context.theme.copyWith(
                          iconTheme: context.theme.iconTheme.copyWith(
                            size: context.theme.popupMenuTheme.iconSize,
                            color: item.foregroundColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            item.icon!,
                            Text(
                              item.label,
                              style: TextStyle(color: item.foregroundColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  : PointerInterceptor(
                      child: Text(
                        item.label,
                        style: TextStyle(color: item.foregroundColor),
                      ),
                    ),
            ),
            if (item != items.last) const PopupMenuDivider(height: 0),
          ],
        ];
      },
      child: child != null
          ? AbsorbPointer(absorbing: true, child: child)
          : null,
    );
  }
}
