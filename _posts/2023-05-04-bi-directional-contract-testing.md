---
title: BiDirectional Contract Testing
layout: post
permalink: /2023/05/bi-directional-contract-testing
categories:
  - Contract testing
tags:
  - pact
  - contract testing
---

![](/images/blog/Pactflow-blog-logo.svg)

In today's world of complex and interconnected software systems, ensuring the reliability and compatibility of various
components has become a critical part of the development process. As teams work on different services, the need for
effective integration testing becomes more important than ever. Among the various approaches to integration testing,
Bidirectional Contract Testing has emerged as a powerful technique that helps teams build more robust and maintainable
software systems.

In this comprehensive guide, we will delve into the world of Bidirectional Contract Testing, exploring how it bridges
the gap between end-to-end tests and tests in isolation. We will begin by discussing the testing spectrum, highlighting
the advantages and disadvantages of end-to-end tests and tests in isolation, as well as the implications of using Docker
Compose for creating isolated testing environments. Next, we will introduce the concept of Contract Testing and discuss
its benefits in the context of modern software development.

Following that, we will cover Consumer-Driven Contract Testing with Pact, a widely used framework for this purpose.
Building upon this foundation, we will then introduce Bidirectional Contract Testing, a powerful extension of Contract
Testing that offers additional benefits.

Finally, we will walk you through a demo presentation of a working project in Java, illustrating how to implement
Bidirectional Contract Testing in a real-world scenario. By the end of this guide, you will have a solid understanding
of the principles and benefits of Bidirectional Contract Testing, empowering you to make more informed decisions about
your integration testing strategies.

Join us on this exciting journey into the world of Bidirectional Contract Testing, and discover how this innovative
approach can help you build better, more reliable software systems.

## The Testing Spectrum: End-to-End Tests vs. Tests in Isolation and the Role of Docker Compose

Understanding the testing spectrum is crucial for making informed decisions about your integration testing strategies.
In this section, we will explore two distinct types of tests that lie on opposite ends of the spectrum: end-to-end tests
and tests in isolation. Additionally, we will discuss the role of Docker Compose in achieving isolation, and how it can
influence your testing approach.

### End-to-end tests: advantages and disadvantages

End-to-end tests (E2E tests) involve testing an entire system or application as a whole, from the user interface down to
the backend services and databases. These tests simulate real-world user scenarios and interactions, aiming to ensure
that all components of a system work together as expected.

**Advantages:**

- Realism: E2E tests closely replicate real-world user scenarios, providing a high level of confidence that the system
  works as intended.
- Comprehensive coverage: By testing the entire system, E2E tests can identify issues that may not be detectable through
  isolated tests, such as integration problems or performance bottlenecks.
- Business value: E2E tests can provide crucial insights into the overall functionality and performance of the system,
  helping stakeholders make informed decisions based on a comprehensive understanding of the system's behavior in
  real-world scenarios.
- Clear signal for action: When an E2E test fails, it serves as a strong indication that there is an issue within the
  system that requires investigation, emphasizing the need to address the problem.

**Disadvantages:**

- Time-consuming: E2E tests can be slow to execute, as they require the setup and interaction of multiple components.
- Maintenance burden: As the system evolves, E2E tests may need to be updated frequently to accommodate changes in the
  application's behavior, user interface, or underlying services.
- Flakiness: E2E tests can be prone to flakiness, often due to issues like network latency or timeouts. This can lead to
  false negatives and a loss of trust in the testing process.
- Tricky debugging: Debugging E2E tests can be challenging, as the issue could potentially occur anywhere within the
  system, making it more difficult to pinpoint the exact cause of the problem.
- Incomplete coverage due to mocking: Despite their comprehensive nature, E2E tests may still require mocking external
  dependencies, such as third-party APIs or services, which can limit the true end-to-end coverage and potentially mask
  issues related to these external integrations.
- Long feedback loop: E2E tests often require single or multiple deployments, resulting in a longer feedback loop
  compared to tests in isolation. This can slow down the development process and delay the identification and resolution
  of issues.

{% include image.html url="/images/blog/E2E.png" description="E2E tests give us confidence that the System works a whole, but do we really need to connect to everything while testing service F?" %}

### Tests in Isolation: advantages and disadvantages

Tests in isolation, also known as unit tests or component tests, focus on testing individual components or functions
within a system. These tests typically use mock objects or stubs to simulate dependencies, allowing developers to test a
single piece of functionality in isolation from the rest of the system. You can read more about isolated Cypress tests
in my [post](https://www.awesome-testing.com/2020/02/isolated-cypress-ui-tests).

**Advantages:**

- Speed: Isolated tests are generally faster to execute than E2E tests, as they do not require the setup and interaction
  of multiple components.
- Precision: When a test in isolation fails, it usually points directly to the faulty component or function, making it
  easier to identify, debug, and fix issues.
- Maintainability: As these tests focus on specific components, they are less susceptible to changes in the overall
  system, making them easier to maintain over time.
- Short feedback loop: Tests in isolation can run after each push to a Git repository and do not require deployment,
  providing developers with a quicker feedback loop, enabling them to identify and address issues more efficiently.

**Disadvantages:**

- Limited scope: Since tests in isolation focus on individual components, they may not detect integration issues or
  problems that arise when the system is used as a whole.
- Overemphasis on implementation details: Writing tests in isolation can sometimes lead to an overemphasis on the
  internal
  workings of a component, rather than the desired behavior from a user's perspective.
- Potential for over-mocking: Relying heavily on mock objects or stubs can lead to tests that are tightly coupled to the
  implementation, making them brittle and less effective at catching errors.
- Maintenance burden: Keeping mocks up-to-date can be challenging as the system evolves, and failing to do so might
  result in outdated tests that no longer reflect the actual behavior of the system, causing false confidence in the
  test results.
- Limited business value: Tests in isolation provide limited insight into the overall functionality and performance of
  the system. Relying solely on them can be risky, as they do not answer whether the system as a whole
  is working correctly, which is crucial for making informed decisions about the software's readiness for production.

{% include image.html url="/images/blog/Isolation.png" description="Isolated tests scope is very small making them very stable. Each service is tested independently using stubs. But how do we make sure these stubs are up-to-date?" %}

### Achieving Isolation with Docker Compose

While there are not many testing approaches that fall between end-to-end tests and tests in isolation, Docker Compose
emerges as a potential tool of choice to bridge this gap. Docker Compose is a powerful tool for defining and
orchestrating multi-container Docker applications, allowing developers to run and manage multiple services together in
an isolated environment, which can be particularly useful for testing purposes.

As a solution to address the challenges of both end-to-end and isolated tests, Docker Compose enables developers to
exercise their applications with real services, while maintaining a consistent and identical testing environment across
different stages of development. This approach strikes a balance between the realism of end-to-end tests and the speed
of tests in isolation, providing teams with the ability to test complex interactions and integrations with confidence.

By leveraging Docker Compose, teams not only gain the advantage of identifying potential issues early in the development
process but also benefit from a streamlined testing pipeline, making it easier to maintain and manage. With Docker
Compose, developers can experience the best of both worlds, harnessing the strengths of both end-to-end and isolated
testing approaches.

Using `docker-compose.yml` to achieve isolation can have its advantages and challenges:

**Advantages:**

- Shorter feedback loop: By running the entire environment using Docker Compose, developers can avoid the need for
  deployments, thereby shortening the feedback loop and making it easier to identify and resolve issues quickly.
- Reproducible environment: Docker Compose ensures that each service runs in a consistent and reproducible environment,
  reducing the risk of inconsistencies between development, testing, and production.

**Challenges:**

- Dependency management: Implementing a docker-compose.yml setup that correctly manages dependencies can be challenging,
  as developers must ensure that all required services are configured and connected correctly.
- Resource constraints: As the number of services and their resource requirements grow, starting the whole environment
  using Docker Compose can become increasingly difficult due to heavy RAM requirements. This can lead to limitations in
  terms of scalability and the ability to run the environment on local machines.
- Utilizing External APIs: When integrating with external APIs, it's necessary either for the third-party company to
  provide a Dockerized version of their service or for your team to build and maintain your own mock of the external API.
  This can add extra complexity and maintenance overhead to the development process.

By understanding the advantages and disadvantages of end-to-end tests and tests in isolation, as well as the role of
Docker Compose in achieving isolation, you can make more informed decisions about your testing strategy and strike the
right balance for your project. In the next section, we will explore how Contract Testing can bridge the gap between
these two testing approaches.

## Contract Tests: An Introduction

Contract Testing is an approach to integration testing that focuses on the contracts or interactions between different
components of a system. Popularized by Martin Fowler in 2011 through his blog
post [ContractTest](https://martinfowler.com/bliki/ContractTest.html), the idea behind
Contract Testing is to verify that individual components can correctly communicate with each other, adhering to a shared
understanding of how their interactions should work.

One of the main strengths of Contract Testing lies in its ability to complement the testing in isolation strategy by
ensuring that the mocks used in isolated tests are up-to-date and accurate. This is largely due to the asynchronous
nature of contract tests, which allows them to be executed independently of the actual integration between services.

By focusing on the contracts or interactions between components, Contract Testing ensures that the expectations of both
the consumer and provider are aligned. This not only verifies that the components can communicate effectively with each
other but also promotes a better understanding of the system's behavior and dependencies.

At the same time, Contract Testing retains the benefits typically associated with isolated tests, such as speed and fast
feedback. As contracts are tested independently, without the need for setting up and interacting with the actual
integrated system, these tests can be executed more quickly than end-to-end tests. This results in a shorter feedback
loop, enabling developers to identify and address issues more efficiently.

There are several frameworks available for implementing Contract Testing, with Pact and Spring Cloud Contract being
among the most popular. These frameworks offer powerful tools and features for creating and validating contracts between
services, ensuring that both consumers and providers adhere to the agreed-upon expectations.

{% include image.html url="/images/blog/Contract.png" description="Contract tests focus on interfaces (red arrows) making them perfect supplementary for isolated tests." %}

### Pact: A Language-Agnostic Framework for Contract Testing

[Pact](https://docs.pact.io) is a language-agnostic framework for Contract Testing that enables developers to create and
test contracts between services in a variety of programming languages, including Java, JavaScript, Ruby, Go, and others.
Pact provides a set of libraries and tools to generate contract files, validate them against the provider's
implementation, and report any discrepancies.

Key features of Pact include:

- Language-agnostic: Pact supports multiple programming languages, making it suitable for teams working with diverse
  technology stacks.
- Extensive tooling: Pact offers a range of tools for generating, validating, and sharing contracts, streamlining the
  Contract Testing process.
- Mock services: Pact provides mock services that can be used by consumers to simulate the behavior of providers during
  testing, ensuring a consistent testing environment.

### Spring Cloud Contract: Contract Testing for Spring-Based Applications

[Spring Cloud Contract](https://spring.io/projects/spring-cloud-contract) is a framework specifically designed for
implementing Contract Testing in Spring-based applications. It provides support for defining contracts using Groovy or
YAML and integrates seamlessly with the Spring ecosystem. Spring Cloud Contract offers features such as automatic
generation of tests, stubs, and API documentation based on the contracts, making it an attractive choice for developers
working with Spring-based microservices.

Key features of Spring Cloud Contract include:

- Spring integration: Spring Cloud Contract is tailor-made for Spring-based applications, offering seamless integration
  with the Spring ecosystem.
- Flexible contract definition: Contracts can be defined using Groovy or YAML, providing developers with flexibility in
  expressing their expectations.
- Automated test generation: Spring Cloud Contract automatically generates tests and stubs based on the defined
  contracts,
  simplifying the testing process.

By incorporating Contract Testing with popular frameworks like Pact or Spring Cloud Contract, development teams can
ensure better communication and alignment of expectations between service consumers and providers. This ultimately
leads to more reliable software systems with fewer integration issues. In the next sections, we will explore more
advanced concepts and techniques related to Contract Testing, helping you to make the most of this powerful approach to
integration testing.

## Consumer Driven Contract Tests

Consumer-Driven Contract Tests (CDCT) is an approach to Contract Testing that puts the focus on the expectations of the
consumers (clients) while verifying the integration on the provider (server) side. This method ensures that both parties
have a clear understanding of the interactions between them, resulting in more reliable and maintainable software
systems.

The CDCT process consists of five distinct phases:

{% include image.html url="/images/blog/cdct.png" description="CDCT visualisation" %}

**1. Contract creation on the Consumer side**

In this phase, consumers create contracts that define their expectations regarding the API they are consuming. This
step requires writing custom code in all consumer codebases, which specifies the expected behavior of the provider's
API.

{% highlight java %}
public class BasicOkTest extends AbstractPactTest {

    @Override
    public RequestResponsePact createPact(PactDslWithProvider builder) {
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", MediaType.APPLICATION_JSON_VALUE);

        return builder
                .given("Two entries exist")
                .uponReceiving("Two entries exist")
                .path("/information")
                .query("name=" + MESSI)
                .method("GET")
                .willRespondWith()
                .headers(headers)
                .status(200)
                .body(newJsonBody((root) -> {
                    root.numberType("salary", 7500);
                    root.stringType("name", MESSI);
                    root.stringType("nationality", "Argentina");
                }).build())
                .toPact();
    }

    @Override
    protected void runTest(MockServer mockServer, PactTestExecutionContext context) {
        providerService.overrideBackendUrl(mockServer.getUrl());
        Information information = providerService.getResponseForName(MESSI).getBody();
        assertThat(information).isNotNull();
        assertThat(information.getName()).isEqualTo(MESSI);
    }

}
{% endhighlight %}

**2. Publishing the contract to a third-party application - Pact Broker**

Once the contracts are created, they are published to a third-party application called the Pact Broker. The Pact
Broker serves as a centralized repository for storing and managing the contracts between consumers and providers.

**3. Sharing the contract with the Provider**

The contracts are then shared with the provider, ensuring that both parties have access to the agreed-upon
expectations and can work towards fulfilling them.

**4. Contract verification on the Provider side**

In this phase, the provider verifies that their implementation meets the expectations outlined in the contract. This
step requires writing custom code on the provider side, which validates that the API behaves as expected according to
the contract. The contract testing tool utilizes Wiremock to simulate the interactions defined in the contract,
allowing the provider to verify the correctness of their implementation.

{% highlight java %}
@RunWith(SpringRestPactRunner.class)
@Provider("ExampleProvider")
@PactBroker(host = "localhost", port = "9292", tags = {"master"})
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
public class ProviderContractTest {

    @Autowired
    private InformationService informationService;

    @TestTarget
    public final Target target = new SpringBootHttpTarget();

    @State("Empty database state")
    public void emptyDatabase() {
        ContractState.EMPTY.setState(informationService);
    }

    @State("Two entries exist")
    public void defaultState() {
        ContractState.DEFAULT.setState(informationService);
    }

}
{% endhighlight %}

**5. Publishing the results back to the Pact Broker and verifying the contract**

Once the verification process is complete, the results are published back to the Pact Broker. This allows both
parties to review the results and confirm that the contract has been successfully verified, ensuring seamless
integration between the consumer and provider.

{% include image.html url="/images/blog/pactbroker.png" description="Pact Broker showing verified contracts" %}

You can find more information about CDCT and working example in my
repository [PactExample](https://github.com/slawekradzyminski/PactExample).

### Issues with Consumer-Driven Contract Tests

Consumer-Driven Contract Testing (CDCT) is a compelling concept that aims to improve integration testing between
components. However, it has not gained mainstream adoption in the testing community. It's rare to find job descriptions
explicitly requiring knowledge of contract testing. Several factors contribute to the limited adoption of CDCT, and it's
important to note that many of these issues have been addressed in BiDirectional Contract Testing, which will be
discussed later.

**Immature Tooling**

While the CDCT concept started gaining interest among testers, the initial tooling had multiple bugs and limitations
that discouraged early adopters. The lack of mature and reliable tools made it difficult for teams to fully embrace
CDCT, slowing its adoption in the industry.

**Extra Code for Contract Testing**

The need to write and maintain additional code for contract testing purposes can be a significant investment, especially
when dealing with dozens of services. This extra effort might deter teams from adopting CDCT, as it can be seen as an
additional burden on top of their existing development and testing responsibilities.

**Complex State Management**

In CDCT, communication between consumer and provider occurs via contract states. The consumer defines a state, which the
provider then needs to handle, mock, or prepare. This can become complex when the provider has to synchronize with
multiple consumers, each having numerous states. For example, a provider synchronizing with three consumers with 15
states each would need to handle 45 different scenarios in their codebase. In real-world situations, provider teams
often encourage consumers to use the same states, which introduces invisible coupling in consumer codebases, creating
additional complexity.

**Complex Tagging and Change Management**

While the "happy flow" in CDCT is straightforward, things can become complicated when changes need to be made to the
contract between the consumer and provider. Initially, tags were used to manage these changes, but this approach has
been deprecated in favor of using environments. The transition to environments and the complexities that arise during
contract modifications have made CDCT more difficult to manage, hindering its widespread adoption.

**Integration with External APIs**

CDCT presents a challenge when attempting to integrate with external APIs owned by third-party companies. This is
because CDCT requires cooperation in defining contract states, which may not be possible when dealing with external
providers that are outside your organization's control.

It is worth noting that the author of this analysis has never openly endorsed CDCT, acknowledging its limitations and
the need for improvements to make it more accessible and practical for teams to adopt. While CDCT has potential, its
current challenges have limited its impact on the testing landscape, and it remains a niche approach to integration
testing. I recommend to take a look into BiDirectional Contract Testing instead.

## BiDirectional Contract Testing

Bidirectional Contract Testing is a relatively new approach to contract testing that aims to address many of the
limitations associated with Consumer-Driven Contract Testing (CDCT). It is available only in the paid version of
Pactflow (for teams with 5+ users) and has the potential to revolutionize the field of contract testing. By resolving
many of the issues associated with CDCT, Bidirectional Contract Testing makes it more accessible and practical for teams
to adopt.

The Bidirectional Contract Testing flow consists of three main phases:

{% include image.html url="/images/blog/bidi.png" description="BiDirectional Contact Testing" %}

**Provider OpenAPI Specification Upload**

The provider must upload their OpenAPI specification to Pactflow. The OpenAPI specification serves as the source of
truth for the API, providing a clear and accurate description of the API's behavior and functionality.

**Consumer Contract Generation and Upload**

The consumer generates a contract based on their existing isolated tests, using an extension library. Multiple
extensions are available, supporting popular tools
like [WireMock](https://bitbucket.org/atlassian/wiremock-pact-generator/src/master/), [Cypress](https://www.npmjs.com/package/@pactflow/pact-cypress-adapter),
and [Playwright](https://github.com/pactflow/example-bi-directional-consumer-playwright-js). Once the contract is
generated, it must be uploaded to Pactflow as well. This approach simplifies the contract generation process and reduces
the amount of extra code needed for contract testing, making it more appealing to adopt.

It is worth noting that the tooling for this method may still appear to be immature in some aspects. However, as with
any emerging technology, it may take time for the tooling to mature and become more stable. Early adopters of
Bidirectional Contract Testing may encounter limitations, bugs, or other issues that can impact the efficiency and
effectiveness of their testing efforts. It is essential for teams considering adopting this approach to be aware of
these potential challenges and stay informed about updates and improvements to the tools they use.

**Pactflow Contract Validation**

Pactflow performs its "magic" by analyzing the generated consumer contract and the provider's OpenAPI specification. It
then determines whether the mocks defined in the consumer tests meet the provider's requirements as described in their
OpenAPI specification. This automated validation process ensures that the consumer and provider are aligned, promoting
effective communication and reducing the risk of integration issues.

After the contract validation process, both the provider and consumer teams can use
the [can i deploy](https://docs.pact.io/pact_broker/can_i_deploy) tool available
in Pactflow. This tool helps determine whether it is safe to deploy their respective components to production,
considering the current state of contracts and their compatibility. This additional step provides teams with confidence
in their deployments and further reduces the risk of integration issues in production environments.

By addressing the challenges of CDCT, Bidirectional Contract Testing offers a more streamlined and manageable approach
to contract testing. It eliminates the need for complex state management, simplifies change management, and removes the
burden of writing and maintaining extra code for contract testing purposes. Furthermore, it enables integration with
external APIs by leveraging the widely-used OpenAPI standard. With these improvements, Bidirectional Contract Testing
has the potential to become a game-changer in the world of integration testing, making it a valuable addition to any
team's testing toolkit.

### Pactflow pricing

While the open-source Pact Broker offers an extensive set of features for contract testing, it is important to note that
most of the "magic" behind Bidirectional Contract Testing is available exclusively in the paid Pactflow version.

Pactflow builds on the capabilities of the free Pact Broker, providing additional features, support, and enhancements
that are tailored to the needs of professional teams. One of these key enhancements is the support for Bidirectional
Contract Testing.

The pricing for Pactflow can be found on their official [pricing page](https://pactflow.io/pricing/).

## Demo: BiDirectional Contract Testing in Action

In this demo, we will use the following components:

- [bezkoder Spring Boot 3 + OpenAPI example project](https://www.bezkoder.com/spring-boot-swagger-3/)
- My custom client available on [GitHub](https://github.com/slawekradzyminski/bidirectional-contract-testing-consumer)
- My free-tier instance of [Pactflow](https://awesome-testing.pactflow.io)

### Provider

As mentioned earlier, it is impossible to integrate with External APIs using the CDCT approach. With BiDirectional
Contract Testing, this becomes possible, as long as the external API we want to integrate with publishes its OpenAPI
specification. For this demo, we have chosen an example project found on
GitHub: [https://www.bezkoder.com/spring-boot-swagger-3/](https://www.bezkoder.com/spring-boot-swagger-3/)

After running the project via `./mvnw spring-boot:run`, we can access the OpenAPI specification
at [http://localhost:8080/bezkoder-api-docs](http://localhost:8080/bezkoder-api-docs)

To make the demo easier to follow, the `openapi.json` has been uploaded to the consumer
repository: [incompatible OpenAPI](https://github.com/slawekradzyminski/bidirectional-contract-testing-consumer/blob/master/incompatibleopenapi.json)

Please note that there is a bug in the schema (single Tutorial instead of an array of Tutorials) for
the `/api/tutorials`
GET endpoint, which has been fixed by me. The correct specification can be found
here: [openapi.json](https://github.com/slawekradzyminski/bidirectional-contract-testing-consumer/blob/master/openapi.json).
Details about the bug are available
in [README.md](https://github.com/slawekradzyminski/bidirectional-contract-testing-consumer/blob/master/README.md).
Perhaps Pactflow wisely recommends to test OpenAPI specification
via [additional unit tests](https://docs.pactflow.io/docs/workshops/bi-directional/step3).

This demonstrates that BiDirectional Contract Tests have the power to identify bugs and help ensure the accuracy of API
contracts.

Provider contract can be uploaded using
the [publish-provider-contract](https://docs.pactflow.io/docs/bi-directional-contract-testing/contracts/oas#publishing)
Pact CLI command. Pactflow assumes that the Provider OpenAPI specification has been unit tested hence the requirement to
provide verification result file.

{% highlight yml %}
pactflow publish-provider-contract ./openapi.json \
--broker-token=TOKEN \
--broker-base-url=https://awesome-testing.pactflow.io \
--content-type application/json \
--provider the-provider \
--provider-app-version 0.0.4-SNAPSHOT \
--verification-results-content-type text/plain \
--verification-results ./result.txt \
--verification-success \
--verifier self-verification \
--verbose
{% endhighlight %}

### Consumer

The consumer has been entirely created by me, and the code is available here:
[https://github.com/slawekradzyminski/bidirectional-contract-testing-consumer](https://github.com/slawekradzyminski/bidirectional-contract-testing-consumer)

I integrate with Bezkoder's Provider using a dummy /all endpoint, which essentially acts as a proxy:

{% highlight java %}
@RestController
public class ApiController {
@Autowired
TutorialClient tutorialClient;

    @GetMapping("/all")
    public List<TutorialDto> getAll() {
        return tutorialClient.getAll();
    }
}
{% endhighlight %}

In order to test this endpoint, I have to use Wiremock to stub Bezkoder's API:

{% highlight java %}
@Test
void shouldGeneratePactInTargetPactsFolder() throws Exception {
    wiremock.stubFor(WireMock.get(urlEqualTo("/api/tutorials")).willReturn(aResponse()
            .withHeader("Content-Type", "application/json").withBody("""
                    [
                      {
                        "id": 1,
                        "title": "ChatGPT",
                        "description": "blablabla",
                        "published": true
                      }
                    ]
                    """)));

    this.mockMvc.perform(get("/all")).andDo(print()).andExpect(status().isOk())
            .andExpect(jsonPath("$[0].id", is(1)))
            .andExpect(jsonPath("$[0].title", is("ChatGPT")))
            .andExpect(jsonPath("$[0].description", is("blablabla")))
            .andExpect(jsonPath("$[0].published", is(true)));
}
{% endhighlight %}

I assume that your consumers already have similar code (you may mock the HTTP layer using Cypress or Playwright,
but the flow is the same).

Now we only need to add the custom Wiremock Pact creator dependency:

{% highlight xml %}
<dependency>
    <groupId>com.atlassian.ta</groupId>
    <artifactId>wiremock-pact-generator</artifactId>
    <version>2.5.0</version>
</dependency>
{% endhighlight %}

And configure a listener for the Wiremock Server:

{% highlight java %}
@BeforeAll
static void setupClass() {
    wiremock.addMockServiceRequestListener(
            WireMockPactGenerator
                    .builder("the-consumer", "the-provider")
                    .build()
    );
    wiremock.start();
}
{% endhighlight %}

At this point, after running the tests, the consumer contract file is created in the `target/pacts` folder.
I upload it to Pactflow using the `pact-jvm-provider-maven` library via the `./mvnw pact:publish` command.

### Pactflow

At this point, the "magic" happens, and the work related to verifying compatibility takes place on the Pactflow side.
Pactflow compares the uploaded provider contract and consumer contract to determine if the API interactions are
compatible. This process significantly simplifies the work for development teams and ensures that any potential
integration issues are identified before deploying to production.

Now we can see `Success` message with correct `openapi.json`

![](/images/blog/pactflowsuccess.png)

And `Failed` message with incorrect `incompatibleopenapi.json`

![](/images/blog/pactflowfailure.png)

This demonstrates the power of BiDirectional Contract Testing in catching inconsistencies and ensuring
that both the consumer and provider are aligned.

## Summary

In this blog post, we explored the concept of BiDirectional Contract Testing and how it can revolutionize contract
testing by addressing many of the issues associated with Consumer-Driven Contract Testing (CDCT). We went through the
three main phases of the bidirectional contract testing flow and discussed the benefits and limitations of using the
paid Pactflow version for BiDirectional Contract Testing. We also provided a hands-on demo using a custom client, the
bezkoder Spring Boot 3 + OpenAPI example project, and a free-tier instance of Pactflow.

It is fascinating to see whether contract testing will finally reach mainstream adoption, given the advancements and
improvements offered by BiDirectional Contract Testing. It is a powerful approach that can help development teams ensure
the accuracy of their API contracts and significantly reduce the risks associated with integrating external APIs.

We would love to hear your thoughts on BiDirectional Contract Testing. Have you tried it in your projects? How has it
improved your development and testing processes? Do you think this approach will finally bring contract testing into the
mainstream? Please share your experiences, opinions, and insights in the comments section below. Let's foster an
engaging discussion on the future of contract testing!
