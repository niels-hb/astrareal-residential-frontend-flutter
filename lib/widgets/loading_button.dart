import 'package:flutter/material.dart';

class LoadingButton<T> extends StatefulWidget {
  const LoadingButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final Future<T> Function() onPressed;

  @override
  State<LoadingButton<T>> createState() => _LoadingButtonState<T>();
}

class _LoadingButtonState<T> extends State<LoadingButton<T>> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _loading
          ? null
          : () async {
              setState(() {
                _loading = true;
              });

              try {
                await widget.onPressed();
              } finally {
                setState(() {
                  _loading = false;
                });
              }
            },
      child: Visibility(
        visible: !_loading,
        replacement: const CircularProgressIndicator.adaptive(),
        child: widget.child,
      ),
    );
  }
}
