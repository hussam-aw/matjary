import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Helpers/date_formatter.dart';
import 'package:matjary/BussinessLayer/helpers/pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';

final productsController = Get.find<ProductsController>();
final accountsController = Get.find<AccountsController>();

p.Widget buildOrderPrintWidget(Order order) {
  var printTextStyle = p.TextStyle(
    font: PdfHelper.font,
    height: 1,
    color: const PdfColor.fromInt(0xff3D3E65),
  );
  return p.Directionality(
    textDirection: p.TextDirection.rtl,
    child: p.Padding(
      padding: const p.EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: p.Column(
        children: [
          p.SizedBox(height: 70),
          p.Row(
            mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
            children: [
              p.Expanded(
                child: p.Align(
                  alignment: p.Alignment.centerRight,
                  child: p.Padding(
                    padding: const p.EdgeInsets.symmetric(vertical: 10),
                    child: p.Text(
                      'فاتورة رقم  ${order.id}#',
                      softWrap: true,
                      //overflow: TextOverflow.ellipsis,
                      style: printTextStyle.copyWith(
                        height: 1,
                        fontWeight: p.FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          p.SizedBox(height: 22),
          p.Container(
            //width: Get.width,
            padding: const p.EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: p.BoxDecoration(
              borderRadius: const p.BorderRadius.all(p.Radius.circular(15)),
              border: p.Border.all(color: PdfColor.fromInt(0xff707070)),
            ),
            child: p.Column(
              crossAxisAlignment: p.CrossAxisAlignment.end,
              children: [
                p.Text(
                  'معلومات الفاتورة',
                  softWrap: true,
                  style: printTextStyle.copyWith(
                    fontWeight: p.FontWeight.bold,
                  ),
                ),
                p.SizedBox(height: 22),
                p.Row(
                  crossAxisAlignment: p.CrossAxisAlignment.end,
                  children: [
                    p.Expanded(
                      child: p.Text(
                        accountsController.getAccountName(order.customerId),
                        softWrap: true,
                        style: printTextStyle.copyWith(
                          fontWeight: p.FontWeight.bold,
                        ),
                      ),
                    ),
                    p.SizedBox(width: 14),
                    p.Text(
                      'الطرف المقابل:',
                      softWrap: true,
                      style: printTextStyle,
                    ),
                  ],
                ),
                p.SizedBox(height: 10),
                p.Row(
                  crossAxisAlignment: p.CrossAxisAlignment.end,
                  children: [
                    p.Expanded(
                      child: p.Text(
                        DateFormatter.getDateString(order.creationDate),
                        softWrap: true,
                        style: printTextStyle.copyWith(
                          fontWeight: p.FontWeight.bold,
                        ),
                      ),
                    ),
                    p.SizedBox(width: 14),
                    p.Text(
                      'تاريخ الانشاء:',
                      softWrap: true,
                      style: printTextStyle,
                    ),
                  ],
                ),
                p.SizedBox(height: 32),
                p.Row(
                  children: [
                    p.Expanded(
                      child: p.Column(
                        children: [
                          p.Text(
                            'إجمالي الفاتورة',
                            softWrap: true,
                            style: printTextStyle,
                          ),
                          p.SizedBox(height: 14),
                          p.Text(
                            order.total.toString(),
                            softWrap: true,
                            style: printTextStyle.copyWith(
                              fontWeight: p.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    p.Expanded(
                      child: p.Column(
                        children: [
                          p.Text(
                            'المبلغ المدفوع',
                            softWrap: true,
                            style: printTextStyle,
                          ),
                          p.SizedBox(height: 14),
                          p.Text(
                            order.paidUp.toString(),
                            softWrap: true,
                            style: printTextStyle.copyWith(
                              fontWeight: p.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    p.Expanded(
                      child: p.Column(
                        children: [
                          p.Text(
                            'المبلغ المتبقي',
                            softWrap: true,
                            style: printTextStyle,
                          ),
                          p.SizedBox(height: 14),
                          p.Text(
                            order.restOfTheBill.toString(),
                            softWrap: true,
                            style: printTextStyle.copyWith(
                              fontWeight: p.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          p.SizedBox(height: 22),
          p.Expanded(
            child: p.ListView.separated(
              itemBuilder: (context, index) {
                return p.Container(
                  padding: const p.EdgeInsets.symmetric(
                      horizontal: 25, vertical: 18),
                  decoration: p.BoxDecoration(
                    color: const PdfColor.fromInt(0xffffffff),
                    borderRadius:
                        const p.BorderRadius.all(p.Radius.circular(15)),
                    border:
                        p.Border.all(color: const PdfColor.fromInt(0xff707070)),
                  ),
                  child: p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                    children: [
                      p.Expanded(
                        flex: 4,
                        child: p.Column(
                          mainAxisAlignment: p.MainAxisAlignment.center,
                          crossAxisAlignment: p.CrossAxisAlignment.start,
                          children: [
                            p.Text(
                              productsController.getProductName(
                                  order.details[index].productId),
                              softWrap: true,
                              //overflow: TextOverflow.ellipsis,
                              style: printTextStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            p.SizedBox(height: 14),
                            p.Row(
                              children: [
                                p.Text(
                                  'الكمية:',
                                  softWrap: true,
                                  style: printTextStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                                p.SizedBox(width: 14),
                                p.Text(
                                  order.details[index].quantity.toString(),
                                  softWrap: true,
                                  style: printTextStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                                p.SizedBox(width: 14),
                                p.Text(
                                  'الافرادي:',
                                  softWrap: true,
                                  style: printTextStyle.copyWith(
                                    fontSize: 7,
                                  ),
                                ),
                                p.SizedBox(width: 14),
                                p.Text(
                                  order.details[index].price.toStringAsFixed(2),
                                  softWrap: true,
                                  style: printTextStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      p.SizedBox(width: 14),
                      p.Expanded(
                        flex: 1,
                        child: p.Column(
                          children: [
                            p.Text(
                              'الإجمالي',
                              softWrap: true,
                              //overflow: TextOverflow.ellipsis,
                              style: printTextStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            p.SizedBox(height: 14),
                            p.Align(
                              alignment: p.Alignment.center,
                              child: p.Text(
                                order.details[index].totalPrice
                                    .toStringAsFixed(1),
                                softWrap: true,
                                //overflow: TextOverflow.ellipsis,
                                style: printTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => p.SizedBox(height: 14),
              itemCount: order.details.length,
            ),
          ),
        ],
      ),
    ),
  );
}
