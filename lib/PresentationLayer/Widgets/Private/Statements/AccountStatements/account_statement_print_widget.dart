import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Helpers/date_formatter.dart';
import 'package:matjary/BussinessLayer/helpers/pdf_helper.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/account_statement.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;

final accountController = Get.find<AccountController>();
var printTextStyle = p.TextStyle(
  font: PdfHelper.font,
  height: 1,
  color: const PdfColor.fromInt(0xff3D3E65),
);

Future<List<p.Widget>> buildAccountStatementPrintWidget(
    Account account, AccountStatement? accountStatement) async {
  return [
    p.SizedBox(height: 70),
    p.Align(
      alignment: p.Alignment.centerRight,
      child: p.Padding(
        padding: const p.EdgeInsets.symmetric(vertical: 10),
        child: p.Text(
          'كشف حساب',
          softWrap: true,
          textDirection: p.TextDirection.rtl,
          style: printTextStyle.copyWith(
            height: 1,
            fontWeight: p.FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    ),
    p.SizedBox(height: 22),
    p.Row(
      children: [
        p.Expanded(
          child: p.Column(
            crossAxisAlignment: p.CrossAxisAlignment.end,
            children: [
              p.Text(
                account.name,
                textDirection: p.TextDirection.rtl,
                softWrap: true,
                style: printTextStyle,
              ),
              p.SizedBox(height: 14),
              p.Text(
                accountController.convertAccountTypeToString(account.type),
                textDirection: p.TextDirection.rtl,
                softWrap: true,
                style: printTextStyle,
              ),
            ],
          ),
        ),
        p.SizedBox(width: 14),
        p.ClipOval(
          child: p.Container(
            width: 70,
            height: 70,
            child: p.Image(p.MemoryImage(
                await PdfHelper.getAssetBytes('assets/images/user.png'))),
          ),
        ),
      ],
    ),
    p.SizedBox(height: 22),
    p.Align(
      alignment: p.Alignment.center,
      child: p.Text(
        accountStatement!.total.toString(),
        style: printTextStyle,
      ),
    ),
    p.SizedBox(height: 14),
    p.Divider(thickness: 1),
    p.SizedBox(height: 22),
    p.Align(
      alignment: p.Alignment.centerRight,
      child: p.Padding(
        padding: const p.EdgeInsets.symmetric(horizontal: 10),
        child: p.Text(
          'حركة الحساب',
          textDirection: p.TextDirection.rtl,
          softWrap: true,
          style: printTextStyle,
        ),
      ),
    ),
    p.SizedBox(height: 14),
    buildAccountStatementList(accountStatement.statements),
  ];
}

p.Widget buildAccountStatementList(statements) {
  return statements.isEmpty
      ? p.Container(
          height: 200,
          child: p.Center(
            child: p.Text(
              'لا يوجد قيود',
              textDirection: p.TextDirection.rtl,
              style: printTextStyle,
            ),
          ),
        )
      : p.ListView.separated(
          itemBuilder: (context, index) {
            return p.Container(
              height: 100,
              padding:
                  const p.EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: p.BoxDecoration(
                borderRadius: const p.BorderRadius.all(p.Radius.circular(15)),
                border: p.Border.all(color: const PdfColor.fromInt(0xff3D3E65)),
              ),
              child: p.Column(
                children: [
                  p.Expanded(
                    flex: 2,
                    child: p.Text(
                      statements[index].statement,
                      textDirection: p.TextDirection.rtl,
                      softWrap: true,
                      style: printTextStyle,
                    ),
                  ),
                  p.Expanded(
                    child: p.Row(
                      mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                      children: [
                        p.Text(
                          DateFormatter.getDateString(statements[index].date),
                          textDirection: p.TextDirection.rtl,
                          softWrap: true,
                          style: printTextStyle,
                        ),
                        p.Text(
                          statements[index].amount.toString(),
                          textDirection: p.TextDirection.rtl,
                          softWrap: true,
                          style: printTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => p.SizedBox(height: 14),
          itemCount: statements.length,
        );
}
