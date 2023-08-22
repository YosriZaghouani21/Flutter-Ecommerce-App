import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adress_book_app/features/address/services/adress_Services.dart';
import 'package:adress_book_app/providers/user_provider.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';

class AdressScreen extends StatefulWidget {
  static const String routeName = '/adress';
  final String totalAmount;

  const AdressScreen({
    required this.totalAmount,
  });

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _adressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  final AdressServices adressServices = AdressServices();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onProceedToBuy() {
    if (_adressFormKey.currentState!.validate()) {
      addressToBeUsed =
          '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';

      if (Provider.of<UserProvider>(context, listen: false)
          .user
          .adress
          .isEmpty) {
        adressServices.saveUserAdress(
            context: context, adress: addressToBeUsed);
      }

      adressServices.placeOrder(
        context: context,
        adress: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount),
      );
    } else {
      // Handle form validation errors here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the required fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var adress = context.watch<UserProvider>().user.adress;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (adress.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          adress,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _adressFormKey,
                child: Column(
                  children: [
                    Custom_textfield(
                      controller: flatBuildingController,
                      hintText: 'Flat , House no , Building',
                    ),
                    const SizedBox(height: 10),
                    Custom_textfield(
                      controller: areaController,
                      hintText: 'Area , Street ',
                    ),
                    const SizedBox(height: 10),
                    Custom_textfield(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    Custom_textfield(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Custom_button(
                text: 'Proceed to Buy',
                onTap: onProceedToBuy,
                color: Colors.yellow[600],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
