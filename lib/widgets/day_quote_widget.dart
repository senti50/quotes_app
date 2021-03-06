import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../model/quote.dart';
import '../database/database_helper.dart';
import '../widgets/read_quote_button.dart';

class DayQuoteWidget extends StatefulWidget {
  final int id;
  final String text;
  final String author;
  DayQuoteWidget(this.text, this.author, this.id);

  @override
  _DayQuoteWidgetState createState() => _DayQuoteWidgetState();
}

class _DayQuoteWidgetState extends State<DayQuoteWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaQueryData queryData = MediaQuery.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 30, color: Colors.black87),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.author,
            style: TextStyle(
                fontSize: 23,
                color: Colors.black45,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 32,
                  ),
                  onPressed: () {
                    Share.share('${widget.text}\n${widget.author}');
                  }),
              IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 32,
                  ),
                  onPressed: () {
                    Quote q = Quote(
                        quoteId: widget.id,
                        quoteText: widget.text,
                        quoteAuthor: widget.author);
                    dbHelper.saveQuote(q);
                    final snackBar = SnackBar(
                      content: Text(
                        'Added to favorites',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      backgroundColor: Colors.black,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }),
              ReadQuoteButton(widget.text),
            ],
          ),
        ],
      ),
    );
  }
}
