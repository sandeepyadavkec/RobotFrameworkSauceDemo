*** Settings ***
Library           SeleniumLibrary
Library           String
Library           ../libraries/chrome_options.py
Resource          ./base_xpaths.robot

*** Variables ***
${BASE_URL}=         https://www.saucedemo.com/
${TITLE}=            Swag Labs
${username}    standard_user
${password}     secret_sauce
${ImplicitWait}    10 seconds
${SeleniumDelay}    0.05 seconds

*** Keywords ***
Open Browser and Navigate To Page
    ${options}    Get Chrome Options
    Open Browser    browser=chrome    options=${options}
    Go to    ${BASE_URL}
    Set Selenium Implicit Wait    ${ImplicitWait}
    Set Selenium Speed    ${SeleniumDelay}

Section Title Should Be
    [Arguments]    ${SectionTitleText}
    Element Text Should Be    ${SectionTitle}    ${SectionTitleText}
    

Navigate to Shopping Cart
    Scroll Element Into View    ${ShoppingCart}
    Click Element    ${ShoppingCart}
    Location Should Be    ${BASE_URL}cart.html

Verify Section Title
    [Arguments]    ${SectionTitleText}
    Section Title Should Be     ${SectionTitleText}

Verify Product Count in Cart
    [Arguments]    ${ExpectedCount}
    Element Text Should Be    ${ShoppingCartBadge}    ${ExpectedCount}

Verify Product Count is 0
    Element Should Not Be Visible    ${ShoppingCartBadge}