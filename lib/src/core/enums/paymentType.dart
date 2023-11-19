enum PaymentType {
  Card,
  Cash,
  Knet,
}

String paymentTypeToString(PaymentType type) {
  switch (type) {
    case PaymentType.Knet:
      return 'KNET';
    case PaymentType.Card:
      return 'CARD';
    case PaymentType.Cash:
      return 'CASH';
  }
}
