*** Settings ***
Library           SeleniumLibrary
Resource          ../../resources/resource.robot

*** Variables ***

${UsernameTxtBox}    id:user-name
${PasswordTxtBox}    id:password
${LoginBtn}    id:login-button

*** Keywords ***
Submit Credentials
    Scroll Element Into View    ${LoginBtn}
    Click Button    ${LoginBtn}

Welcome Page Should Be Open
    Location Should Be    ${BASE_URL}inventory.html
    Title Should Be     ${TITLE}

Login with valid Credentials
    [Arguments]    ${user}    ${password}
    Input Text    ${UsernameTxtBox}    ${user}
    Input Password    ${PasswordTxtBox}    ${password}
    Submit Credentials
    Welcome Page Should Be Open