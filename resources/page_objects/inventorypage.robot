*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Resource    ../base_xpaths.robot

*** Variables ***
${AllProductListXpath}    xpath://div[contains(@class,'inventory_item_name')]
${SortDropdown}    xpath://select[@class='product_sort_container']

*** Keywords ***
Add Product to Shopping Cart
    [Arguments]    ${ProductTitle}
    ${AddProductToCart}    Get Add to cart button using Product Title    ${ProductTitle}
    Element Text Should Be    ${AddProductToCart}    Add to cart
    Scroll Element Into View    ${AddProductToCart}
    Click Button    ${AddProductToCart}
    Element Text Should Be    ${AddProductToCart}    Remove

Remove Product from Shopping Cart
    [Arguments]    ${ProductTitle}
    ${RemoveProductToCart}    Get Remove button using Product Title    ${ProductTitle}
    Element Text Should Be    ${RemoveProductToCart}    Remove
    Scroll Element Into View    ${RemoveProductToCart}
    Click Button    ${RemoveProductToCart}
    Element Text Should Be    ${RemoveProductToCart}    Add to cart

Get Add to cart button using Product Title
    [Arguments]    ${ProductTitle}
    ${AddToCart}    Set Variable    xpath://div[.='${ProductTitle}']//..//..//..//button
    Return From Keyword    ${AddToCart}

Get Remove button using Product Title
    [Arguments]    ${ProductTitle}
    ${Remove}    Set Variable    xpath://div[.='${ProductTitle}']//..//..//..//button
    Return From Keyword    ${Remove}

Get Product price using Product Title
    [Arguments]    ${ProductTitle}
    ${Price}    Set Variable    xpath://div[.='${ProductTitle}']//..//..//..//div[@class='inventory_item_price']
    Return From Keyword    ${Price}

Add all products to shopping cart
    @{ProductElementsList}    Get WebElements    ${AllProductListXpath}
    FOR    ${ProductElement}     IN     @{ProductElementsList}
        ${ProductTitle}    Get Text    ${ProductElement}
        Add Product to Shopping Cart    ${ProductTitle}
    END

Remove all products from shopping cart
    @{ProductElementsList}    Get WebElements    ${AllProductListXpath}
    FOR    ${ProductElement}     IN     @{ProductElementsList}
        ${ProductTitle}    Get Text    ${ProductElement}
        Remove Product from Shopping Cart    ${ProductTitle}
    END

Select sorting order
    [Arguments]    ${ExpectedSortOrder}
    Select From List By Label    ${SortDropdown}    ${ExpectedSortOrder}
    ${SelectedValue}    Get Selected List Label    ${SortDropdown}
    Should Be Equal    ${SelectedValue}    ${ExpectedSortOrder}

Get Product Title List
    @{SortedList}    Create List    
    @{ProductElementList}    Get WebElements    ${AllProductListXpath}
    FOR    ${Element}    IN    @{ProductElementList}
        ${ProdTitle}    Get Text    ${Element}
        Append To List   ${SortedList}     ${ProdTitle}
    END
    Return From Keyword    ${SortedList}
     
Get Product Price List
    @{SortedList}    Create List    
    @{ProductElementList}    Get WebElements    ${AllProductListXpath}
    FOR    ${Element}    IN    @{ProductElementList}
        ${ProdTitle}    Get Text    ${Element}
        ${ItemPriceElement}    Get Product price using Product Title    ${ProdTitle}
        ${ItemPriceStr}    Get Text    ${ItemPriceElement}
        ${ItemPriceStr}    Remove String        ${ItemPriceStr}   ,    $
        ${ItemPrice}    Convert to Number    ${ItemPriceStr}
        Append To List   ${SortedList}     ${ItemPrice}
    END
    Return From Keyword    ${SortedList}

Verify product title sorting order A to Z
    @{ATOZSortedList}    Get Product Title List
    @{SortedProductList}    Copy List    ${ATOZSortedList}
    Sort List    ${SortedProductList}
    Lists Should Be Equal    ${SortedProductList}    ${ATOZSortedList}

Verify product title sorting order Z to A
    @{ZTOASortedList}    Get Product Title List
    @{SortedProductList}    Copy List    ${ZTOASortedList}
    Sort List    ${SortedProductList}
    Reverse List    ${SortedProductList}
    Lists Should Be Equal    ${SortedProductList}    ${ZTOASortedList}

Verify price sorting order low to high
    @{PriceLowToHighSortedList}    Get Product Price List
    @{SortedProductList}    Copy List    ${PriceLowToHighSortedList}
    Sort List    ${SortedProductList}
    Lists Should Be Equal    ${SortedProductList}    ${PriceLowToHighSortedList}

Verify price sorting order high to low
    @{PriceHighToLowSortedList}    Get Product Price List
    @{SortedProductList}    Copy List    ${PriceHighToLowSortedList}
    Sort List    ${SortedProductList}
    Reverse List    ${SortedProductList}
    Lists Should Be Equal    ${SortedProductList}    ${PriceHighToLowSortedList}
