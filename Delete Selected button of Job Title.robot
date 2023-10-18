*** Settings ***
Library    SeleniumLibrary
Library    Collections
*** Variables ***
${BROWSER}          Chrome
${LOGIN_URL}        https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}   Admin 
${VALID_PASSWORD}   admin123 
${PAGE_ADMIN}     (//a[@class="oxd-main-menu-item"])[1]
${JOB}            (//span[@class="oxd-topbar-body-nav-tab-item"])[2]
${JOB_TITLES}    //li/a[text()="Job Titles"] 
${CHECKBOX}     //div[text()="Job Titles"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//span[@class="oxd-checkbox-input oxd-checkbox-input--active --label-right oxd-checkbox-input"]
${DELETEBUTTON}   //button[text()=" Delete Selected "]
${POPUP}     //div[@role="document"]
${YESDELETE_BUTTON}   //button[text()=" Yes, Delete "] 
${NOCANCEL_BUTTON}   //button[text()=" No, Cancel "] 
${CHECKBOX}         //div[text()="Account Assistant"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//div[contains(@class,"oxd-table-card-cell-checkbox")]
*** Keywords ***
Login to OrangeHRM website
    Open Browser    ${LOGIN_URL}    ${BROWSER} 
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]   


*** Test Cases ***
TC_33 Check the "Delete Selected" button appears in the Job Titles panel
    Login to OrangeHRM website 
    Click Element    ${PAGE_ADMIN} 
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${CHECKBOX}
    Element Should Be Visible    ${DELETEBUTTON} 
    Close Browser

TC_34 Check pop-up "Are you sure?" appears when clicking the "Delete Selected" button
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN} 
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${CHECKBOX}
    Click Element     ${DELETEBUTTON} 
    Element Should Be Visible     ${POPUP}
    Close Browser 
TC_36 Check "Delete Selected" button when deleting all Job Titles and presses "No, Cancel" button
    Login to OrangeHRM website  
    Click Element    ${PAGE_ADMIN} 
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${CHECKBOX}
    Click Element     ${DELETEBUTTON} 
    Click Element   ${NOCANCEL_BUTTON}
    Element Should Not Be Visible    //div[@role="document"]
    Close Browser
TC37 Check the "Delete Selected" button when deleting 5 Job Titles and press the "Yes, Delete" button
    Login to OrangeHRM website  
    Click Element    ${PAGE_ADMIN} 
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    ${List}  Create List    HR Associate   HR Manager    IT Manager    Network Administrator    Head of Support

    FOR    ${counter}    IN RANGE    0    5    1
        ${value}    Get From List    ${List}    ${counter} 
        ${element2}    Get WebElement    //div[text()="${value}"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//div[contains(@class,"oxd-table-card-cell-checkbox")] 
        Scroll Element Into View   ${element2} 
        Click Element    //div[text()="${value}"]//ancestor::div[@class="oxd-table-row oxd-table-row--with-border"]//div[contains(@class,"oxd-table-card-cell-checkbox")] 
    END
    Sleep  3s 
    Scroll Element Into View    //h6[@class="oxd-text oxd-text--h6 orangehrm-main-title"]
    Click Element     ${DELETEBUTTON} 
    Click Element    ${YESDELETE_BUTTON}
    Sleep  2s
    Element Should Be Visible   //div[@class="oxd-toast-container oxd-toast-container--bottom"]
    Sleep  3s
        ${Check}   Set Variable    0 
    Sleep   5s
    ${row}    Get Element Count     //div[@class="oxd-table-row oxd-table-row--with-border"] 
    Log To Console    ${row} 
    FOR    ${counter1}    IN RANGE    2    ${row}+1    1
            ${value}    Get Text        //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]//div[@role="cell"][2]
            ${element}  Get WebElement  //div[@class="orangehrm-container"]//div[@class="oxd-table-card"][${counter1}]
            Scroll Element Into View    ${element}
            IF  ('${value}' == 'HR Associate') or ('${value}' == 'HR Manager') or ('${value}' == 'IT Manager') or ('${value}' == 'Network Administrator') or ('${value}' == 'Head of Support') 
                Execute Javascript    arguments[0].setAttribute('style', 'background-color:yellow;')    ARGUMENTS    ${element}
                Capture Page Screenshot
                Fail
                ${Check}   Set Variable    1
                BREAK
            END
    END
    IF  ${Check} == 0
        Capture Page Screenshot
        Log    Pass
        
    END
    # Xác minh Job Titles vừa tạo sẽ xuất hiện trên table 
    Close Browser

TC_35 Check "Delete Selected" button when deleting all Job Titles and presses "Yes, Delete" button
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN} 
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${CHECKBOX}
    Click Element     ${DELETEBUTTON} 
    Click Element    ${YESDELETE_BUTTON}
    Sleep  2s 
    Element Should Be Visible    //div[@class="oxd-toast-container oxd-toast-container--bottom"]
    Element Should Be Visible    //span[text()="No Records Found"]
    # Xác minh rằng tất cả Job Titles đã được xoá 
    Close Browser

TC_37 Check the "Delete Selected" button when deleting 5 Job Titles and press the "Yes, Delete" button
    Login to OrangeHRM website
    Click Element    ${PAGE_ADMIN} 
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${CHECKBOX}
    Click Element     ${DELETEBUTTON} 
    Click Element    ${YESDELETE_BUTTON}
    Sleep  2s 
    Element Should Be Visible    //div[@class="oxd-toast-container oxd-toast-container--bottom"]
    Element Should Be Visible    //span[text()="No Records Found"]
    # Xác minh rằng tất cả Job Titles đã được xoá 
    Close Browser