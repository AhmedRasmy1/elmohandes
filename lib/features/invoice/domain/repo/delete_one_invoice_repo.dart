abstract class DeleteOneInvoiceRepo {
  Future deleteOneInvoice({
    required String id,
    required String token,
  });
}

//--------------------------------------------------------------
abstract class PayFullRepo {
  Future payFull({
    required String id,
    required String token,
  });
}

//--------------------------------------------------------------
abstract class PayPartialRepo {
  Future payPartial({
    required String id,
    required String token,
    required double amount,
  });
}
