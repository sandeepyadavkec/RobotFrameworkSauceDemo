*** Settings ***
Library    SeleniumLibrary
Resource    ../resource.robot
*** Variables ***
${OrderCompleteMsg}    xpath://h2[@class='complete-header']
${BackToHomeBtn}    id:back-to-products

*** Keywords ***
Verify order completion
    Element Text Should Be    ${OrderCompleteMsg}    Thank you for your order!

Back to Home
    Scroll Element Into View    ${BackToHomeBtn}
    Click Button    ${BackToHomeBtn}
    Location Should Be    ${BASE_URL}inventory.html
