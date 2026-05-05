import 'package:flutter/material.dart';

class HomeFeatureScreen extends StatelessWidget {
  const HomeFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("رحاب"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///  Title
            Text("مرحبًا بك في رحاب", style: text.titleLarge),

            const SizedBox(height: 20),

            ///  Search
            TextField(
              decoration: InputDecoration(
                hintText: "ابحثي عن سكن...",
                prefixIcon: const Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 20),

            /// Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.home, color: colors.primary, size: 40),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("سكن مريح وآمن", style: text.titleMedium),
                          const SizedBox(height: 6),
                          Text(
                            "مثالي للطالبات في الرياض",
                            style: text.bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "1200 ر.س",
                      style: text.titleMedium?.copyWith(
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ///  Button
            ElevatedButton(
              onPressed: () {},
              child: const Text("احجز الآن"),
            ),

            const SizedBox(height: 20),

            ///  Colors Preview
            Row(
              children: [
                _colorBox(colors.primary),
                _colorBox(colors.secondary),
                _colorBox(colors.surface),
              ],
            ),
          ],
        ),
      ),

      /// Bottom Nav
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "المفضلة",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "حسابي",
          ),
        ],
      ),
    );
  }
}

Widget _colorBox(Color color) {
  return Expanded(
    child: Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}