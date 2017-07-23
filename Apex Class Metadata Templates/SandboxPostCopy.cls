global class {{ api_name }} implements SandboxPostCopy {
    global void runApexClass(SandboxContext context) {
        System.debug('Organization Id: ' + context.organizationId());
        System.debug('Sandbox Id: ' + context.sandboxId());
        System.debug('Sandbox Name: ' + context.sandboxName());
    }
}
