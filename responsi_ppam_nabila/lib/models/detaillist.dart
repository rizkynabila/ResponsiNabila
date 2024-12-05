import 'package:responsi_ppam_nabila/network/base_network.dart';

abstract class ListmodelView {
  void showLoading();
  void hideLoading();
  void showDetailData(Map<String, dynamic> detailData);
  void showError(String message);
}

class ListmodelPresenter {
  final ListmodelView view;
  ListmodelPresenter(this.view);

  Future<void> loadDetailData(String endpoint, int id) async {
    view.showLoading();
    try {
      final data = await BaseNetwork.getDetailData(endpoint, id);
      view.showDetailData(data);
    } catch (e) {
      view.showError(e.toString());
    } finally {
      view.hideLoading();
    }
  }
}
