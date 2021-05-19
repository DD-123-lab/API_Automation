*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections
Library  JSONLibrary

*** Variables ***
${base_url}=  http://10.145.14.39:32003

*** Test Cases ***

TC:Get Device Details
    create session  mysession  ${base_url}
    ${body}=    create dictionary  serialNumber=urn:imei:767653245457535
    ${header}=  create dictionary   Authorization=Basic dXNlcjI6cGFzc3dvcmQy   Accept=application/json    Content-Type=application/json
    ${response}=    post request   mysession   /dm/v1/device  data=${body}    headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    #Validations
    ${status}=   convert to string  ${response.status_code}
    should be equal  ${status}   200
    ${contentType}=      get from dictionary      ${response.headers}   Content-Type
    should contain  ${contentType}    application/json;charset=utf-8

    ${Json_obj}=   to json    ${response.content}

    ${serialNumber}=    get value from json     ${Json_obj}     $.serialNumber

    log to console      ${serialNumber[0]}

    should be equal     ${serialNumber[0]}