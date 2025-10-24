import 'package:flutter/material.dart';
import '../../theme/colors/ecommerce_colors.dart';
import '../../theme/typography/ecommerce_typography.dart';

/// Product Card for e-commerce and retail apps
/// Displays product information with image, price, and actions
class ProductCard extends StatelessWidget {
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final double? originalPrice;
  final double? rating;
  final int? reviewCount;
  final String? category;
  final bool isOnSale;
  final bool isNew;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onAddToCart;
  final VoidCallback? onQuickView;

  const ProductCard({
    super.key,
    required this.name,
    this.description,
    this.imageUrl,
    required this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.category,
    this.isOnSale = false,
    this.isNew = false,
    this.isFavorite = false,
    this.onTap,
    this.onFavorite,
    this.onAddToCart,
    this.onQuickView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      decoration: BoxDecoration(
        color: EcommerceColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: EcommerceColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImageSection(), _buildContentSection()],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            color: EcommerceColors.background,
          ),
          child: imageUrl != null
              ? ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholderImage(),
                  ),
                )
              : _buildPlaceholderImage(),
        ),
        _buildBadges(),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: EcommerceColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: const Icon(
        Icons.image,
        size: 48,
        color: EcommerceColors.textSecondary,
      ),
    );
  }

  Widget _buildBadges() {
    return Positioned(
      top: 8,
      left: 8,
      child: Row(
        children: [
          if (isNew) _buildBadge('NEW', EcommerceColors.success),
          if (isOnSale && originalPrice != null)
            _buildBadge('SALE', EcommerceColors.error),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: EcommerceTypography.badgeText.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Positioned(
      top: 8,
      right: 8,
      child: Column(
        children: [
          _buildActionButton(
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite
                ? EcommerceColors.error
                : EcommerceColors.textSecondary,
            onPressed: onFavorite,
          ),
          const SizedBox(height: 4),
          _buildActionButton(
            icon: Icons.visibility,
            color: EcommerceColors.textSecondary,
            onPressed: onQuickView,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: EcommerceColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: 16),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (category != null) ...[
            Text(category!, style: EcommerceTypography.categoryText),
            const SizedBox(height: 4),
          ],
          Text(
            name,
            style: EcommerceTypography.productTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: EcommerceTypography.productDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 8),
          _buildRatingSection(),
          const SizedBox(height: 8),
          _buildPriceSection(),
          const SizedBox(height: 12),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    if (rating == null) return const SizedBox.shrink();

    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < (rating! / 2).floor() ? Icons.star : Icons.star_border,
              size: 14,
              color: EcommerceColors.warning,
            );
          }),
        ),
        const SizedBox(width: 4),
        Text(rating!.toStringAsFixed(1), style: EcommerceTypography.ratingText),
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          Text('($reviewCount)', style: EcommerceTypography.reviewCountText),
        ],
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text('\$${_formatPrice(price)}', style: EcommerceTypography.priceText),
        if (originalPrice != null && originalPrice! > price) ...[
          const SizedBox(width: 8),
          Text(
            '\$${_formatPrice(originalPrice!)}',
            style: EcommerceTypography.originalPriceText,
          ),
        ],
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: EcommerceColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text('Add to Cart', style: EcommerceTypography.buttonText),
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }
}

/// Product Grid for displaying multiple products
class ProductGrid extends StatelessWidget {
  final List<ProductCard> products;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const ProductGrid({
    super.key,
    required this.products,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.75,
    this.crossAxisSpacing = 8.0,
    this.mainAxisSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => products[index],
    );
  }
}

/// Product List Item for horizontal scrolling
class ProductListItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double price;
  final double? originalPrice;
  final double? rating;
  final bool isOnSale;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductListItem({
    super.key,
    required this.name,
    this.imageUrl,
    required this.price,
    this.originalPrice,
    this.rating,
    this.isOnSale = false,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: EcommerceColors.surface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: EcommerceColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImageSection(), _buildContentSection()],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        color: EcommerceColors.background,
      ),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderImage(),
              ),
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: EcommerceColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: const Icon(
        Icons.image,
        size: 32,
        color: EcommerceColors.textSecondary,
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: EcommerceTypography.productTitle.copyWith(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _buildPriceSection(),
          const SizedBox(height: 8),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          '\$${_formatPrice(price)}',
          style: EcommerceTypography.priceText.copyWith(fontSize: 14),
        ),
        if (originalPrice != null && originalPrice! > price) ...[
          const SizedBox(width: 4),
          Text(
            '\$${_formatPrice(originalPrice!)}',
            style: EcommerceTypography.originalPriceText.copyWith(fontSize: 10),
          ),
        ],
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: EcommerceColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          'Add',
          style: EcommerceTypography.buttonText.copyWith(fontSize: 10),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }
}
