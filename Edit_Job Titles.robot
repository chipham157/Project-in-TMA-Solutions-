*** Settings ***
Library    SeleniumLibrary
Resource    setup_before.robot

*** Variables ***
${BROWSER}          Chrome
${LOGIN_URL}        https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}   Admin 
${VALID_PASSWORD}   admin123 
${PAGE_ADMIN}     (//a[@class="oxd-main-menu-item"])[1]
${JOB}            (//span[@class="oxd-topbar-body-nav-tab-item"])[2]
${JOB_TITLES}    //li/a[text()="Job Titles"] 
${PENCIL}       //div[text()="Financial Analyst"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//i[@class="oxd-icon bi-pencil-fill"]
${INPUT JOB TITLES}   //label[text()="Job Title"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input 
${Xpath_Job Title}   //div[@class="oxd-form-row"]//input
${Xpath_Job Description}   //textarea[@placeholder="Type description here"]
${Xpath_Job Specification}  //input[@type="file"] 
${Xpath_Note}  //textarea[@placeholder="Add note"]
${Save}  //button[@type="submit"] 
${Cancel}   //button[text()=" Cancel "]
*** Keywords ***
Login to OrangeHRM website
    Open Browser    ${LOGIN_URL}    ${BROWSER} 
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]   

*** Test Cases ***
TC_36 Check when Editing a Job Titles field
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    //div[text()="Chief Executive Officer"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//i[@class="oxd-icon bi-pencil-fill"]
    sleep   5s 
    Clear_Text   ${INPUT JOB TITLES} 
    Input Text       ${INPUT JOB TITLES}   Chief Executive 
    Click Button    ${Save}
    Sleep  2s
    Element Should Be Visible   //div[@class="oxd-toast-container oxd-toast-container--bottom"]
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    Log To Console    ${row} 
    Log To Console    ${col} 
    FOR    ${counter1}    IN RANGE    1    ${row}+1    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][2]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' == 'Chief Executive'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    Pass
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Fail
        
    END
    # Xác minh rằng Job Titles vừa edit đã edit thành công trên table
    Close Browser
TC_37 Check when Editing Job Title field then press cancel button
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"] 
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    //div[text()="QA Engineer"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//i[@class="oxd-icon bi-pencil-fill"]
    sleep   5s 
    Clear_Text   ${INPUT JOB TITLES} 
    Input Text       ${INPUT JOB TITLES}  Business man
    Click Button    ${Cancel} 
    Sleep  5s
    Element Should Be Visible   //div[@class="orangehrm-paper-container"]
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    Log To Console    ${row} 
    Log To Console    ${col} 
    FOR    ${counter1}    IN RANGE    1    ${row}+1    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][2]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' == 'QA Engineer'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    Pass
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Fail
        
    END
     Close Browser
TC_38 Check when editing all fields then press save button
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"] 
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    //div[text()="Content Specialist"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//i[@class="oxd-icon bi-pencil-fill"]
    sleep   5s 
    Clear_Text   ${INPUT JOB TITLES} 
    Input Text       ${Xpath_Job Title}   Software Testing 
    Input Text    ${Xpath_Job Description}  Write test case manual, automattion
    Choose File   ${Xpath_Job Specification}    D:\\Chi_Robot\\Add_jobtitles.xlsx
    Input Text    ${Xpath_Note}    Not available
    Click Button     //button[@type="submit"] 
    Sleep  2s
    Element Should Be Visible   //div[@class="oxd-toast-container oxd-toast-container--bottom"]
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    Log To Console    ${row} 
    Log To Console    ${col} 
    FOR    ${counter1}    IN RANGE    1    ${row}    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][2]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' == 'Software Testing'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    Pass
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Fail
        
    END
     Close Browser
TC_39 Check when editing all fields then press cancel button
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"] 
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    //div[text()="Finance Manager"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//i[@class="oxd-icon bi-pencil-fill"]
    sleep   5s 
    Clear_Text   ${INPUT JOB TITLES} 
    Input Text       ${Xpath_Job Title}  HR
    Input Text    ${Xpath_Job Description}  personnel recruitment
    Choose File   ${Xpath_Job Specification}    D:\\Chi_Robot\\Add_jobtitles.xlsx
    Input Text    ${Xpath_Note}    Not available
    Click Button    ${Cancel} 
    Sleep  2s
    Element Should Be Visible   //div[@class="orangehrm-paper-container"]
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    Log To Console    ${row} 
    Log To Console    ${col} 
    FOR    ${counter1}    IN RANGE    1    ${row}    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][2]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' == 'Finance Manager'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    Pass
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Fail
        
    END
    Close Browser
TC_40 Check when click edit but don't edit any field then press save button
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"] 
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    //div[text()="Customer Success Manager"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//i[@class="oxd-icon bi-pencil-fill"]
    sleep   5s 
    Click Button    ${Save} 
    Sleep  2s
    Element Should Be Visible   //div[@class="oxd-toast-container oxd-toast-container--bottom"]
    ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    ${col}    Get Element Count   //div[@role="columnheader"]
    Log To Console    ${row} 
    Log To Console    ${col} 
    FOR    ${counter1}    IN RANGE    1    ${row}    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][2]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  '${value}' == 'Customer Success Manager'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    Pass
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Fail
        
    END
    Close Browser