import 'package:fixottobuddy_techni/Screens/TechnicianScreens/StoreScreens/AllProductsScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/StoreScreens/ProductDetailScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class TechnicianStoreScreen extends StatelessWidget {
  const TechnicianStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> categories = [
      {'title': 'CAR CARE & MAINTENANCE', 'subtitle': 'Keep Your Car Clean and New', 'image': ImageAssets.bannerOne},
      {'title': 'SAFETY & SECURITY', 'subtitle': 'Protect Your Car and Passengers Always', 'image': ImageAssets.bannerTwo},
      {'title': 'GO SHINE', 'subtitle': 'Style. Care. Performance. Customized', 'image': ImageAssets.bannerThree},
      {'title': 'TOWING VAN SERVICES', 'subtitle': 'Fast and reliable towing anytime, anywhere', 'image': ImageAssets.bannerFour},
      {'title': 'SAFETY & SECURITY', 'subtitle': 'Protect Your Car and Passengers Always', 'image': ImageAssets.bannerFive},
      {'title': 'CAR CARE & MAINTENANCE', 'subtitle': 'Keep Your Car Clean and New', 'image': ImageAssets.bannerSix},
      {'title': 'GO SHINE', 'subtitle': 'Style. Care. Performance. Customized', 'image': ImageAssets.bannerSeven},
    ];

    final List<Map<String, dynamic>> topProducts = [
      {'name': 'Fresco Drift Car Seat Cover', 'price': '₹ 2000', 'discount': '25% OFF', 'image': ImageAssets.seatName},
      {'name': 'Fresco Drift Car Seat Cover', 'price': '₹ 2000', 'discount': null, 'image': ImageAssets.seatName},
      {'name': 'Fresco Drift Car Seat Cover', 'price': '₹ 2000', 'discount': '25% OFF', 'image': ImageAssets.seatName},
      {'name': 'Fresco Drift Car Seat Cover', 'price': '₹ 2000', 'discount': null, 'image': ImageAssets.seatName},
    ];

    return Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Back button + Title ──
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: width * 0.1,
                          height: width * 0.1,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_back_rounded,
                              color: isDarkMode ? Colors.white : Colors.black87, size: width * 0.05),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'My Store',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.1),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  Text(
                    'Car Category',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildCategoryCard(
                          context,
                          categories[0],
                          height * 0.3,
                          isDarkMode,
                          width,
                          height,
                        ),
                      ),
                      SizedBox(width: width * 0.025),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildCategoryCard(
                              context,
                              categories[1],
                              height * 0.145,
                              isDarkMode,
                              width,
                              height,
                            ),
                            SizedBox(height: height * 0.01),
                            _buildCategoryCard(
                              context,
                              categories[2],
                              height * 0.145,
                              isDarkMode,
                              width,
                              height,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  _buildCategoryCard(
                    context,
                    categories[3],
                    height * 0.15,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.02),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildCategoryCard(
                          context,
                          categories[4],
                          height * 0.3,
                          isDarkMode,
                          width,
                          height,
                        ),
                      ),
                      SizedBox(width: width * 0.025),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildCategoryCard(
                              context,
                              categories[5],
                              height * 0.145,
                              isDarkMode,
                              width,
                              height,
                            ),
                            SizedBox(height: height * 0.01),
                            _buildCategoryCard(
                              context,
                              categories[6],
                              height * 0.145,
                              isDarkMode,
                              width,
                              height,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.025),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Products',
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllProductsScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.015),

                  SizedBox(
                    height: height * 0.26,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: topProducts.length,
                      itemBuilder: (context, index) => _buildProductCard(
                        context,
                        topProducts[index],
                        isDarkMode,
                        width,
                        height,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildCategoryCard(
      BuildContext context,
      Map<String, dynamic> category,
      double cardHeight,
      bool isDarkMode,
      double width,
      double height,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AllProductsScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(category['image'], fit: BoxFit.cover),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: cardHeight * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['title'],
                        style: TextStyle(
                          fontSize: cardHeight < height * 0.15 ? width * 0.03 : width * 0.035,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: height * 0.003),
                      Text(
                        category['subtitle'],
                        style: TextStyle(
                          fontSize: cardHeight < height * 0.15 ? width * 0.02 : width * 0.025,
                          color: Colors.white.withOpacity(0.85),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context,
      Map<String, dynamic> product,
      bool isDarkMode,
      double width,
      double height,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailScreen(),
          ),
        );
      },
      child: Container(
        width: width * 0.42,
        margin: EdgeInsets.only(right: width * 0.03),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: height * 0.13,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.06)
                    : Colors.grey.shade50,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      product['image'],
                      width: width * 0.2,
                      height: height * 0.1,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (product['discount'] != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product['discount'],
                          style: TextStyle(
                            fontSize: width * 0.025,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: height * 0.006),
                  Text(
                    product['price'],
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Row(
                    children: List.generate(
                      4,
                          (_) => Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}