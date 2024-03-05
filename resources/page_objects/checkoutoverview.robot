*** Settings ***
Library    SeleniumLibrary
Resource    ../resource.robot
*** Variables ***
${PaymentInformation}    xpath://div[@class='summary_info']//div[@class='summary_value_label'][1]
${ShippingInformation}    xpath://div[@class='summary_info']//div[@class='summary_value_label'][2]
${ItemTotal}    xpath://div[@class='summary_subtotal_label']
${TotalTax}    xpath://div[@class='summary_tax_label']
${TotalPrice}    xpath://div[contains(@class,'summary_total_label')]
${FinishBtn}    id:finish


*** Keywords ***
Verify Product Title and Price in checkout overview
    [Arguments]    ${ProductTitle}  ${ExpectedPrice}
    ${ActualPrice}    Get Product price from checkout overview using Product Title    ${ProductTitle}
    Element Text Should Be    ${ActualPrice}    ${ExpectedPrice}

Verify Payment Information
    [Arguments]    ${ExpectedPaymentInfo}
    Element Text Should Be    ${PaymentInformation}    ${ExpectedPaymentInfo}

Verify Shipping Information
    [Arguments]    ${ExpectedShippingInfo}
    Element Text Should Be    ${ShippingInformation}    ${ExpectedShippingInfo}

Verify Item Total, Tax & Total Price
    [Arguments]    ${ExpectedItemTotal}    ${ExpectedTax}    ${ExpectedTotalPrice}
    Scroll Element Into View    ${TotalPrice}
    Element Should Contain    ${ItemTotal}    ${ExpectedItemTotal}
    Element Should Contain    ${TotalTax}    ${ExpectedTax}
    Element Should Contain    ${TotalPrice}    ${ExpectedTotalPrice}

Get Product price from checkout overview using Product Title
    [Arguments]    ${ProductTitle}
    ${Price}    Set Variable    xpath://div[.='${ProductTitle}']//..//..//..//div[@class='inventory_item_price']
    Return From Keyword    ${Price}

Get Product quanity from checkout overview using Product Title
    [Arguments]    ${ProductTitle}
    ${Quanity}    Set Variable    xpath://div[.='${ProductTitle}']//..//..//..//div[@class='cart_quantity']
    Return From Keyword    ${Quanity}

Finish Checkout
    Scroll Element Into View    ${FinishBtn}
    Click Button    ${FinishBtn}
    Location Should Be    ${BASE_URL}checkout-complete.html