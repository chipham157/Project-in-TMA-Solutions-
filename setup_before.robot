*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${url}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${browser}    chrome 

*** Keywords ***
setup_before
    [Arguments]   ${username}    ${password}
    Open Browser    ${url}    ${BROWSER}
    Maximize Browser Window
    Sleep    5
    Wait Until Element Is Visible    xpath://div/input[@name="username"]
    Input Text    //div/input[@name="username"]   ${username}
    Wait Until Element Is Visible    xpath://input[@name="password"]
    Input Text    //input[@name="password"]   ${password}
    Click Button  //button[text() = " Login "]
    Wait Until Element Is Visible    xpath://span[text() ="Recruitment"]
    Click Element    //span[text() ="Recruitment"]
    Wait Until Element Is Visible    xpath: //button[text() = " Add "]
    Click Button    //button[text() = " Add "]   
    
input
    [Arguments]  ${FristName}    ${middleName}  ${lastName}    ${gmail}    ${number}
    Wait Until Element Is Visible   xpath://input[@placeholder = "First Name"]
    Sleep    5
    Input Text    //input[@placeholder = "First Name"]   ${FristName}
    Wait Until Element Is Visible    xpath://input[@placeholder = "Middle Name"]
    Input Text    //input[@placeholder = "Middle Name"]    ${middleName}
    Wait Until Element Is Visible    xpath://input[@placeholder = "Last Name"]
    Input Text    //input[@placeholder = "Last Name"]   ${lastName}
    Wait Until Element Is Visible    xpath://label[text()="Email"]//ancestor::div[@class = "oxd-grid-item oxd-grid-item--gutters"]//input
    Input Text    //label[text()="Email"]//ancestor::div[@class = "oxd-grid-item oxd-grid-item--gutters"]//input       ${gmail}
    Wait Until Element Is Visible    xpath://label[text()="Contact Number"]//ancestor::div[@class = "oxd-grid-item oxd-grid-item--gutters"]//input
    input Text    //label[text()="Contact Number"]//ancestor::div[@class = "oxd-grid-item oxd-grid-item--gutters"]//input    ${Number}
    Click Button    //button[text()=" Save "]
    
Verify_User_is_not_add_success_after_click_save_button
    # Element Should Be Disabled    //span[text()="Expected format: admin@example.com"]
    Page Should Not Contain Element    //h6[text()="Candidate Profile"]
    Capture Page Screenshot

Clear_Text
    [Arguments]    ${selector}
    click element   ${selector}
    press keys    ${selector}    CTRL+a+BACKSPACE
    sleep    0.3
Clear_Text_All_Field
    Scroll Element Into View    //input[@placeholder = "First Name"]
    Clear_Text    //input[@placeholder = "First Name"]
    Clear_Text    //input[@placeholder = "Middle Name"]
    Clear_Text   //input[@placeholder = "Last Name"]
    Clear_Text    //label[text()="Email"]//ancestor::div[@class = "oxd-grid-item oxd-grid-item--gutters"]//input
    Clear_Text    //label[text()="Contact Number"]//ancestor::div[@class = "oxd-grid-item oxd-grid-item--gutters"]//input
Capture_page_all_field_with_data
    Capture Page Screenshot