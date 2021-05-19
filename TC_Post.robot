*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections

*** Variables ***

${base_url}=    https://reqres.in

*** Test Cases ***

TC1: Post Customer Registration
    create session   mysession   ${base_url}
    ${body}=    create dictionary   email=eve.holt@reqres.in    password=pistol
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=    post request  mysession   /api/register     data=${body}     headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #Validations
    ${status}=   convert to string  ${response.status_code}
    should be equal  ${status}   200

    ${content}=   convert to string  ${response.content}
    should contain   ${content}   4

