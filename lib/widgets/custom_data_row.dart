import 'package:flutter/material.dart';

class CustomDataRow extends StatelessWidget {
  const CustomDataRow({
    super.key,
    required this.label,
    required this.text,
    this.onEdit,
  });

  final String label;
  final String text;
  final Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 100.0,
          ),
          child: Text(label),
        ),
        Flexible(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.end,
                ),
              ),
              if (onEdit != null) ...<Widget>{
                const SizedBox(
                  width: 8.0,
                ),
                IconButton(
                  iconSize: 16.0,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tight(
                    const Size(16.0, 16.0),
                  ),
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                )
              }
            ],
          ),
        ),
      ],
    );
  }
}
