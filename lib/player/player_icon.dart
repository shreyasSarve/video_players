part of player_widget;

class PlayerIcon extends StatelessWidget {
  const PlayerIcon({
    super.key,
    required this.cofiguration,
    required this.iconData,
    this.onPressed,
  });
  final PlayerIconCofiguration cofiguration;
  final IconData iconData;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        iconData,
        color: cofiguration.color,
        size: cofiguration.size,
      ),
    );
  }
}
