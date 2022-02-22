import 'package:flutter/material.dart';

class ActionRibbon extends StatelessWidget {
  final bool transparent;
  final Axis orientation;
  final bool isLiked;
  final bool isFavorite;
  final VoidCallback onLikePressed;
  final VoidCallback onFavoritesPressed;
  final double smallestSize;
  const ActionRibbon({
    Key? key,
    this.transparent = false,
    this.orientation = Axis.vertical,
    required this.isLiked,
    required this.isFavorite,
    required this.onLikePressed,
    required this.onFavoritesPressed,
    this.smallestSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orientation == Axis.horizontal ? _horizontal() : _vertical();
  }

  List<Widget> _buttons() {
    return [
      GestureDetector(
        onTap: onLikePressed,
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_outline,
          color: Colors.red,
          size: smallestSize,
        ),
      ),
      GestureDetector(
        onTap: onFavoritesPressed,
        child: Icon(
          isFavorite ? Icons.star : Icons.star_outline,
          color: Colors.red,
          size: smallestSize,
        ),
      ),
    ];
  }

  Widget _vertical() {
    return Container(
      width: smallestSize,
      height: smallestSize * 2,
      decoration: transparent
          ? null
          : BoxDecoration(
        color: Colors.white.withAlpha(180),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        children: _buttons(),
      ),
    );
  }

  Widget _horizontal() {
    return Container(
      height: smallestSize,
      width: smallestSize * 2,
      decoration: transparent
          ? null
          : BoxDecoration(
        color: Colors.white.withAlpha(179),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: _buttons(),
      ),
    );
  }
}
