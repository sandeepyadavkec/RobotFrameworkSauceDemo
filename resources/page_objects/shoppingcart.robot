*** Settings ***
Library    SeleniumLibrary
Resource    ../resource.robot
*** Variables ***
${CheckoutButton}    id:checkout
${ContinueShopping}    id:continue-shopping

*** Keywords ***
Verify Product Title and Price in cart
    [Arguments]    ${ProductTitle}  ${ExpectedPrice}
    ${ActualPrice}    Get Product price from cart using Product Title    ${ProductTitle}
    Element Text Should Be    ${ActualPrice}    ${ExpectedPrice}

Get Remove from cart button using Product Title
    [Arguments]    ${ProductTitle}
    ${Remove}    Set Variable    xpath://div[.='${ProductTitle}']//..//..//..//button
    Return From Keyword    ${Remove}

Get Product price from cart using Product Title
    [Arguments]    ${ProductTitle}
    ${Price}    Set Variable    xpath://div[.='${ProductTitle}']//..//..//..//div[@class='inventory_item_price']
    Return From Keyword    ${Price}

Proceed to Checkout
    Scroll Element Into View    ${CheckoutButton}
    Click Button    ${CheckoutButton}
    Location Should Be    ${BASE_URL}checkout-step-one.html

Back to Shopping
    Scroll Element Into View    ${ContinueShopping}
    Click Button    ${ContinueShopping}

Remove Product from Shopping Cart in cart page
    [Arguments]    ${ProductTitle}
    ${RemoveProductToCart}    Get Remove from cart button using Product Title    ${ProductTitle}
    Element Text Should Be    ${RemoveProductToCart}    Remove
    Scroll Element Into View    ${RemoveProductToCart}
    Click Button    ${RemoveProductToCart}
    Element Should Not Be Visible    ${RemoveProductToCart}
    