// Purchase order interface.
public interface PurchaseOrder {
    // All other functionality excluded
    Double discount();
}

// class implements the PurchaseOrder interface for customer purchase orders
public class CustomerPurchaseOrder implements PurchaseOrder {
    public Double discount() {
        return .05; // Flat 5% discount
    }
}

// class implements the PurchaseOrder for employee purchase orders
public class EmployeePurchaseOrder implements PurchaseOrder {
    public Double discount() {
        return .1;
    }
}

