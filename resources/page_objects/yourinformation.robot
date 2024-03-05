*** Settings ***
Library    SeleniumLibrary
Resource          ../../resources/resource.robot
*** Variables ***
${firstName}    id:first-name
${lastName}    id:last-name
${postCode}    id:postal-code
${continueBtn}    id:continue
${cancelBtn}    id:cancel

*** Keywords ***
Enter Personal Info and continue
    [Arguments]    ${fNameValue}    ${lNameValue}    ${postCodeValue}
    Input Text    ${firstName}    ${fNameValue}
    Input Text    ${lastName}    ${lNameValue}
    Input Text    ${postCode}    ${postCodeValue}
    Click Button    ${continueBtn}
    Location Should Be    ${BASE_URL}checkout-step-two.html