abstract class DeleteOneInvoiceDataSources {
  Future deleteOneInvoice({
    required String id,
    required String token,
  });
}

//--------------------------------------------------------------
abstract class PayFullDataSources {
  Future payFull({
    required String id,
    required String token,
  });
}
