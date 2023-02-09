public with sharing abstract class AsyncRestLibFinalizer implements Finalizer {
	public HttpResponse response;

	abstract void execute(HttpResponse response);

	private void execute(finalizerContext fc) {
		this.execute(this.response);
	}
}