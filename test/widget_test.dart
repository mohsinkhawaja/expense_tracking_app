import 'package:flutter_test/flutter_test.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/expense_category.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/provider/expense_provider.dart';
import 'memory_storage.dart';

void main() {
  test('expenses reload from JSON strings and deletions survive restart', () {
    final storage = MemoryStorage();
    ExpenseProvider(storage).addExpense(Expense(
        id: 'e',
        amount: 50,
        categoryId: '1',
        payee: 'Shop',
        note: '',
        date: DateTime(2026, 1, 1),
        tag: '1'));
    final restored = ExpenseProvider(storage);
    expect(restored.expenses.single.amount, 50);
    expect(restored.expenses.single.date, DateTime(2026, 1, 1));
    restored.deleteExpense('e');
    expect(ExpenseProvider(storage).expenses, isEmpty);
  });
  test('custom categories and tags survive restart', () {
    final storage = MemoryStorage();
    final first = ExpenseProvider(storage);
    first.addCategory(ExpenseCategory(id: 'custom', name: 'Learning'));
    first.addTag(Tag(id: 'custom', name: 'Books'));
    final restored = ExpenseProvider(storage);
    expect(restored.categories.any((c) => c.name == 'Learning'), isTrue);
    expect(restored.tags.any((t) => t.name == 'Books'), isTrue);
  });
}
