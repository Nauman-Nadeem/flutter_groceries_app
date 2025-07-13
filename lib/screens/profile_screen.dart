import 'package:flutter/material.dart';
import 'package:groceries_appp/services/user_service.dart';

class ProfileScreen extends StatelessWidget {
  final UserService _userService = UserService();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = _userService.getCurrentUser();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage(user.avatarPath),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.edit, size: 16, color: Colors.green),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            // Menu Items
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    _ProfileMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Orders',
                    ),
                    _ProfileMenuItem(
                      icon: Icons.person_outline,
                      title: 'My Details',
                    ),
                    _ProfileMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Delivery Address',
                    ),
                    _ProfileMenuItem(
                      icon: Icons.credit_card_outlined,
                      title: 'Payment Methods',
                    ),
                    _ProfileMenuItem(
                      icon: Icons.card_giftcard,
                      title: 'Promo Cord',
                    ),
                    _ProfileMenuItem(
                      icon: Icons.notifications_none,
                      title: 'Notifeactions',
                    ),
                    _ProfileMenuItem(icon: Icons.help_outline, title: 'Help'),
                    _ProfileMenuItem(icon: Icons.info_outline, title: 'About'),
                    SizedBox(height: 60),
                    // Log Out Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[50],
                          foregroundColor: Colors.green,
                          elevation: 0,
                          minimumSize: Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: Icon(Icons.logout, color: Colors.green),
                        label: Text(
                          'Log Out',
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Navigation Bar
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const _ProfileMenuItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: Colors.black.withAlpha((0.87 * 255).toInt()),
            size: 26,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black.withAlpha((0.92 * 255).toInt()),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey.withAlpha((0.6 * 255).toInt()),
          ),
          onTap: () {},
        ),
        Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Colors.grey.withAlpha((0.35 * 255).toInt()),
        ),
      ],
    );
  }
}

// class _BottomNavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool selected;
//   const _BottomNavItem({
//     required this.icon,
//     required this.label,
//     required this.selected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           icon,
//           color: selected
//               ? Colors.green
//               : Colors.black.withAlpha((0.87 * 255).toInt()),
//           size: 26,
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: selected
//                 ? Colors.green
//                 : Colors.black.withAlpha((0.92 * 255).toInt()),
//             fontWeight: FontWeight.w600,
//             fontSize: 13,
//           ),
//         ),
//       ],
//     );
//   }
// }
