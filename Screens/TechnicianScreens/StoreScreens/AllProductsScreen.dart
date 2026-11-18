import 'package:fixottobuddy_techni/Screens/TechnicianScreens/StoreScreens/ProductDetailScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  static final List<Map<String, dynamic>> products = [
    {'name': 'Fresco Drift Car\nSeat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': '25% OFF', 'image': ImageAssets.seatName},
    {'name': 'Fresco Drift Car Seat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': null, 'image': ImageAssets.seatName},
    {'name': 'Fresco Drift Car Seat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': '25% OFF', 'image': ImageAssets.seatName},
    {'name': 'Fresco Drift Car Seat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': null, 'image': ImageAssets.seatName},
    {'name': 'Fresco Drift Car Seat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': '25% OFF', 'image': ImageAssets.seatName},
    {'name': 'Fresco Drift Car Seat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': null, 'image': ImageAssets.seatName},
    {'name': 'Fresco Drift Car Seat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': '25% OFF', 'image': ImageAssets.seatName},
    {'name': 'Fresco Drift Car Seat Cover', 'rating': 4.0, 'price': '₹ 2000', 'discount': null, 'image': ImageAssets.seatName},
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppColor.getOnboardingGradient(brightness) : null,
          color: isDarkMode ? null : const Color(0xFFF6F6F6),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_rounded,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            size: width * 0.06),
                      ),
                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: Text(
                          'Car Care & Maintenance',
                          style: TextStyle(
                            fontSize: width * 0.048,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Banner
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      ImageAssets.careBanner,
                      width: double.infinity,
                      height: height * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  Text(
                    'All Products',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.012),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 230,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) => _buildProductCard(
                        context, products[index], isDarkMode, width, height),
                  ),

                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product,
      bool isDarkMode, double width, double height) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProductDetailScreen()),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: AppColor.primary.withOpacity(0.05),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  Center(child: Image.asset(product['image'], width: width * 0.22, fit: BoxFit.contain)),
                  if (product['discount'] != null)
                    Positioned(
                      top: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                        child: Text(product['discount'], style: TextStyle(fontSize: width * 0.025, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                ],
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name'],
                        style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w500,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(children: List.generate(5, (i) => Icon(Icons.star_rounded,
                        color: i < 4 ? Colors.amber : Colors.grey.shade300, size: width * 0.03))),
                    const Spacer(),
                    Text(product['price'],
                        style: TextStyle(fontSize: width * 0.032, fontWeight: FontWeight.w700, color: AppColor.primary)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}