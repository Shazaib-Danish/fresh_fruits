import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:provider/provider.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ReusableProductCard extends StatefulWidget {
  final String imageUrl;
  final String productEngName;
//  final String productUrduName;
  final int price;
  final double rating;
  final int reviews;
  final Color shadowColor;
  final Color buttonColor;
  final bool isChecked;

  const ReusableProductCard({
    required this.imageUrl,
    required this.productEngName,
  //  required this.productUrduName,
    required this.price,
    required this.shadowColor,
    required this.buttonColor,
    required this.rating,
    required this.reviews,
    required this.isChecked,
  });

  @override
  _ReusableProductCardState createState() => _ReusableProductCardState();
}

class _ReusableProductCardState extends State<ReusableProductCard> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    setState(() {
      isChecked = widget.isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  color: widget.shadowColor,
                  offset: Offset(2, 2))
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_outlined,
                  color: Colors.yellow[800],
                  size: 20,
                ),
                Text(
                  '${widget.rating}',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                SizedBox(
                  width: 3.0,
                ),
                Text(
                  '(${widget.reviews} Reviews)',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
            Flexible(
                child: Container(
              child: Center(
                child: Image.network(
                  widget.imageUrl,
                  loadingBuilder: (context, child, loading) {
                    if (loading == null)
                      return child;
                    else {
                      return Center(
                        child: LoadingIndicator(
                            indicatorType: Indicator.orbit,
                            color: widget.buttonColor),
                      );
                    }
                  },
                ),
              ),
            )),
            Text(
              '${widget.productEngName}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              children: [
                Text(
                  'Rs. ${widget.price}',
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.buttonColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.productEngName.startsWith('Orange')
                      ? '/dozen'
                      : widget.productEngName.startsWith('Banana')
                          ? '/dozen'
                          : widget.productEngName.startsWith('Kin')
                              ? '/dozen'
                              : '/kg',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Spacer(),
                FlatButton(
                    minWidth: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: widget.buttonColor,
                    onPressed: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                      if (isChecked != false) {
                        Provider.of<ProductManager>(context, listen: false)
                            .addProduct(widget.imageUrl, widget.productEngName,widget.price);
                      } else {
                        Provider.of<ProductManager>(context, listen: false)
                            .deleteProduct(widget.productEngName);
                      }
                    },
                    child: isChecked
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
