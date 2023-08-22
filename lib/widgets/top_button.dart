import 'package:adress_book_app/features/account/account_services.dart';
import 'package:adress_book_app/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButoon(text: 'Your Contacts', onTap: () {}),
            AccountButoon(text: 'Turn Seller', onTap: () {})
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButoon(
              text: 'Logout',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButoon(text: 'Your Whishlist', onTap: () {})
          ],
        ),
      ],
    );
  }
}
