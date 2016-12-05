# Policies #

Policy objects have a huge number of parts, so this guide describes a few unique parts of the API when
creating policies.

## General ##

### Triggers ###

The triggers property is a `Set<PolicyTrigger>`.
PolicyTrigger is an enumeration of the different types of triggers that may be used with a policy.
An example of setting the policy triggers via a Set constructor:

    var policy = Policy()
    policy.triggers = Set<PolicyTrigger>([.Login, .Startup])

### Execution Frequency ###

The execution frequency is defined as a string enumeration called `ExecutionFrequency`.




