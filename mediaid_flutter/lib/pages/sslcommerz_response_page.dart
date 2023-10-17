import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/flutter_sslcommerz.dart';
import 'package:mediaid_flutter/models/sslcommerz_model.dart';

class SSLCommerzResponsePage extends StatefulWidget {
  final SSLCommerzResponseModel responseModel;

  SSLCommerzResponsePage(this.responseModel);

  @override
  _SSLCommerzResponsePageState createState() => _SSLCommerzResponsePageState();
}

class _SSLCommerzResponsePageState extends State<SSLCommerzResponsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Payment Result: ${widget.responseModel.transactionStatus}'),
            Text('Transaction ID: ${widget.responseModel.tranId}'),
            Text('Amount: ${widget.responseModel.amount} BDT'),
            Text('Currency: ${widget.responseModel.currency}'),
            Text('Payment ID: ${widget.responseModel.paymentId}'),
          ],
        ),
      ),
    );
  }
}
