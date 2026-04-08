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

//--------------------------------------------------------------
abstract class PayPartialDataSources {
  Future payPartial({
    required String id,
    required String token,
    required double amount,
  });
}
