import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/furniture_requirements.dart';

class FurnitureRequirementsSelector extends StatefulWidget {
  const FurnitureRequirementsSelector({
    super.key,
    required this.onChanged,
  });

  final void Function(Set<FurnitureRequirements>, String) onChanged;

  @override
  State<FurnitureRequirementsSelector> createState() =>
      FurnitureRequirementsSelectorState();
}

class FurnitureRequirementsSelectorState
    extends State<FurnitureRequirementsSelector> {
  final Set<FurnitureRequirements> _requirements = <FurnitureRequirements>{};
  final TextEditingController _otherController = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    widget.onChanged(_requirements, _otherController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.specialRequirements,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            ...FurnitureRequirements.values
                .where(
                  (FurnitureRequirements element) =>
                      element != FurnitureRequirements.other,
                )
                .map(
                  (FurnitureRequirements e) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                        value: _requirements.contains(e),
                        onChanged: (bool? selected) {
                          setState(() {
                            if (selected ?? false) {
                              _requirements.add(e);
                            } else {
                              _requirements.remove(e);
                            }
                          });
                        },
                      ),
                      Text(e.translate(context)),
                    ],
                  ),
                ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: _requirements.contains(FurnitureRequirements.other),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected ?? false) {
                        _requirements.add(FurnitureRequirements.other);
                      } else {
                        _requirements.remove(FurnitureRequirements.other);
                        _otherController.clear();
                      }
                    });
                  },
                ),
                Flexible(
                  child: TextField(
                    controller: _otherController,
                    onChanged: (String value) {
                      widget.onChanged(_requirements, value);
                    },
                    enabled:
                        _requirements.contains(FurnitureRequirements.other),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.other,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
