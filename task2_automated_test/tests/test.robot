*** Settings ***
Documentation     A test suite to test the functionality of e-commerce web app
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../../resources/resource.robot
Resource          ../../resources/page_objects/loginpage.robot
Resource          ../../resources/page_objects/inventorypage.robot
Resource          ../../resources/page_objects/shoppingcart.robot
Resource          ../../resources/page_objects/yourinformation.robot
Resource          ../../resources/page_objects/checkoutoverview.robot
Resource          ../../resources/page_objects/checkoutcomplete.robot

Library           SeleniumLibrary
Test Teardown     Close All Browsers

*** Test Cases ***
Valid Login
    [Tags]  authentication
    Open Browser and Navigate To Page
    Login with valid Credentials    ${username}    ${password}

Verify Cart Checkout
    [Tags]    regression
    Open Browser and Navigate To Page
    Login with valid Credentials    ${username}    ${password}
    Add Product to Shopping Cart    Sauce Labs Backpack
    Add Product to Shopping Cart    Sauce Labs Bike Light
    Navigate to Shopping Cart
    Verify Section Title    Your Cart
    Verify Product Title and Price in cart    Sauce Labs Backpack    $29.99
    Verify Product Title and Price in cart    Sauce Labs Bike Light    $9.99
    Proceed to Checkout
    Verify Section Title    Checkout: Your Information
    Enter Personal Info and continue    Sandeep    Yadav    3024
    Verify Section Title    Checkout: Overview
    Verify Product Title and Price in checkout overview    Sauce Labs Backpack    $29.99
    Verify Product Title and Price in checkout overview    Sauce Labs Bike Light    $9.99
    Verify Payment Information    SauceCard #31337
    Verify Shipping Information    Free Pony Express Delivery!
    Verify Item Total, Tax & Total Price    $39.98    $3.20    $43.18
    Finish Checkout
    Verify Section Title    Checkout: Complete!
    Verify order completion
    Back to Home


Verify Add all product and remove product
    [Tags]    regression
    Open Browser and Navigate To Page
    Login with valid Credentials    ${username}    ${password}
    Add all products to shopping cart
    Navigate to Shopping Cart
    Verify Section Title    Your Cart
    Verify Product Count in Cart    6
    Verify Product Title and Price in cart    Sauce Labs Backpack    $29.99
    Verify Product Title and Price in cart    Sauce Labs Bike Light    $9.99
    Verify Product Title and Price in cart    Sauce Labs Bolt T-Shirt    $15.99
    Verify Product Title and Price in cart    Sauce Labs Fleece Jacket    $49.99
    Verify Product Title and Price in cart    Sauce Labs Onesie    $7.99
    Verify Product Title and Price in cart    Test.allTheThings() T-Shirt (Red)    $15.99
    Back to Shopping
    Remove Product from Shopping Cart    Sauce Labs Backpack
    Verify Product Count in Cart    5
    Add Product to Shopping Cart    Sauce Labs Backpack
    Remove all products from shopping cart
    Verify Product Count is 0
    Add all products to shopping cart
    Navigate to Shopping Cart
    Remove Product from Shopping Cart in cart page    Sauce Labs Fleece Jacket
    Verify Product Count in Cart    5
    Proceed to Checkout
    Verify Section Title    Checkout: Your Information
    Enter Personal Info and continue    Sandeep    Yadav    3024
    Verify Section Title    Checkout: Overview
    Verify Payment Information    SauceCard #31337
    Verify Shipping Information    Free Pony Express Delivery!
    Verify Item Total, Tax & Total Price    $79.95    $6.40    $86.35
    Finish Checkout
    Verify Section Title    Checkout: Complete!
    Verify order completion
    Back to Home

Verify Product Sorting
    [Tags]    regression
    Open Browser and Navigate To Page
    Login with valid Credentials    ${username}    ${password}
    Select sorting order    Name (A to Z)
    Verify product title sorting order A to Z
    Select sorting order    Name (Z to A)
    Verify product title sorting order Z to A
    Select sorting order    Price (low to high)
    Verify price sorting order low to high
    Select sorting order    Price (high to low)
    Verify price sorting order high to low




    





