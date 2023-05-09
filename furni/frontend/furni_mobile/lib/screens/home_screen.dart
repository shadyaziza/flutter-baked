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
              return ItemCard(item: item);
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
