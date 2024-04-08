import 'package:motorbikes_rent/models/brand.dart';

const imagePath = 'assets/images/';
List<Brand> getBrands() {
  return <Brand>[
    Brand(name: 'BMW', image: ''),
    Brand(name: 'HONDA', image: ''),
    Brand(name: 'KAWASAKI', image: ''),
  ];
}
