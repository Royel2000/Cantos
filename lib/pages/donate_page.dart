import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _amountController = TextEditingController();
  
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submitDonation() {
    final amount = _amountController.text;
    if (amount.isNotEmpty) {
      // Aquí agregar la lógica para procesar el pago usando Stripe, PayPal o algún otro servicio
      print('Donación enviada: $amount');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hacer una Donación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Monto de Donación'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitDonation,
              child: Text('Donar'),
            ),
          ],
        ),
      ),
    );
  }
}
