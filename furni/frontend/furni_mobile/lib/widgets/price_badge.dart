part of widgets;

class PriceBadge extends StatelessWidget {
  const PriceBadge({
    super.key,
    required this.price,
  });
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
      ),
      width: 72,
      height: 35,
      child: Center(child: Text('$price\$')),
    );
  }
}
