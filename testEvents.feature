@consumermetadata @all1
Feature: Consumer metadata scenarios
  Scenario: lm1. Test data for consumer metadata
    Given initialise properties

    Given the namespace is created by Events team "com.trimble.test.md"

    Given the event is created by Events team "Em1","ScM1","v1.1","producerClient1"
    Given subscription is created by Events team "Em1","Sm1","v1.1","consumerMetadataClient1","1"

    Given the event is created by Events team "Em2","ScM2","v1.2","producerClient2"
    Given subscription is created by Events team "Em2","Sm4","v1.2","consumerMetadataClient1","1"
    Given subscription is created by Events team "Em2","Sm2","v1.2","consumerMetadataClient2","5"
    Given subscription is created by Events team "Em2","Sm3","v1.2","consumerMetadataClient3","1"

    Given the simple filter event is created by Events team "Em4","ScM4","v1.4","producerClient3"
    Given simple filter subscription is created by Events team "Em4","Sm6","v1.4","consumerMetadataClient1","1"

    Given the event is created by Events team with two partitions "Em5","ScM5","v1.5","producerClient4"
    Given subscription is created by Events team with http protocol with 2 instances "Em5","Sm7","v1.5","consumerMetadataClient1","1"

    And subscriptions are getting activated for consumer metadata "com.trimble.test.md"

  Scenario: lm2. Get metadata for subscriptions
    And the Producer produced n messages to the Events "com.trimble.test.md","Em1","v1.1","producerClient1",20,"ProducerTestApp1"
    Given create admin access token for consumer metadata "consumerMetadataClient1"
    And Consumer waits for 3mins to get metadata
    And the Consumer gets metadata status 1.0 for the subscriptions before consume "com.trimble.test.md","Em1","v1.1",20
    And the Consumer gets metadata status 1.1 for the subscriptions before consume "com.trimble.test.md","Em1","v1.1",20
    Given consumer consumes the message 10 times "com.trimble.test.md","Em1","v1.1","consumerMetadataClient1","Consumer3"
    And Consumer waits for 5mins to get metadata
    And Consumer waits for 5mins to get metadata
    And the Consumer gets metadata status 1.0 for the subscriptions after consume "com.trimble.test.md","Em1","v1.1",10
    And the Consumer gets metadata status 1.1 for the subscriptions after consume "com.trimble.test.md","Em1","v1.1",10
    Given consumer consumes the message 30 times "com.trimble.test.md","Em1","v1.1","consumerMetadataClient1","Consumer3"
    And Consumer waits for 5mins to get metadata
    And Consumer waits for 5mins to get metadata
    And the Consumer gets metadata status 1.0 for the subscriptions before consume "com.trimble.test.md","Em1","v1.1",0
    And the Consumer gets metadata status 1.1 for the subscriptions before consume "com.trimble.test.md","Em1","v1.1",0