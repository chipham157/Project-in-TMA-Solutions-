*** Settings ***
Documentation  Check the System Users search function of the User Management drop-down list
Library    SeleniumLibrary
Library    RPA.Desktop
*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}    Admin 
${VALID_PASSWORD}    admin123 
${PAGE_ADMIN}     (//a[@class="oxd-main-menu-item"])[1] 
${XPATH_USERNAME}        //label[text()="Username"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input
${XPATH_EMPLOYEENAME}   //label[text()="Employee Name"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input
${CLICK_EMPLOYEENAME}   //div[@role='listbox']
${XPATH_USERROLE}  //label[text()="User Role"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${USERROLE_ESS}    //div[@role='listbox']//*[contains(text(),'ESS')]
${USERROLE_ADMIN}  //div[@role='listbox']//*[contains(text(),'Admin')]
${XPATH_STATUS}    //label[text()="Status"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${STATUS_ENABLED}    //div[@role='listbox']//*[contains(text(),'Enabled')] 
${STATUS_DISABLED}   //div[@role='listbox']//*[contains(text(),'Disabled')] 
${SEARCH_BUTTON}    //button[text()=" Search "]
${RESET_BUTTON}    //button[text()=" Reset "]
*** Keywords ***
Login to OrangeHRM website
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]   

*** Test Cases ***
TC01_Check all fields with valid information and press search button in User Management dropdown list
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN} 
    Input Text    ${XPATH_USERNAME}     Cecil.Bonaparte
    Click Element    ${XPATH_USERROLE}
    Click Element    ${USERROLE_ESS}    
    Input Text    ${XPATH_EMPLOYEENAME}   Cecil Bonaparte    
    Sleep   7s 
    Click Element    ${CLICK_EMPLOYEENAME}  
    Click Element    ${XPATH_STATUS} 
    Click Element    ${STATUS_ENABLED}  
    Click Button    ${SEARCH_BUTTON} 
    ${get_text}    Get Text    //div[text()="Cecil.Bonaparte"]   
    Log To Console    ${get_text}
    IF    '${get_text}' == 'Cecil.Bonaparte'
        Scroll Element Into View    //div[text()="Cecil.Bonaparte"]   
        Capture Page Screenshot
    ELSE
        Fail    not equal
    END
    # Xác minh rằng trong table nó xuất hiện đúng tên mình tìm kiếm
    Close Browser 

TC_06 Check with a valid Username field
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN} 
    Input Text    ${XPATH_USERNAME}     Charlie.Carter
    Click Button    ${SEARCH_BUTTON} 
    ${get_text}    Get Text    //div[text()="Charlie.Carter"]   
    Log To Console    ${get_text}
    IF    '${get_text}' == 'Charlie.Carter'
        Capture Page Screenshot
    ELSE
        Fail    not equal
    END
    # Xác minh rằng trong table nó xuất hiện đúng tên mình tìm kiếm
    Close Browser 
TC_07 Check with a valid User Role field
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN} 
    Click Element    ${XPATH_USERROLE}
    Click Element    ${USERROLE_ADMIN}    
    Click Button    ${SEARCH_BUTTON} 
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    FOR    ${counter1}    IN RANGE    2    ${row}    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][3]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' != 'Admin'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Fail   In the table found a User Role that is not Admin
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Log    No User Roles other than Admin can be found in the table
    END
    # Xác minh rằng bảng chứa thông tin của nhân viên sẽ bao gồm tất cả nhân viên có User Role giống với User Role tìm kiếm
    Close Browser 
TC_08 Check with a valid Employee field
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN}     
    Input Text    ${XPATH_EMPLOYEENAME}   Alice Duval    
    Sleep   5s 
    Click Element    ${CLICK_EMPLOYEENAME}  
    Click Button    ${SEARCH_BUTTON} 
    ${get_text}    Get Text    //div[text()="Alice Duval"]   
    Log To Console    ${get_text}
    IF    '${get_text}' == 'Alice Duval'
        Capture Page Screenshot
    ELSE
        Fail    not equal
    END
    # Xác minh rằng trong table nó xuất hiện đúng Employee mình tìm kiếm
    Close Browser 
TC_09 Check with a valid Status field
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN}   
    Click Element    ${XPATH_STATUS} 
    Click Element    ${STATUS_ENABLED}  
    Click Button    ${SEARCH_BUTTON} 
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    FOR    ${counter1}    IN RANGE    2    ${row}    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][5]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' != 'Enabled'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Fail   Fail
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Log    Pass
    END
    Close Browser 
TC_13 Fill all valid fields and press Reset button 
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN} 
    Input Text    ${XPATH_USERNAME}     Alice.Duval 
    Click Element    ${XPATH_USERROLE}
    Click Element    ${USERROLE_ESS}    
    Input Text    ${XPATH_EMPLOYEENAME}   Alice Duval 
    Sleep   5s 
    Click Element    ${CLICK_EMPLOYEENAME}  
    Click Element    ${XPATH_STATUS} 
    Click Element    ${STATUS_DISABLED}  
    Click Button    ${RESET_BUTTON}
    Sleep  3s
    Element Text Should Be    ${XPATH_USERNAME}    ${EMPTY}  
    Sleep  5s 
    Element Should Be Visible    //label[text()="User Role"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[text()="-- Select --"]
    Element Text Should Be    ${XPATH_EMPLOYEENAME}    ${EMPTY}    
    Element Should Be Visible    //label[text()="Status"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[text()="-- Select --"]
    Capture Page Screenshot
    Close Browser 
    # Xác minh rằng các text sẽ đc clear và User kh đc tìm kiếm 
