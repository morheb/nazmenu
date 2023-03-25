import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazmenuapp/utils/my_text.dart';
import 'package:nazmenuapp/utils/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../utils/my_text.dart';
import '../../utils/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pathPDF = "";
  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    fromAsset('assets/Naz-dollar.pdf', 'Naz-dollar.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg.jpeg'),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
                top: size.width / 20,
                left: size.width / 40,
                child: Container(
                  height: size.height / 15,
                  width: size.height / 15,
                  decoration: BoxDecoration(
                      color: mySecondColor, shape: BoxShape.circle),
                  child: Center(child: Image.asset('assets/images/logo.png')),
                )),
            Positioned(
              top: 0,
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
              ),
            ),
            Positioned(
              top: size.height / 8,
              child: SizedBox(
                height: size.height - (size.height / 8),
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: Colors.white,
                          text: 'Best In Town',
                          fontSize: size.width / 15,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: size.height / 80,
                      ),
                      MyText(
                          color: Colors.white,
                          text: 'Enjoy a unique coffee experience',
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.normal),
                      SizedBox(
                        height: size.height / 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFScreen(path: pathPDF),
                            ),
                          );
                        },
                        child: Container(
                          height: size.height / 8,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius:
                                  BorderRadius.circular(size.width / 30)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height / 10,
                                  width: size.width / 7,
                                  child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/590/590836.png'),
                                ),
                                SizedBox(
                                  width: size.width / 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        color: Colors.white,
                                        text: 'A big coffe taste is waiting',
                                        fontSize: size.width / 25,
                                        fontWeight: FontWeight.normal),
                                    SizedBox(
                                      height: size.height / 80,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.alarm,
                                          color: Colors.white60,
                                        ),
                                        SizedBox(
                                          width: size.width / 80,
                                        ),
                                        MyText(
                                            color: Colors.white60,
                                            text: 'All the day',
                                            fontSize: size.width / 30,
                                            fontWeight: FontWeight.normal)
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '9';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Naz dollar "),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
