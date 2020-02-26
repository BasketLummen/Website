// this is a workaround for ai not handling promise rejections
window.addEventListener('unhandledrejection', (event) => {
    let message;
    let error;
    try {
        message = event.reason.error.message;
        error = event.reason.error;
    } catch (err) {
        message = JSON.stringify(event);
        error = err;
    }
    window.onerror.apply(this, [message, '', null, null, error]);
});

var telemetryInitializer = (envelope) => {
    envelope.tags["ai.cloud.role"] = "basket-lummen";
    envelope.tags["ai.cloud.roleInstance"] = "www.basketlummen.be";s
}
appInsights.addTelemetryInitializer(telemetryInitializer);