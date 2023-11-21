import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class SendTokensPage extends StatelessWidget {
  final String privateKey;
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  SendTokensPage({Key? key, required this.privateKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Send Tokens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(style: TextStyle(color: Colors.white),
              controller: recipientController,
              decoration: const InputDecoration(
                labelText: 'Recipient Address',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),

                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))
              ),cursorColor: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 16.0),
            TextField(style: TextStyle(color: Colors.white),
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),

                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))

              ),cursorColor: Colors.deepPurpleAccent,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.deepPurpleAccent)),
              onPressed: () {
                String recipient = recipientController.text;
                double amount = double.parse(amountController.text);
                BigInt bigIntValue = BigInt.from(amount * pow(10, 18));
                print(bigIntValue);
                EtherAmount ethAmount =
                    EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                print(ethAmount);
                // Convert the amount to EtherAmount
                sendTransaction(recipient, ethAmount);
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  void sendTransaction(String receiver, EtherAmount txValue) async {
    var apiUrl = "https://eth-sepolia.g.alchemy.com/v2/gjamQoWCYPnV_Dg_NDoLdZe1uWmmglAC";
    var httpClient = http.Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    EthPrivateKey credentials = EthPrivateKey.fromHex('0x' + privateKey);

    EtherAmount etherAmount = await ethClient.getBalance(credentials.address);
    EtherAmount gasPrice = await ethClient.getGasPrice();

    print(etherAmount);

    await ethClient.sendTransaction(
      credentials,
      Transaction(
        to: EthereumAddress.fromHex(receiver),
        gasPrice: gasPrice,
        maxGas: 100000,
        value: txValue,
      ),
      chainId: 11155111,
    );
  }
}
