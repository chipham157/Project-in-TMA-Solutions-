*** Settings ***
Documentation    Check the Add Users function in the User Management drop-down list
Library    SeleniumLibrary
Library    BuiltIn
Library    Collections
*** Variables ***
${BROWSER}          Chrome
${LOGIN_URL}        https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}   Admin 
${VALID_PASSWORD}   admin123 
${PAGE_ADMIN}     (//a[@class="oxd-main-menu-item"])[1]
${ADDUSER_BUTTON}         //div[@class="orangehrm-header-container"]/button
${XPATH_USERROLE}         //label[text()="User Role"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${XPATH_STATUS}          //label[text()="Status"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${XPATH_EMPLOYEE}        //label[text()="Employee Name"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input[@placeholder="Type for hints..."]
${XPATH_USERNAME}        //label[text()="Username"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input[@class="oxd-input oxd-input--active"]
${XPATH_PASSWORD}        //label[text()="Password"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input[@type="password"]
${XPATH_CONFIRMPASSWORD}  //label[text()="Confirm Password"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input[@type="password"]
*** Keywords ***
Login to OrangeHRM website
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]   

*** Test Cases ***
TC_14 Check all fields with valid data in Add Users 
    Login to OrangeHRM website 
    Click Element    ${PAGE_ADMIN}  
    Click Button    ${ADDUSER_BUTTON}
    Click Element    ${XPATH_USERROLE}  
    Click Element     //div[@role='listbox']//*[contains(text(),'ESS')] 
    Click Element     ${XPATH_STATUS} 
    Click Element     //div[@role='listbox']//*[contains(text(),'Enabled')] 
    Input Text    ${XPATH_EMPLOYEE}    Peter Mac Anderson
    Sleep   3s 
    Click Element     //div[@role='listbox'] 
    Input Text    ${XPATH_USERNAME}    Alice
    Input Text    ${XPATH_PASSWORD}    Ptlc123
    Input Text    ${XPATH_CONFIRMPASSWORD}    Ptlc123
    Click Button    //button[text()=" Save "] 
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    Log To Console    ${row} 
    Log To Console    ${col} 
    FOR    ${counter1}    IN RANGE    2    ${row}    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][2]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' == 'Alice'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    User added to the table successfully
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Users are not added to the table
    END
    Close Browser 

TC_23 Check all fields and press cancel button
    Login to OrangeHRM website   
    Click Element    ${PAGE_ADMIN}  
    Click Button    ${ADDUSER_BUTTON}
    Click Element    ${XPATH_USERROLE}  
    Click Element     //div[@role='listbox']//*[contains(text(),'ESS')] 
    Click Element     ${XPATH_STATUS} 
    Click Element     //div[@role='listbox']//*[contains(text(),'Enabled')] 
    Input Text    ${XPATH_EMPLOYEE}    Alice Duval
    Sleep   3s 
    Click Element     //div[@role='listbox'] 
    Input Text    ${XPATH_USERNAME}    Alice
    Input Text    ${XPATH_PASSWORD}    Ptlc123
    Input Text    ${XPATH_CONFIRMPASSWORD}    Ptlc123
    Click Button    //button[text()=" Cancel "]
    Sleep   2s
    Element Should Be Visible    //div[@class="orangehrm-paper-container"]
    Close Browser 
    