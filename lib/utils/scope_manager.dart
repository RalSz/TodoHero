import 'package:flutter/material.dart';

class ScopeManager extends StatelessWidget {
  final List<Widget Function(Widget child)> scopes;
  final Widget child;

  const ScopeManager({super.key, required this.scopes, required this.child});

  @override
  Widget build(BuildContext context) {
    var tree = child;
    for (final wrap in scopes.reversed)
    {
      tree = wrap(tree);
    }
    return tree;
  }
}