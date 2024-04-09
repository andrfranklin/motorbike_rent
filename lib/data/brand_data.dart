import 'package:motorbikes_rent/models/brand.dart';

const logoPath = 'assets/images/brands/';
List<Brand> getBrands() {
  return <Brand>[
    Brand(name: 'BMW', logo: '${logoPath}bmw.webp'),
    Brand(name: 'HONDA', logo: '${logoPath}honda.webp'),
    Brand(name: 'KAWASAKI', logo: '${logoPath}kawasaki.webp'),
  ];
}
