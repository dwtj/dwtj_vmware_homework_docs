# Spring Native Homework Prompts

## Problem 1

### Problem Statement

Add support to Spring Native to enable a basic ActiveMQ sample run as a native
image.

(This relates to [Issue #438][issue-438], but please do not comment on this
issue or submit a pull-request.)

### Expectations
- Create a fork of Spring Native (if using a private fork, please provide access
to  `mbhave`, `sdeleuze` and `aclement`.
- Add a sample application to the `main` branch of the Spring Native project.
- The sample application should use `spring-boot-starter-activemq` as a
dependency,
- The application should use a `JmsTemplate` bean to send a simple text message.
- The application should run on both the JVM and as a native image using Java 11
(please do not use Java 8 as it will not work because of GraalVM issues)
- Make the necessary changes to Spring Native to support native compilation of
this application
- Send an email to `sdeleuze@vmware.com`, `aclement@vmware.com` and
`bhavem@vmware.com` with a link to your fork.
- In the same email, please provide a detailed explanation about the process you
followed to get to the solution. Even if you couldn’t make it work, please
describe your thought process about what you tried as the process is as
important as the result.

## Problem 2

### Problem Statement

Investigate why Spring WebFlux samples have a bigger memory footprint when using
Netty with Java 11 as compared to Java 8.

(This relates to [Issue #739][issue-739] but please do not comment on this issue
or submit a pull-request.)

### Expectations
- Use the `webflux-netty` sample in the Spring Native project as the basis of
your investigation. If Java 8 builds of GraalVM 21.2.0 are not available, please
use GraalVM 21.1.0.
- Send an email to `sdeleuze@vmware.com`, `aclement@vmware.com` and
`bhavem@vmware.com` with a detailed description of how you would proceed to
identify the discrepancy between Java 11 and Java 8. We don’t necessarily expect
you to find why, but we are interested in your thought process.

---

[issue-438]: https://github.com/spring-projects-experimental/spring-native/issues/438
[issue-739]: https://github.com/spring-projects-experimental/spring-native/issues/739
