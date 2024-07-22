
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? 'https://acaf-2806-104e-3-373e-cdd0-6507-9037-cb05.ngrok-free.app/api';
}
