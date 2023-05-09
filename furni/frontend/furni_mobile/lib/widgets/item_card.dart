part of widgets;

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
  });

  final FurnitureListItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        FurnitureItemDetailsScreen.routeName,
        arguments: FurnitureItemDetailsScreenArgs(
          item.id,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  item.imageUrl,
                ),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            height: 212,
            width: 177,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceBadge(price: item.price),
                    Container(
                      margin: const EdgeInsets.only(right: 8, top: 8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      width: 26,
                      height: 26,
                      child: const Icon(
                        Icons.add_shopping_cart,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: const Color(0xff000000).withOpacity(0.1),
                  )
                ],
                color: const Color(0xffffffff).withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: 44,
              width: 177,
              child: Center(
                child: Text(
                  item.name,
                  textScaleFactor: 1.2,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
