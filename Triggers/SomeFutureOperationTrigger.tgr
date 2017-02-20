// Use a static variable to initiate future call from a number of different
// triggers or conditions.

public class SomeFutureOperations {

    private static Boolean FutureCallCalled = false;

    public static void DoFutureCall() {
        if (FutureCallCalled || System.isFuture()) return;
        FutureCallCalled = true;
        ActualFutureCall();
    }

    @future
    private static void ActualFutureCall() {
        // Actual async code here
        system.debug('ActualFutureCall async operation');
    }
}
