part of screens;

final listItems = FutureProvider<List<FurnitureListItem>>((ref) async {
  final res = await http.get(Uri.parse('http://localhost:4242/furnitures'));

  final jsonRes = json.decode(res.body)['furnitures'] as List;

  return List<FurnitureListItem>.from(
      jsonRes.map((item) => FurnitureListItem.fromJson(item))).toList();
});

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 23.0,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              snap: true,
              floating: true,
              pinned: false,
              stretch: true,
              title: Image.asset(
                AppAssets.logo,
                height: 50,
                width: double.infinity,
              ),
            ),
            const SliverToBoxAdapter(child: FurnitureList())
          ],
        ),
      ),
    );
  }
}

class FurnitureList extends ConsumerWidget {
  const FurnitureList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listItems);
    final h = MediaQuery.of(context).size.height;
    return list.when(
      data: (data) {
        return Container(
          height: h,
          padding: const EdgeInsets.only(bottom: 200),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 28, mainAxisSpacing: 20),
            itemCount: 13,
            itemBuilder: (context, index) {
              final item = data[index];
              return InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  FurnitureItemDetailsScreen.routeName,
                  arguments: FurnitureItemDetailsScreenArgs(
                    index,
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
            },
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text('Error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
