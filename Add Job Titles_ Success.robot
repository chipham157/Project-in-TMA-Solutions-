*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}    Admin 
${VALID_PASSWORD}    admin123 
${PAGE_ADMIN}     (//a[@class="oxd-main-menu-item"])[1]
${JOB}            (//span[@class="oxd-topbar-body-nav-tab-item"])[2]
${JOB_TITLES}    //li/a[text()="Job Titles"] 
${ADD_JOBTITLES_BUTTON}   //div[@class="orangehrm-header-container"]//button  
${Xpath_Job Title}   //div[@class="oxd-form-row"]//input[@class="oxd-input oxd-input--active"]
${Xpath_Job Description}   //textarea[@placeholder="Type description here"]
${Xpath_Job Specification}  //input[@type="file"] 
${Xpath_Note}  //textarea[@placeholder="Add note"]
${Save}  //button[@type="submit"] 

*** Keywords ***
Login to OrangeHRM website
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]   

*** Test Cases ***
TC_24 add successful job title when entering all fields
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${ADD_JOBTITLES_BUTTON} 
    Input Text       ${Xpath_Job Title}  Financial Staff
    Input Text    ${Xpath_Job Description}  Financial planning, budget forecasting
    Choose File   ${Xpath_Job Specification}    D:\\Chi_Robot\\Add_jobtitles.xlsx
    Input Text    ${Xpath_Note}    Not available
    Click Button    ${Save} 
    # Sleep  2s
    # Element Should Be Visible   //div[@class="oxd-toast-container oxd-toast-container--bottom"]
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
            IF  '${value}' == 'Financial Staff'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    Job title added to success table
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Job title is not added to the table
        
    END
    # Xác minh Job Titles vừa tạo sẽ xuất hiện trên table 
    Close Browser
TC_25 Check field Job Titles 
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${ADD_JOBTITLES_BUTTON} 
    Input Text       ${Xpath_Job Title}  Business man
    Click Button    ${Save} 
    Sleep  2s
    Element Should Be Visible   //div[@class="oxd-toast-container oxd-toast-container--bottom"]
    # Xác minh cái pop up thành công xuất hiện
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
            IF  '${value}' == 'Business man'               
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Log    Job title added to success table
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Fail   Job title is not added to the table
        
    END
    # Xác minh Job Titles vừa tạo sẽ xuất hiện trên table 
    Close Browser

TC_29 Check all fields and press cancel button
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${ADD_JOBTITLES_BUTTON} 
    Input Text       ${Xpath_Job Title}  Financial Staff
    Input Text    ${Xpath_Job Description}  Financial planning, budget forecasting
    Choose File   ${Xpath_Job Specification}    D:\\Chi_Robot\\Add_jobtitles.xlsx
    Input Text    ${Xpath_Note}    Not available
    Click Button    //button[text()=" Cancel "]
    Sleep  2s
    Element Should Be Visible  //div[@class="orangehrm-paper-container"]
    Close Browser

TC_30 Enter nothing and press the cancel button
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${ADD_JOBTITLES_BUTTON} 
    Click Button    //button[text()=" Cancel "] 
    Sleep  2s
    Element Should Be Visible   //div[@class="orangehrm-paper-container"]
    Close Browser


