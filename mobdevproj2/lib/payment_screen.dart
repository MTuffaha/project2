import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color(0xFFFB4F4F),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Card number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 16,
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                    maxLength: 5,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // cancel button logic needed here
                      //goes back to cart?
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFBB3B3),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //  pay button logic needed her
                      //do we need
                    },
                    child: Text('Pay'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFBB3B3),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}