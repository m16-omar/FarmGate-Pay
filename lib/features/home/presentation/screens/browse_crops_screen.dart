import 'package:flutter/material.dart';

class BrowseCropsScreen extends StatefulWidget {
  const BrowseCropsScreen({super.key});

  @override
  State<BrowseCropsScreen> createState() => _BrowseCropsScreenState();
}

class _BrowseCropsScreenState extends State<BrowseCropsScreen> {
  String _selectedCategory = 'All Crops';
  final String _sortBy = 'Popularity';

  final List<Map<String, dynamic>> _allCrops = [
    {
      'name': 'Maize',
      'category': 'Grains',
      'unit': 'per kg',
      'orders': '1,250+ orders',
      'isPopular': true,
      'emoji': '🌽',
      'isFavorite': false,
    },
    {
      'name': 'Rice',
      'category': 'Grains',
      'unit': 'per kg',
      'orders': '980+ orders',
      'isPopular': true,
      'emoji': '🌾',
      'isFavorite': false,
    },
    {
      'name': 'Tomato',
      'category': 'Vegetables',
      'unit': 'per kg',
      'orders': '860+ orders',
      'isPopular': true,
      'emoji': '🍅',
      'isFavorite': false,
    },
    {
      'name': 'Yam',
      'category': 'Tubers',
      'unit': 'per kg',
      'orders': '720+ orders',
      'isPopular': false,
      'emoji': '🥔',
      'isFavorite': false,
    },
    {
      'name': 'Groundnut',
      'category': 'Legumes',
      'unit': 'per kg',
      'orders': '680+ orders',
      'isPopular': false,
      'emoji': '🥜',
      'isFavorite': false,
    },
    {
      'name': 'Pepper',
      'category': 'Vegetables',
      'unit': 'per kg',
      'orders': '560+ orders',
      'isPopular': false,
      'emoji': '🌶️',
      'isFavorite': false,
    },
    {
      'name': 'Cassava',
      'category': 'Tubers',
      'unit': 'per kg',
      'orders': '520+ orders',
      'isPopular': false,
      'emoji': '🍠',
      'isFavorite': false,
    },
    {
      'name': 'Cucumber',
      'category': 'Vegetables',
      'unit': 'per kg',
      'orders': '480+ orders',
      'isPopular': false,
      'emoji': '🥒',
      'isFavorite': false,
    },
    {
      'name': 'Onion',
      'category': 'Vegetables',
      'unit': 'per kg',
      'orders': '460+ orders',
      'isPopular': false,
      'emoji': '🧅',
      'isFavorite': false,
    },
    {
      'name': 'Plantain',
      'category': 'Others',
      'unit': 'per kg',
      'orders': '430+ orders',
      'isPopular': false,
      'emoji': '🍌',
      'isFavorite': false,
    },
    {
      'name': 'Beans',
      'category': 'Legumes',
      'unit': 'per kg',
      'orders': '410+ orders',
      'isPopular': false,
      'emoji': '🫘',
      'isFavorite': false,
    },
    {
      'name': 'Cabbage',
      'category': 'Vegetables',
      'unit': 'per kg',
      'orders': '390+ orders',
      'isPopular': false,
      'emoji': '🥬',
      'isFavorite': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredCrops {
    if (_selectedCategory == 'All Crops') {
      return _allCrops;
    }
    return _allCrops.where((crop) => crop['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final crops = _filteredCrops;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header (Back Arrow, Title, Subtitle, Search Icon)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Browse Crops',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Explore all crops available on GreenMart',
                          style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Color(0xFF333333)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // 2. Horizontal Filter Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  _buildCategoryChip('All Crops', Icons.grid_view),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Grains', Icons.grain),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Vegetables', Icons.eco_outlined),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Tubers', Icons.grass_outlined),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Legumes', Icons.spa_outlined),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Others', Icons.apps_outlined),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 3. Section Title & Sort By Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Sort by ',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              _sortBy,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                            ),
                            const Icon(Icons.keyboard_arrow_down, size: 14, color: Color(0xFF2E7D32)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 4. Main Scrollable Crops Grid + Bottom Request Banner
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: crops.length,
                    itemBuilder: (context, index) {
                      final crop = crops[index];
                      return _buildCropCard(crop);
                    },
                  ),
                  const SizedBox(height: 20),

                  // 5. Request Crop Banner
                  _buildRequestCropBanner(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    bool isSelected = _selectedCategory == label;
    Color bg = isSelected ? const Color(0xFFE8F5E9) : Colors.white;
    Color borderCol = isSelected ? const Color(0xFF81C784) : const Color(0xFFE2E2DF);
    Color contentCol = isSelected ? const Color(0xFF2E7D32) : const Color(0xFF444444);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderCol),
        ),
        child: Row(
          children: [
            Icon(icon, color: contentCol, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: contentCol),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCropCard(Map<String, dynamic> crop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Badge & Heart Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (crop['isPopular'] == true)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Popular',
                    style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                  ),
                )
              else
                const SizedBox.shrink(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    crop['isFavorite'] = !(crop['isFavorite'] as bool);
                  });
                },
                child: Icon(
                  crop['isFavorite'] == true ? Icons.favorite : Icons.favorite_border,
                  size: 14,
                  color: crop['isFavorite'] == true ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Crop Illustration
          Expanded(
            child: Center(
              child: Text(
                crop['emoji'],
                style: const TextStyle(fontSize: 34),
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Title & Unit
          Text(
            crop['name'],
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          Text(
            crop['unit'],
            style: const TextStyle(fontSize: 9, color: Colors.grey),
          ),
          const SizedBox(height: 4),

          // Orders Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.eco_outlined, size: 8, color: Color(0xFF2E7D32)),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    crop['orders'],
                    style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCropBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        children: [
          const Text('🧺', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Can't find what you need?",
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
                SizedBox(height: 2),
                Text(
                  "Tell us the crop you're looking for and we'll help you source it.",
                  style: TextStyle(fontSize: 9, color: Colors.grey, height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Crop sourcing request submitted!'),
                  backgroundColor: Color(0xFF2E7D32),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2E7D32),
              side: const BorderSide(color: Color(0xFF2E7D32)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            child: const Text('Request Crop', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
