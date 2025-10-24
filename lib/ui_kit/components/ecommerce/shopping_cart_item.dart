import 'package:flutter/material.dart';
import '../../theme/colors/ecommerce_colors.dart';
import '../../theme/typography/ecommerce_typography.dart';

/// Shopping Cart Item for e-commerce apps
/// Displays cart item with quantity controls and actions
class ShoppingCartItem extends StatelessWidget {
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final int quantity;
  final String? size;
  final String? color;
  final bool isAvailable;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveToWishlist;
  final ValueChanged<int>? onQuantityChanged;

  const ShoppingCartItem({
    super.key,
    required this.name,
    this.description,
    this.imageUrl,
    required this.price,
    required this.quantity,
    this.size,
    this.color,
    this.isAvailable = true,
    this.onRemove,
    this.onMoveToWishlist,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: EcommerceColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isAvailable
              ? EcommerceColors.border
              : EcommerceColors.error.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            _buildImageSection(),
            const SizedBox(width: 12),
            Expanded(child: _buildContentSection()),
            _buildActionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: EcommerceColors.background,
      ),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image,
        size: 32,
        color: EcommerceColors.textSecondary,
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: EcommerceTypography.productTitle.copyWith(fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(
            description!,
            style: EcommerceTypography.productDescription.copyWith(
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 4),
        _buildVariantInfo(),
        const SizedBox(height: 8),
        _buildPriceAndAvailability(),
      ],
    );
  }

  Widget _buildVariantInfo() {
    return Row(
      children: [
        if (size != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: EcommerceColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Size: $size', style: EcommerceTypography.variantText),
          ),
          const SizedBox(width: 8),
        ],
        if (color != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: EcommerceColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Color: $color',
              style: EcommerceTypography.variantText,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPriceAndAvailability() {
    return Row(
      children: [
        Text(
          '\$${_formatPrice(price)}',
          style: EcommerceTypography.priceText.copyWith(fontSize: 16),
        ),
        const SizedBox(width: 8),
        if (!isAvailable)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: EcommerceColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Out of Stock',
              style: EcommerceTypography.statusText.copyWith(
                color: EcommerceColors.error,
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionSection() {
    return Column(
      children: [
        _buildQuantityControls(),
        const SizedBox(height: 8),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildQuantityControls() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: EcommerceColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantity > 1
                ? () => onQuantityChanged?.call(quantity - 1)
                : null,
            icon: const Icon(Icons.remove, size: 16),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              quantity.toString(),
              style: EcommerceTypography.quantityText,
            ),
          ),
          IconButton(
            onPressed: () => onQuantityChanged?.call(quantity + 1),
            icon: const Icon(Icons.add, size: 16),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        IconButton(
          onPressed: onMoveToWishlist,
          icon: const Icon(Icons.favorite_border, size: 16),
          tooltip: 'Move to Wishlist',
        ),
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.delete_outline, size: 16),
          tooltip: 'Remove',
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }
}

/// Shopping Cart Summary for checkout
class ShoppingCartSummary extends StatelessWidget {
  final double subtotal;
  final double? shipping;
  final double? tax;
  final double? discount;
  final double total;
  final String? couponCode;
  final VoidCallback? onApplyCoupon;
  final VoidCallback? onCheckout;

  const ShoppingCartSummary({
    super.key,
    required this.subtotal,
    this.shipping,
    this.tax,
    this.discount,
    required this.total,
    this.couponCode,
    this.onApplyCoupon,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: EcommerceTypography.sectionTitle),
          const SizedBox(height: 16),
          _buildSummaryRow('Subtotal', subtotal),
          if (shipping != null) ...[
            const SizedBox(height: 8),
            _buildSummaryRow('Shipping', shipping!),
          ],
          if (tax != null) ...[
            const SizedBox(height: 8),
            _buildSummaryRow('Tax', tax!),
          ],
          if (discount != null) ...[
            const SizedBox(height: 8),
            _buildSummaryRow('Discount', -discount!, isDiscount: true),
          ],
          const Divider(height: 24),
          _buildSummaryRow('Total', total, isTotal: true),
          const SizedBox(height: 16),
          if (couponCode != null) ...[
            _buildCouponSection(),
            const SizedBox(height: 16),
          ],
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? EcommerceTypography.totalLabel
              : EcommerceTypography.summaryLabel,
        ),
        Text(
          '${isDiscount ? '-' : ''}\$${_formatPrice(amount)}',
          style: isTotal
              ? EcommerceTypography.totalAmount
              : EcommerceTypography.summaryAmount,
        ),
      ],
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: EcommerceColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: EcommerceColors.success.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer, color: EcommerceColors.success, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Coupon Applied: $couponCode',
              style: EcommerceTypography.couponText,
            ),
          ),
          TextButton(
            onPressed: onApplyCoupon,
            child: Text('Change', style: EcommerceTypography.linkText),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onCheckout,
        style: ElevatedButton.styleFrom(
          backgroundColor: EcommerceColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Proceed to Checkout',
          style: EcommerceTypography.buttonText.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }
}

/// Wishlist Item for saved products
class WishlistItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double price;
  final double? originalPrice;
  final bool isOnSale;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final VoidCallback? onAddToCart;

  const WishlistItem({
    super.key,
    required this.name,
    this.imageUrl,
    required this.price,
    this.originalPrice,
    this.isOnSale = false,
    this.onTap,
    this.onRemove,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                _buildImageSection(),
                const SizedBox(width: 12),
                Expanded(child: _buildContentSection()),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: EcommerceColors.background,
      ),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
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
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.image,
        size: 24,
        color: EcommerceColors.textSecondary,
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: EcommerceTypography.productTitle.copyWith(fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        _buildPriceSection(),
      ],
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
          const SizedBox(width: 8),
          Text(
            '\$${_formatPrice(originalPrice!)}',
            style: EcommerceTypography.originalPriceText.copyWith(fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        IconButton(
          onPressed: onAddToCart,
          icon: const Icon(Icons.shopping_cart, size: 16),
          tooltip: 'Add to Cart',
        ),
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.delete_outline, size: 16),
          tooltip: 'Remove',
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }
}
