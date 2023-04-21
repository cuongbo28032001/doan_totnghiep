import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/stores/model/productModel.dart';
import 'package:flutter/material.dart';
import '../../consts/colorsTheme.dart';

class InfomationDrugs extends StatefulWidget {
  ProductModel productModel;
  InfomationDrugs({super.key, required this.productModel});

  @override
  State<InfomationDrugs> createState() => _InfomationDrugsState();
}

class _InfomationDrugsState extends State<InfomationDrugs> {
  late int numberOrderProduct = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Thông tin thuốc"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: renderInfomationDrugs(),
        ),
      ),
    );
  }

  renderInfomationDrugs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: logoGreen),
            image: const DecorationImage(
                image: AssetImage("assets/images/LogoApp.png"),
                fit: BoxFit.contain),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                color: logoGreen,
                border: Border.all(width: 0.5, color: logoGreen),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                )),
            child: const Text(
              "Tạo đơn",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        CardLayoutWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "vì yêu là nhớ",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "không có ngày về",
                      style: TextStyle(
                          color: logoGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Mã thuốc: 1920",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const Text(
                "Mô tả",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Thành phần",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Mỗi viên nén bao phim chứa\nDược chất: Thiamine mononitrate (vitamin B1)\t100 mg\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tPyridoxine HCl (vitamin B6)\t200 mg\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tCyanocobalamin (vitamin B12)\t200 mcg\nTá dược: Microcrystalline cellulose, calcium hydrogen phosphate dihydrate, povidone K30, croscarmellose sodium, sodium starch glycolate, stearic acid, magnesium stearate, colloidal silicon dioxide, methacrylic acid-methyl methacrylate copolymer (1:1), talc, triethyl citrate, sepifilm LP 770.",
                    style: TextStyle(height: 1.5),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Chỉ định",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Điều trị các trường hợp thiếu vitamin B1, B6, B12 như: viêm đau dây thần kinh, bệnh lý dây thần kinh do thuốc, do nghiện rượu...",
                    style: TextStyle(height: 1.5),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Liều dùng và cách sử dụng",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Uống 1 đến 3 viên mỗi ngày, hoặc theo chỉ định của thầy thuốc.",
                    style: TextStyle(height: 1.5),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Chống chỉ định",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "- Bệnh nhân mẫn cảm với thành phần của thuốc, hoặc có tiền sử dị ứng với vitamin B1, B12 hay các cobalamin.\n- U ác tính.\n- Người bệnh có cơ địa dị ứng (hen, eczema).",
                    style: TextStyle(height: 1.5),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Bảo quản",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Dưới 30°C. Tránh ẩm và ánh sáng.",
                    style: TextStyle(height: 1.5),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
