import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsoz/providers/wallet_provider.dart';
import 'package:xsoz/pages/wallet.dart';

class VerifyMnemonicPage extends StatefulWidget {
  final String mnemonic;

  const VerifyMnemonicPage({Key? key, required this.mnemonic})
      : super(key: key);

  @override
  _VerifyMnemonicPageState createState() => _VerifyMnemonicPageState();
}

class _VerifyMnemonicPageState extends State<VerifyMnemonicPage> {
  bool isVerified = false;
  String verificationText = '';

  void verifyMnemonic() {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    if (verificationText.trim() == widget.mnemonic.trim()) {
      walletProvider.getPrivateKey(widget.mnemonic).then((privateKey) {
        setState(() {
          isVerified = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void navigateToWalletPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WalletPage()),
      );
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Verify Mnemonic and Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please verify your mnemonic phrase:',
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
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),

              ),
              cursorColor: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent),
            ),
              onPressed: () {
                verifyMnemonic();
              },
              child: const Text('Verify'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: isVerified ? navigateToWalletPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurpleAccent,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}