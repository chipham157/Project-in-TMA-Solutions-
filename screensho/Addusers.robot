*** Settings ***
Library    SeleniumLibrary 
*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}    Admin 
${VALID_PASSWORD}    admin123 
${PAGE_ADMIN}     (//a[@class="oxd-main-menu-item"])[1] 
${ADDUSER_BUTTON}         //div[@class="orangehrm-header-container"]/button
${XPATH_USERROLE}         //label[text()="User Role"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${XPATH_STATUS}          //label[text()="Status"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${XPATH_EMPLOYEE}        //label[text()="Employee Name"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input[@placeholder="Type for hints..."]
${XPATH_USERNAME}        //label[text()="Username"]//ancestor::div[@class='oxd-input-group oxd-input-field-bottom-space']//input

${XPATH_PASSWORD}        //label[text()="Password"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input[@type="password"]
${XPATH_CONFIRMPASSWORD}  //label[text()="Confirm Password"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input[@type="password"]
***Keyword***
Open website OrangeHRM 
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    7 
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]
    Click Element    ${PAGE_ADMIN}  
    Click Button    ${ADDUSER_BUTTON}
Enter_input
    [Arguments]  ${INPUT_USERROLE}  ${INPUT_EMPLOYEENAME}  ${INPUT_STATUS}  ${INPUT_USERNAME}  ${INPUT_PASSWORD}  ${INPUT_CONFIRMPASSWORD}
    Click Element    ${XPATH_USERROLE}  
    Click Element    //div[@role='listbox']//*[contains(text(),'${INPUT_USERROLE}')]
    Click Element     ${XPATH_STATUS} 
    Click Element     //div[@role='listbox']//*[contains(text(),'${INPUT_STATUS}')]
    Input Text    ${XPATH_EMPLOYEE}     ${INPUT_EMPLOYEENAME}
    Sleep  3s 
    Click Element     //div[@role='listbox']
    Sleep  3s
    Input Text    ${XPATH_USERNAME}    ${INPUT_USERNAME}
    Input Text    ${XPATH_PASSWORD}    ${INPUT_PASSWORD}
    Input Text    ${XPATH_CONFIRMPASSWORD}   ${INPUT_CONFIRMPASSWORD}
    Click Button    //button[text()=" Save "] 

Load_message
    Sleep    3 seconds
Message
    Element Should Be Visible    //h6[text()="Add User"]
Clear_Text
    [Arguments]    ${selector}
    click element   ${selector}
    press keys    ${selector}    CTRL+a+BACKSPACE
    sleep    0.3
Clear_Text_All_Field
    Scroll Element Into View    ${XPATH_USERROLE}  
    Clear_Text    ${XPATH_USERROLE}  
    Scroll Element Into View    ${XPATH_STATUS} 
    Clear_Text   ${XPATH_STATUS} 
    Scroll Element Into View    ${XPATH_EMPLOYEE} 
    Clear_Text    ${XPATH_EMPLOYEE}
    Scroll Element Into View    ${XPATH_USERNAME} 
    Clear_Text     ${XPATH_USERNAME} 
    Scroll Element Into View    ${XPATH_PASSWORD} 
    Clear_Text     ${XPATH_PASSWORD} 
    Scroll Element Into View    ${XPATH_CONFIRMPASSWORD} 
    Clear_Text    ${XPATH_CONFIRMPASSWORD}

Capture_page_all_field_with_data
    Capture Page Screenshot