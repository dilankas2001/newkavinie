import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenaratedBill extends StatefulWidget {
  DocumentSnapshot docid;
  GenaratedBill({required this.docid});
  @override
  State<GenaratedBill> createState() => _GenaratedBillState(docid: docid);
}

class _GenaratedBillState extends State<GenaratedBill> {
  DocumentSnapshot docid;
  _GenaratedBillState({required this.docid});
  final pdf = pw.Document();
  var name;
  var Accountno;
  var Lastread;
  var Newread;
  var payAmount;
  var fixedcharge;
  var Address;
  var ContactNo;
  var email;

  var Units;
  var Total;
  var Year;
  var Month;
  void initState() {
    setState(() {
      name = widget.docid.get('CustomerName');
      Accountno = widget.docid.get('AccountNumber');
      Address = widget.docid.get('Address');
      ContactNo= widget.docid.get('ContactNo');
      email= widget.docid.get('email');
      Lastread = widget.docid.get('LastRead');
      Newread = widget.docid.get('NewRead');
      Year = widget.docid.get('Year');
      Month = widget.docid.get('Month');

      Units = int.parse(Newread) - int.parse(Lastread);
      if (Units <= 100) {
        payAmount = Units * 1.5;
        fixedcharge = 25.00;
      } else if (Units <= 200) {
        payAmount = (100 * 1.5) + (Units - 100) * 2.5;
        fixedcharge = 50.00;
      } else if (Units <= 300) {
        payAmount = (100 * 1.5) + (200 - 100) * 2.5 + (Units - 200) * 4;
        fixedcharge = 75.00;
      } else if (Units <= 350) {
        payAmount = (100 * 1.5) +
            (200 - 100) * 2.5 +
            (300 - 200) * 4 +
            (Units - 300) * 5;
        fixedcharge = 100.00;
      } else {
        payAmount = 0;
        fixedcharge = 1500.00;
      }

      Total = payAmount + fixedcharge;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    final image = await imageFromAssetBundle('assets/images/img.png');

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              /* pw.Flexible(
                child: pw.SvgImage(
                  svg: _logo,
                  height: 100,
                ),
              ),*/
              pw.SizedBox(
                height: 20,
              ),
              pw.Center(
                child: pw.Text(
                  'Ceylon Electricity Board',
                  style: pw.TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),

              pw.SizedBox(
                height: 20,
              ),
              pw.Divider(),

              pw.Row(

                mainAxisAlignment: pw.MainAxisAlignment.center,

                children: [
                  pw.Center(
                    child: pw.Text(
                      'Customer Details',
                      style: pw.TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),


              pw.Row(

                mainAxisAlignment: pw.MainAxisAlignment.center,

                children: [
                  pw.Text(
                    'Customer Name : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    name,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Account Number : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Accountno,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Address : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Address,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Contact Number : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    ContactNo,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Year : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Year,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Month : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Month,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Last Read : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Lastread,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'New Read : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Newread,
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Usage Units : ',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Units.toString(),
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Price : Rs.',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    Total.toString(),
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );

    return doc.save();
  }
}
