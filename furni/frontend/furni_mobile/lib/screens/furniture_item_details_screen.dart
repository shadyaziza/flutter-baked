part of screens;

final itemDetails =
    FutureProvider.family<FurnitureItemDetails, int>((ref, id) async {
  final res = await http.get(Uri.parse('http://localhost:4242/furnitures/$id'));

  final jsonRes = json.decode(res.body);

  return FurnitureItemDetails.fromJson(jsonRes);
});

class FurnitureItemDetailsScreenArgs {
  final int itemId;

  FurnitureItemDetailsScreenArgs(this.itemId);
}

class FurnitureItemDetailsScreen extends ConsumerWidget {
  const FurnitureItemDetailsScreen({super.key});
  static const routeName = '/details';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments
        as FurnitureItemDetailsScreenArgs;
    final item = ref.watch(itemDetails(args.itemId));
    return Scaffold(
      appBar: AppBar(),
      body: item.when(
        data: (item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 31),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://source.unsplash.com/collection/1163637/480x480')),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      PriceBadge(
                        price: 200,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                Row(
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.itemNameColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.teal,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.teal,
                          ),
                        ),
                        const Text('1'),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.redAccent,
                            ),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Available Colors',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xffD9752A),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xff122381),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xff0F0F0E),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xffF52424),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Dimensions',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${item.depth}"D x ${item.width}"W x ${item.height}"H',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Style',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  item.style,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      ' Add to cart',
                      textScaleFactor: 1.4,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.buttonLabelColor,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
              ],
            ),
          );
        },
        error: (_, __) => const Center(
          child: Text('Error'),
        ),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
