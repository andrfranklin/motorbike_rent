import 'package:motorbikes_rent/data/brand_data.dart';
import 'package:motorbikes_rent/models/brand.dart';
import 'package:motorbikes_rent/models/motorbike.dart';

class MotorbikeList {
  static const imagePath = 'assets/images/';
  final List<Motorbike> motorbikes;

  MotorbikeList._internal({required this.motorbikes});

  factory MotorbikeList() {
    Brand defaultBrand = Brand(name: '', image: '');
    Brand bmwBrand = BrandList()
        .brands
        .firstWhere((brand) => brand.name == 'BMW', orElse: () => defaultBrand);
    Brand hondaBrand = BrandList().brands.firstWhere(
        (brand) => brand.name == 'HONDA',
        orElse: () => defaultBrand);
    Brand kawasakiBrand = BrandList().brands.firstWhere(
        (brand) => brand.name == 'KAWASAKI',
        orElse: () => defaultBrand);

    List<Motorbike> motorbikes = [
      Motorbike(brand: bmwBrand, model: 'K1600 B', price: 108500, images: [
        '${imagePath}bmw_k1600_b/profile.webp',
        '${imagePath}bmw_k1600_b/back.webp',
        '${imagePath}bmw_k1600_b/panel.webp'
      ]),
      Motorbike(
          brand: bmwBrand,
          model: 'R NINE T SCRAMBLER',
          price: 84500,
          images: [
            '${imagePath}bmw_r_nine_t_scrambler/profile.webp',
            '${imagePath}bmw_r_nine_t_scrambler/back.webp',
            '${imagePath}bmw_r_nine_t_scrambler/panel.webp'
          ]),
      Motorbike(brand: hondaBrand, model: 'CBR 250R', price: 15990, images: [
        '${imagePath}cbr_250r/profile.webp',
        '${imagePath}cbr_250r/back.webp',
        '${imagePath}cbr_250r/panel.webp'
      ]),
      Motorbike(brand: hondaBrand, model: 'PXC', price: 12710, images: [
        '${imagePath}honda_pxc/profile.webp',
        '${imagePath}honda_pxc/back.webp',
        '${imagePath}honda_pxc/panel.webp'
      ]),
      Motorbike(
          brand: kawasakiBrand,
          model: 'NINJA H2R',
          price: 291306.50,
          images: [
            '${imagePath}kawasaki_ninja_h2r/profile.webp',
            '${imagePath}kawasaki_ninja_h2r/back.webp',
            '${imagePath}kawasaki_ninja_h2r/panel.webp'
          ]),
    ];

    return MotorbikeList._internal(motorbikes: motorbikes);
  }
}
