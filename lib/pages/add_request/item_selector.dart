import 'package:flutter/material.dart';

class ItemSelectorFormField<T> extends FormField<List<T>> {
  ItemSelectorFormField({
    super.key,
    required String title,
    required AlertDialog addItemDialog,
    required void Function(List<T> items) onChanged,
    required Widget Function(T item) itemConverter,
    super.validator,
  }) : super(
          builder: (FormFieldState<List<T>> state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ItemSelector<T>(
                title: title,
                addItemDialog: addItemDialog,
                onChanged: (List<T> items) {
                  state.didChange(items);
                  onChanged(items);
                },
                itemConverter: itemConverter,
              ),
              if (state.hasError)
                Builder(
                  builder: (BuildContext context) {
                    return Text(
                      state.errorText!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    );
                  },
                ),
            ],
          ),
        );
}

class ItemSelector<T> extends StatefulWidget {
  const ItemSelector({
    super.key,
    required this.title,
    required this.addItemDialog,
    required this.onChanged,
    required this.itemConverter,
  });

  final String title;
  final AlertDialog addItemDialog;
  final void Function(List<T> items) onChanged;
  final Widget Function(T item) itemConverter;

  @override
  State<ItemSelector<T>> createState() => _ItemSelectorState<T>();
}

class _ItemSelectorState<T> extends State<ItemSelector<T>> {
  final List<T> items = <T>[];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    widget.onChanged(items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            IconButton(
              iconSize: 24.0,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(
                const Size(24.0, 24.0),
              ),
              onPressed: () async {
                final T? item = await showDialog<T?>(
                  context: context,
                  builder: (BuildContext context) => widget.addItemDialog,
                );

                if (item != null) {
                  setState(() {
                    items.add(item);
                  });
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        ...items.map(
          (T e) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.itemConverter(e),
                IconButton(
                  iconSize: 16.0,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tight(
                    const Size(16.0, 16.0),
                  ),
                  onPressed: () {
                    setState(() {
                      items.remove(e);
                    });
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
