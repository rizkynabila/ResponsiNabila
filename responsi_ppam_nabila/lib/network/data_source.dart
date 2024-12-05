import 'package:responsi_ppam_nabila/network/base_network.dart';

class DataSource {
  static DataSource getInstance = DataSource();

  BaseNetwork loadData(){
    return BaseNetwork("Data");
  }
}