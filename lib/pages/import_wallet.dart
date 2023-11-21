import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsoz/providers/wallet_provider.dart';
import 'package:xsoz/pages/wallet.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  _ImportWalletState createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  bool isVerified = false;
  String verificationText = '';

  void navigateToWalletPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WalletPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    void verifyMnemonic() async {
      final walletProvider =
          Provider.of<WalletProvider>(context, listen: false);

      // Call the getPrivateKey function from the WalletProvider
      final privateKey = await walletProvider.getPrivateKey(verificationText);

      // Navigate to the WalletPage
      navigateToWalletPage();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Import from Seed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please Enter your mnemonic phrase:',
              style: TextStyle(fontSize: 18.0,color: Colors.white),
            ),
            const SizedBox(height: 24.0),
            TextField(style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  verificationText = value;
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Enter mnemonic phrase',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),

                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)) ),
                cursorColor: Colors.deepPurpleAccent, // Set the cursor color here
                ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.deepPurpleAccent)),
              onPressed: verifyMnemonic,
              child: const Text('Import'),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
