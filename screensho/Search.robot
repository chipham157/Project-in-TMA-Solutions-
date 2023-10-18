*** Settings ***
Library    SeleniumLibrary 
*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}    Admin 
${VALID_PASSWORD}    admin123 
${PAGE_ADMIN}     (//a[@class="oxd-main-menu-item"])[1] 
${XPATH_USERNAME}        //label[text()="Username"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input
${XPATH_EMPLOYEENAME}   //label[text()="Employee Name"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input
${CLICK_EMPLOYEENAME}   //div[@role='listbox']
${XPATH_USERROLE}     //label[text()="User Role"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${XPATH_STATUS}           //label[text()="Status"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//div[@class="oxd-select-text-input"]
${SEARCH_BUTTON}     //button[text()=" Search "]
${INVALID}           //span[text()="Invalid"]

***Keyword***
Open website OrangeHRM 
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    7 
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]
    Click Element    ${PAGE_ADMIN}  
    Sleep   3s
Enter_input
    [Arguments]     ${Input_Username}  ${Input_User Role}  ${Input_Employee Name}  ${Input_Status}
    Input Text    ${XPATH_USERNAME}     ${Input_Username}
    Click Element    ${XPATH_USERROLE}
    Click Element    //div[@role='listbox']//*[contains(text(),'${Input_User Role}')]  
    Input Text    ${XPATH_EMPLOYEENAME}  ${Input_Employee Name}
    Sleep   4s      
    IF    "${Input_Employee Name}" == "${EMPTY}"
        Click Element    ${XPATH_STATUS} 
        Click Element     //div[@role='listbox']//*[contains(text(),'${Input_Status}')] 
        Click Button    ${SEARCH_BUTTON} 
    ELSE
        Click Element    ${CLICK_EMPLOYEENAME}  
        Click Element    ${XPATH_STATUS} 
        Click Element     //div[@role='listbox']//*[contains(text(),'${Input_Status}')] 
        Click Button    ${SEARCH_BUTTON}
    END
     

Load_message
    Sleep    2 seconds
Message
    # Element Should Be Visible   //div[@class='oxd-toast oxd-toast--info oxd-toast-container--toast']/div/div[2]/p[@class='oxd-text oxd-text--p oxd-text--toast-message oxd-toast-content-text']
    # Thông báo lỗi xuất hiện
    Element Should Be Visible  //span[text()="No Records Found"]
    Capture Page Screenshot
    # Trên table không hiển thị thông tin nhân viên
Clear_Text
    [Arguments]    ${selector}
    click element   ${selector}
    press keys    ${selector}    CTRL+a+BACKSPACE
    sleep    0.3
Clear_Text_All_Field
    # Scroll Element Into View    ${XPATH_USERNAME} 
    Clear_Text    ${XPATH_USERNAME} 
    Clear_Text    ${XPATH_USERROLE}
    Clear_Text   ${XPATH_EMPLOYEENAME}
    Clear_Text     ${XPATH_STATUS}
Capture_page_all_field_with_data
    Capture Page Screenshot