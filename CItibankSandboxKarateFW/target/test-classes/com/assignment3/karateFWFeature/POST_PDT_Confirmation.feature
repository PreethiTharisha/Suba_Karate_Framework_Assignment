@Regression @POST_PDT_Confirmation
Feature: POST_PDT-Confirmation APIs

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')
    * def PDT_Confirmation_Payload = read('classpath:com/assignment3/karateFW/testdata/PDT_Confirmation_payload.json')

  @TC_21 @PDT_Confirmation @Positive
  Scenario: Initiate the PDT-Confirmation API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/POST_PDT-PreProcess.feature@PDT_PreProcess')
    Given url testData.baseURI + testData.PDT_Confirmation_Resource
    And header Authorization = authorization
    And header uuid = randomString(20)
    And header Accept = testData.Content_Type_PDT_Confirmation
    And header client_id = testData.client_Id
    And header Content-Type = testData.Content_Type_PDT_Confirmation
    * set PDT_Confirmation_Payload.controlFlowID = controlFlowId
    * print 'POST_PDT-Confirmation Payload Request : ' + PDT_Confirmation_Payload
    And request PDT_Confirmation_Payload
    When method post
    Then status 200
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * print '********* PDT-Confirmation Done *********'

 
 
   @TC_22 @PDT_Confirmation_Negative @Negative
  Scenario: To verify the PDT-Confirmation API with invalid controlFlowId
    * call read('classpath:com/assignment3/karateFWFeature/POST_PDT-PreProcess.feature@PDT_PreProcess')
    Given url testData.baseURI + testData.PDT_Confirmation_Resource
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    And header Content-Type = testData.Content_Type_PDT_Confirmation
    * set PDT_Confirmation_Payload.controlFlowID = testData.InvalidcontrolFlowID
    * print 'POST_PDT-Confirmation Payload Request : ' + PDT_Confirmation_Payload
    And request PDT_Confirmation_Payload
    When method post
    Then status 400
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == 'invalidRequest'
    * match response.details == 'Missing or invalid Parameters'
    * print '********* PDT-Confirmation with invalid_controlflowid  *********'
    * print '********* PDT-Confirmation Done *********'