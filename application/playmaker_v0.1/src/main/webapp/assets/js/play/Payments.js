let stripe;

$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#paymentTable'));
        stripe = Stripe(stripeKey);
    });
});

function makePayment(id) {
    $.post("/payment/pay",
        {
            id: id
        },
        function (id) {
            if (id !== '') {
                console.log(id);
                return stripe.redirectToCheckout({ sessionId: id });
            }
        });
}
