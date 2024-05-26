import 'package:motorbikes_rent/data/brand_data.dart';
import 'package:motorbikes_rent/models/brand.dart';
import 'package:motorbikes_rent/models/motorbike.dart';

const imagePath = 'assets/images/';
List<Motorbike> getMotorbikes() {
  Brand bmwBrand = _getBrand('BMW');
  Brand hondaBrand = _getBrand('HONDA');
  Brand kawasakiBrand = _getBrand('KAWASAKI');
  return <Motorbike>[
    Motorbike(brandId: bmwBrand.name, model: 'K1600 B', price: 108500, images: [
      '${imagePath}bmw_k1600_b/profile.webp',
      '${imagePath}bmw_k1600_b/back.webp',
      '${imagePath}bmw_k1600_b/panel.webp'
    ]),
    Motorbike(
        brandId: bmwBrand.name,
        model: 'SCRAMBLER',
        price: 84500,
        images: [
          '${imagePath}bmw_r_nine_t_scrambler/profile.webp',
          '${imagePath}bmw_r_nine_t_scrambler/back.webp',
          '${imagePath}bmw_r_nine_t_scrambler/panel.webp'
        ]),
    Motorbike(
        brandId: hondaBrand.name,
        model: 'CBR 250R',
        price: 15990,
        images: [
          '${imagePath}cbr_250r/profile.webp',
          '${imagePath}cbr_250r/back.webp',
          '${imagePath}cbr_250r/panel.webp'
        ]),
    Motorbike(brandId: hondaBrand.name, model: 'PXC', price: 12710, images: [
      '${imagePath}honda_pxc/profile.webp',
      '${imagePath}honda_pxc/back.webp',
      '${imagePath}honda_pxc/panel.webp'
    ]),
    Motorbike(
        brandId: kawasakiBrand.name,
        model: 'NINJA H2R',
        price: 291306.50,
        images: [
          '${imagePath}kawasaki_ninja_h2r/profile.webp',
          '${imagePath}kawasaki_ninja_h2r/back.webp',
          '${imagePath}kawasaki_ninja_h2r/panel.webp'
        ]),
  ];
}

Brand _getBrand(String name) =>
    getBrands().firstWhere((brand) => brand.name == name,
        orElse: () => Brand(name: '', logo: ''));
