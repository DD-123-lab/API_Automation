*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections

*** Variables ***

${base_url}=    http://restapi.demoqa.com/customer
${city}=    Delhi
*** Test Cases ***

TC1: Post Customer Registration
    create session   mysession   ${base_url}
    ${body}=    create dictionary   FirstName=dd  LastName=123  UserName=dd_123     Password=dd_123   Email=dd_123@gmail.com
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=    post request  mysession   /register     data=${body}     headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #Validations
    ${status}=   convert to string  ${response.status_code}
    should be equal  ${status}   201

    ${content}=   convert to string  ${response.content}
    should contain   ${content}   Operation completed successfully