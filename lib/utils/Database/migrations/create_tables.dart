const String createRentalTable = '''
CREATE TABLE rental( 
  id TEXT PRIMARY KEY, 
  productId TEXT NOT NULL, 
  startDate TEXT NOT NULL, 
  endDate TEXT NOT NULL, 
  price REAL NOT NULL
);''';

const String createMotorbikeTable = '''
CREATE TABLE motorbike (
  id TEXT PRIMARY KEY,
  brandId TEXT NOT NULL,
  model TEXT NOT NULL,
  price REAL NOT NULL,
  rentalPrice REAL NOT NULL
);
''';
