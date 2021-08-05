---
author: David Johnston
---

# VMware Homework Problems

## Problem 1: Fork Spring Native and Add an ActiveMQ Sample

### Initial Approach

Read the prompt and briefly develop an initial set of deliverable items and
research questions.

I will then expand, refine, and prune these deliverables and research questions
based on my exploration of the issues and my discoveries.

I expect the basic outline of my implementation process will involve:

1. Figure out how to add a sample Spring Boot application to Spring Native.
2. Figure out how to make this sample Spring Boot application talk to an
   ActiveMQ instance.
3. Study how Spring Native generates GraalVM `native-image` invocations and how
   it decides to configure these.
4. Identify the GraalVM `native-image` configuration which will make my Spring
   Boot application work correctly.
5. Figure out how to modify Spring Native to include this `native-image`
   configuration when appropriate.

At every stage, I will be researching various topics to better understand this
system and inform any implementation choices.

#### Primary Deliverables

- [ ] Create a Spring Native sample Spring Boot application.
- [ ] Make any necessary modifications to Spring Native to make my sample code
    compile and run.
- [ ] Write documentation explaining how to build and run my sample
    application.
- [ ] Bonus: Ensure that my sample application is built/tested at some point in
    the Spring Native build/test process. Can it be used as one of the Spring
    Native project's integration tests.

### Action Items Ideas

- [ ] Read through the [Spring Native documentation][spring-native-docs].
  - [ ] Can the [Spring Initializr][spring-initializr] help me get started?
  - [ ] Which will I be using: "Buildpacks" or "Native Build Tools".
      (Hopefully the latter.)
- [ ] What is ActiveMQ? How is it related to JMS?
- [ ] Does my sample program against an ActiveMQ API or against JMS? Will
    ActiveMQ be a JMS provider?
- [ ] Using ActiveMQ persistence likely adds configuration and operations
    complexity that we may not care about. Can we ignore persistence?
- [ ] Similarly, can we ignore ActiveMQ's high availability features?
- [ ] What magic is `spring-boot-starter-activemq` providing? Where is this
    dependency defined/implemented?
- [ ] Will I be using a ActiveMQ as a standalone process or embedded?
- [ ] Will I be using ActiveMQ "Classic" or ActiveMQ Artemis?
- [ ] Read [Issue #438][issue-438].
- [ ] How is ActiveMQ added to an application? How is it configured? What
    operations overhead does it add? Can it be embedded?
- [ ] What is the `JmsTemplate` bean, and how do I implement one to wrap a
    simple text message? What magic does this bean perform?
- [ ] Read a pre-existing sample application.
  - [ ] Do any of them use `spring-boot-starter-activemq`?
  - [ ] What build tool do they use?
- [ ] What are the conventions surrounding any pre-existing sample
    applications? In particular, are any automatically built or tested? If so,
    how?
- [ ] Check that the sample application builds and runs on the following
    platforms:

  - [ ] Linux + Java 11
  - [ ] macOS + Java 11
  - [ ] Linux + Java 11 native-image
  - [ ] macOS + Java 11 native-image

   (For Linux, I'll use Fedora 34. For macOS, I'll use v11.5.)

- [ ] Consider adding automatic smoke tests for the sample application.
- [ ] If spring boot applications need to be deployed as multiple processes,
    how are these conventionally compiled, configured and organized? Is there
    Spring magic involved in getting them to work with each other?
- [ ] The [Spring Native "Getting Started"][spring-native-getting-started]
    documentation says that there are two ways to build a Spring Boot native
    application. Which of these are relevant here.
- [ ] What are Native hints? This was a recommended approach in the issue.
- [ ] Read the [Messaging with JMS][messaging-with-jms] Spring guide.
- [ ] Do I want to include Spring AOT?

## Problem 2: Investigate Spring WebFlux with Netty Samples

### Problem 2: Initial Approach

1. Read the relevant issue.
2. Figure out how to measure memory usage in both environments.
3. Collect memory usage data.
4. Perform comparative analysis of memory usage.

### Problem 2: Primary Deliverables

- [ ] Document my investigation's process and any findings.

### Problem 2: Action Item Ideas

- [ ] Read [Issue #739][issue-739].

---

[spring-native-docs]: https://docs.spring.io/spring-native/docs/current/reference/htmlsingle/
[issue-438]: https://github.com/spring-projects-experimental/spring-native/issues/438
[issue-739]: https://github.com/spring-projects-experimental/spring-native/issues/739
[spring-native-getting-started]: https://docs.spring.io/spring-native/docs/current/reference/htmlsingle/#getting-started
[messaging-with-jms]: https://spring.io/guides/gs/messaging-jms/
[spring-initializr]: https://start.spring.io
