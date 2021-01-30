import 'package:test/test.dart';

void main() {
  test("test the total sum", () {
    expect(totalSum(2, 3), 6);
  });
  test("test the total sum", () {
    expect(totalSum(2, 3), 6);
  });
}

int totalSum(int amount, int currencyRate) {
  var totalAmount = amount * currencyRate;
  return totalAmount;
}
