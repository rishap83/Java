@eventsregistry_test @all1
Feature: Events Registry Test Scenarios

  Scenario: er1. Test data for events registry
    Given create access token for events registry "producerClient1","ProducerTestApp1"

  Scenario: er2. Producer adds asyncapi payload to the events registry
    When producer adds valid asyncapi payload to the events registry "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 201

  Scenario: er3. Producer adds asyncapi payload with eventname,version,namespace with more than 100 characters
    When producer adds asyncapi payload with invalid eventname,version,namespace "com.trimble.events.registry","aaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccccccccccccccccc","v1.0"
    Then the response should be 400 with message "400 : \"{\"message\":\"Event length cannot be greater than 100\"}\""
    When producer adds asyncapi payload with invalid eventname,version,namespace "com.trimble.events.registry","Er1","v0.01"
    Then the response should be 400 with message "400 : \"{\"message\":\"Version - must follow pattern v[1-9][0-9]{0,2}.[0-9]{1,5}\"}\""
    When producer adds asyncapi payload with invalid eventname,version,namespace "com.trimble.events.registry","Er1","v1.0111111111111111"
    Then the response should be 400 with message "400 : \"{\"message\":\"Version - must follow pattern v[1-9][0-9]{0,2}.[0-9]{1,5}\"}\""
    When producer adds asyncapi payload with invalid eventname,version,namespace "com.trimble.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb","Er1","v1.0"
    Then the response should be 400 with message "400 : \"{\"message\":\"Namespace length cannot be greater than 100\"}\""

  @knownbug
  Scenario: Producer adds invalid asyncapi payload to the events registry - should get exception
    When producer adds invalid asyncapi payload to the events registry
    Then the respone should be 422

  Scenario: er4. Producer adds asyncapi paylod using invalid path - should get exception
    When producer adds asyncapi payload using invalid basepath "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404
    When producer adds asyncapi payload using invalid application API path "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er5. Producer tries to add asyncapi payload that already exists - should get exception
    When producer adds valid asyncapi payload to the events registry that already exists "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 400

  Scenario: er6. Producer tries to add empty asyncapi payload - should get exception
    When producer tries to add empty asyncapi payload "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 400

  Scenario: er7. Producer tries to add asyncapi payload with invalid token - should get exception
    Given create access token for events registry "producerClient2","ProducerTestApp2"
    When producer adds valid asyncapi payload with unsubscribed application access token to API product "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer adds valid asyncapi payload with invalid access token "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401

  Scenario: er8. Producer tries to add asyncapi with invalid environment header value - should get exception
    When producer tries to add asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","qa1"
    Then the response should be 400
    When producer tries to add asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","QA"
    Then the response should be 400
    When producer tries to add asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","PT"
    Then the response should be 400
    When producer tries to add asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV2"
    Then the response should be 400
    When producer tries to add asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV"
    Then the response should be 400

  Scenario: er9. Producer updates asyncapi payload to the events registry
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer updates valid asyncapi payload to the events registry "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 200
    When producer gets asyncapi payload that exists from events registry "com.trimble.events.registry","Er1","v1.1","test description1"
    Then the response should be 200
  @knownbug
  Scenario: Producer updates invalid asyncapi payload to the events registry - should get exception
    When producer updates invalid asyncapi payload to the events registry
    Then the respone should be 422

  Scenario: er10. Producer updates asyncapi paylod using invalid path - should get exception
    When producer updates asyncapi payload using invalid basepath "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404
    When producer updates asyncapi payload using invalid application API path "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er11. Producer tries to update asyncapi payload that does not exists - should get exception
    When producer updates asyncapi payload that does not exists "com.trimble.events.registry","Er1","v1.81"
    Then the response should be 404
    When producer updates asyncapi payload that does not exists "com.trimble.tid.registry","Er1","v1.1"
    Then the response should be 404
    When producer updates asyncapi payload that does not exists "com.trimble.events.registry","Ee1","v1.1"
    Then the response should be 404
    When producer updates asyncapi payload that does not exists "com.trimble.events.registry","Er1","V1.1"
    Then the response should be 404
    When producer updates asyncapi payload that does not exists "com.trimble.EVENTS.registry","Er1","v1.1"
    Then the response should be 404
    When producer updates asyncapi payload that does not exists "com.trimble.events.registry","ER1","v1.1"
    Then the response should be 404

  Scenario: er12. Producer tries to update with empty asyncapi payload - should get exception
    When producer tries to update with empty asyncapi payload "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 400

  Scenario: er13. Producer tries to update asyncapi payload with invalid token - should get exception
    Given create access token for events registry "producerClient2","ProducerTestApp2"
    When producer tries to update asyncapi with unsubscribed application access token to API product "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer tries to update asyncapi with invalid token "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401

  Scenario: er14. Producer tries to update asyncapi for stg/prod environment - should get exception
    When producer tries to update asyncapi for stg-prod environment "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 403

  Scenario: er15. Producer tries to update environment for asyncapi specification - should get exception
    When producer tries to update environment for asyncapi specification "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er16. Producer tries to update asyncapi with invalid environment header value - should get exception
    When producer tries to update asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","qa1"
    Then the response should be 400
    When producer tries to update asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","QA"
    Then the response should be 400
    When producer tries to update asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","PT"
    Then the response should be 400
    When producer tries to update asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV2"
    Then the response should be 400
    When producer tries to update asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV"
    Then the response should be 400

  Scenario: er17. Producer adds data to the events registry
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer adds data to the events registry "com.trimble.events.registry","Er1","v1.1","JSON"
    Then the response should be 201
    When producer adds text data to the events registry "com.trimble.events.registry","Er2","v1.2"
    Then the response should be 201
    When producer adds yaml as text data to the events registry "com.trimble.events.registry","Er3","v1.3"
    Then the response should be 201
    When producer adds html data to the events registry "com.trimble.events.registry","Er4","v1.4"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er5","v1.5","AVRO"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er6","v1.6","OPENAPI"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er7","v1.7","ASYNCAPI"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er8","v1.8","XML"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er9","v1.9","PROTOBUF"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er10","v1.10","GRAPHQL"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er11","v1.11","KCONNECT"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er12","v1.12","WSDL"
    Then the response should be 201
    When producer adds data to the events registry "com.trimble.events.registry","Er13","v1.13","XSD"
    Then the response should be 201

  Scenario: er18. Producer adds data payload with eventname,version,namespace with more than 100 characters
    When producer adds data payload with invalid eventname,version,namespace "com.trimble.events.registry","aaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccccccccccccccccc","v1.0","JSON"
    Then the response should be 400 with message "400 : \"{\"message\":\"Event length cannot be greater than 100\"}\""
    When producer adds data payload with invalid eventname,version,namespace "com.trimble.events.registry","Er1","v0.01","JSON"
    Then the response should be 400 with message "400 : \"{\"message\":\"Version - must follow pattern v[1-9][0-9]{0,2}.[0-9]{1,5}\"}\""
    When producer adds data payload with invalid eventname,version,namespace "com.trimble.events.registry","Er1","v1.0111111111111111","JSON"
    Then the response should be 400 with message "400 : \"{\"message\":\"Version - must follow pattern v[1-9][0-9]{0,2}.[0-9]{1,5}\"}\""
    When producer adds data payload with invalid eventname,version,namespace "com.trimble.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb","Er1","v1.0","JSON"
    Then the response should be 400 with message "400 : \"{\"message\":\"Namespace length cannot be greater than 100\"}\""

  Scenario: er19. Producer adds data with invalid schema type
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","ABC"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","YAML"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","123"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14",",./;"
    Then the response should be 400
    When producer adds data without schema type "com.trimble.events.registry","Er14","v1.14"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","avro"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","openapi"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","asyncapi"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","xml"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","protobuf"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","graphql"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","kconnect"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","wsdl"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","xsd"
    Then the response should be 400
    When producer adds data with invalid schema type "com.trimble.events.registry","Er14","v1.14","json"
    Then the response should be 400

  Scenario: er20. Producer adds data using invalid path - should get exception
    When producer adds data using invalid basepath "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404
    When producer adds data using invalid application API path "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er21. Producer tries to add data that already exists - should get exception
    When producer adds data to the events registry that already exists "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 400

  Scenario: er22. Producer tries to add empty data payload - should get exception
    When producer tries to add empty data payload "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 400

  Scenario: er23. Producer tries to add data with invalid token - should get exception
    Given create access token for events registry "producerClient2","ProducerTestApp2"
    When producer tries to add data with unsubscribed application access token to API product "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer tries to add data with invalid token "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401

  Scenario: er24. Producer tries to add data with invalid environment header value - should get exception
    When producer tries to add data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","qa1"
    Then the response should be 400
    When producer tries to add data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","QA"
    Then the response should be 400
    When producer tries to add data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","PT"
    Then the response should be 400
    When producer tries to add data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV2"
    Then the response should be 400
    When producer tries to add data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV"
    Then the response should be 400

  Scenario: er25. Producer updates data to the events registry
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer updates JSON data to the events registry "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 200
    When producer gets data that exists from the events registry "com.trimble.events.registry","Er1","v1.1","com.trimble.events.registry1"
    Then the response should be 200

  Scenario: er26. Producer updates data using invalid path - should get exception
    When producer updates data using invalid basepath "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404
    When producer updates data using invalid application API path "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er27. Producer tries to update data that does not exists - should get exception
    When producer tries to update data that does not exist "com.trimble.events.registry","Er1","v1.81"
    Then the response should be 404
    When producer tries to update data that does not exist "com.trimble.tid.registry","Er1","v1.1"
    Then the response should be 404
    When producer tries to update data that does not exist "com.trimble.events.registry","Ee1","v1.1"
    Then the response should be 404
    When producer tries to update data that does not exist "com.trimble.events.registry","Er1","V1.1"
    Then the response should be 404
    When producer tries to update data that does not exist "com.trimble.EVENTS.registry","Er1","v1.1"
    Then the response should be 404
    When producer tries to update data that does not exist "com.trimble.events.registry","ER1","v1.1"
    Then the response should be 404

  Scenario: er28. Producer tries to update with empty data payload - should get exception
    When producer tries to update with empty data payload "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 400

  Scenario: er29. Producer tries to update data with invalid token - should get exception
    Given create access token for events registry "producerClient2","ProducerTestApp2"
    When producer tries to update data with unsubscribed application access token to API product "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer tries to update data with invalid token "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401

  Scenario: er30. Producer tries to update data for stg/prod environment - should get exception
    When producer tries to update data for stg-prod environment "com.trimble.events.registry","Er1","v1.4"
    Then the response should be 403

  Scenario: er31. Producer tries to update environment for data specification - should get exception
    When producer tries to update environment for data specification "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er32. Producer tries to update data with invalid environment header value - should get exception
    When producer tries to update data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","qa1"
    Then the response should be 400
    When producer tries to update data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","QA"
    Then the response should be 400
    When producer tries to update data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","PT"
    Then the response should be 400
    When producer tries to update data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV2"
    Then the response should be 400
    When producer tries to update data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV"
    Then the response should be 400

  Scenario: er33. Producer gets asyncapi payload that exists from the events registry
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer gets asyncapi payload that exists from events registry "com.trimble.events.registry","Er1","v1.1","test description1"
    Then the response should be 200

  Scenario: er34. Producer gets asyncapi paylod using invalid path - should get exception
    When producer gets asyncapi payload using invalid basepath "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404
    When producer gets asyncapi payload using invalid application API path "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er35. Producer tries to get asyncapi payload that does not exists from events registry - should get exception
    When producer tries to get asyncapi payload that does not exist "com.trimble.events.registry","Er1","v1.81"
    Then the response should be 404
    When producer tries to get asyncapi payload that does not exist "com.trimble.tid.registry","Er1","v1.1"
    Then the response should be 404
    When producer tries to get asyncapi payload that does not exist "com.trimble.events.registry","Ee1","v1.1"
    Then the response should be 404
    When producer tries to get asyncapi payload that does not exist "com.trimble.events.registry","Er1","V1.1"
    Then the response should be 404
    When producer tries to get asyncapi payload that does not exist "com.trimble.EVENTS.registry","Er1","v1.1"
    Then the response should be 404
    When producer tries to get asyncapi payload that does not exist "com.trimble.events.registry","ER1","v1.1"
    Then the response should be 404

  Scenario: er36. Producer tries to get asyncapi payload with invalid token - should get exception
    Given create access token for events registry "producerClient2","ProducerTestApp2"
    When producer tries to get asyncapi with unsubscribed application access token to API product "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer tries to get asyncapi with invalid token "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401

  Scenario: er37. Producer tries to get asyncapi with invalid environment header value - should get exception
    When producer tries to get asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","qa1"
    Then the response should be 400
    When producer tries to get asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","QA"
    Then the response should be 400
    When producer tries to get asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","PT"
    Then the response should be 400
    When producer tries to get asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV2"
    Then the response should be 400
    When producer tries to get asyncapi with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV"
    Then the response should be 400

  Scenario: er38. Producer gets data that exists from the events registry
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer gets data that exists from the events registry "com.trimble.events.registry","Er1","v1.1","com.trimble.events.registry1"
    Then the response should be 200

  Scenario: er39. Producer gets data using invalid path - should get exception
    When producer gets data using invalid basepath "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404
    When producer gets data using invalid application API path "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 404

  Scenario: er40. Producer tries to get data that does not exists from events registry - should get exception
    When producer tries to get data that does not exist "com.trimble.events.registry","Er1","v1.81"
    Then the response should be 404
    When producer tries to get data that does not exist "com.trimble.tid.registry","Er1","v1.1"
    Then the response should be 404
    When producer tries to get data that does not exist "com.trimble.events.registry","Ee1","v1.1"
    Then the response should be 404
    When producer tries to get data that does not exist "com.trimble.events.registry","Er1","V1.1"
    Then the response should be 404
    When producer tries to get data that does not exist "com.trimble.EVENTS.registry","Er1","v1.1"
    Then the response should be 404
    When producer tries to get data that does not exist "com.trimble.events.registry","ER1","v1.1"
    Then the response should be 404

  Scenario: er41. Producer tries to get data with invalid token should get exception
    Given create access token for events registry "producerClient2","ProducerTestApp2"
    When producer tries to get data with unsubscribed application access token to API product "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401
    Given create access token for events registry "producerClient1","ProducerTestApp1"
    When producer tries to get data with invalid token "com.trimble.events.registry","Er1","v1.1"
    Then the response should be 401

  Scenario: er42. Producer tries to get data with invalid environment header value - should get exception
    When producer tries to get data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","qa1"
    Then the response should be 400
    When producer tries to get data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","QA"
    Then the response should be 400
    When producer tries to get data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","PT"
    Then the response should be 400
    When producer tries to get data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV2"
    Then the response should be 400
    When producer tries to get data with invalid header environment value "com.trimble.events.registry","Er1","v1.1","DEV"
    Then the response should be 400

  Scenario: er43. Producer tries to use unsupported http method for asyncapi api - should get exception
    When producer tries to use patch method for asyncapi api should get exception "com.trimble.events.registry","Er1","v1.1"

  Scenario: er44. Producer tries to use unsupported http method for data api - should get exception
    When producer tries to use patch method for data api should get exception "com.trimble.events.registry","Er1","v1.1"

  Scenario: er45. Producer gets stg/prod asyncapi payload that exists from the events registry
    When producer gets stg-prod asyncapi payload that exists from events registry "com.trimble.events.registry","Er1","v1.7","This is a test event in events BDD integration test with Karate"
    Then the response should be 200

  Scenario: er46. Producer gets stg/prod data that exists from the events registry
    When producer gets stg-prod data that exists from the events registry "com.trimble.events.registry","Er1","v1.7","com.trimble.events.registry"
    Then the response should be 200

