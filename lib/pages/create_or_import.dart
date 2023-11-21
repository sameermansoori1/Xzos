import 'package:flutter/material.dart';
import 'package:xsoz/pages/generate_mnemonic_page.dart';
import 'package:xsoz/pages/import_wallet.dart';


class CreateOrImportPage extends StatelessWidget {
  const CreateOrImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Xzos Wallet',
                style: TextStyle(
                  fontSize: 40.0,color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 7.0),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Secure Wallet',
                style: TextStyle(
                  fontSize: 16.0,color: Colors.white70,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),



            const SizedBox(height: 40.0),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                height: 200,
                child: Image.asset(
                  'assets/images/walletx.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),







            const SizedBox(height: 50.0),



            // Login button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenerateMnemonicPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
              ),
              child: const Text(
                'Create Wallet',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            Center(child: Text("Have an Account?",style: TextStyle(color: Colors.white),)),

            const SizedBox(height: 16.0),

            // Register button
            ElevatedButton(
              onPressed: () {
                // Add your register logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImportWallet(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                Colors.white, // Customize button background color
                foregroundColor: Colors.deepPurpleAccent, // Customize button text color
                padding: const EdgeInsets.all(16.0),
              ),
              child: const Text(
                'Import from Seed',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}