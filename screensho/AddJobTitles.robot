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
${Xpath_Job Title}   //label[text()="Job Title"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input 
${Xpath_Job Description}   //textarea[@placeholder="Type description here"]
${Xpath_Job Specification}  //input[@type="file"] 
${Xpath_Note}  //textarea[@placeholder="Add note"]
${Save}  //button[@type="submit"] 

***Keyword***
Open website OrangeHRM 
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    7 
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"]
    Click Element    ${PAGE_ADMIN}  
    Click Element    ${JOB} 
    Click Element    ${JOB_TITLES} 
    Click Element    ${ADD_JOBTITLES_BUTTON} 
    Sleep   5s
Enter_input
    [Arguments]     ${Input_Job Titles}  ${Input_Job Description}  ${Input_Job Specification}  ${Input_Note}
    Input Text       ${Xpath_Job Title}  ${Input_Job Titles}     
    Input Text   ${Xpath_Job Description}  ${Input_Job Description}    
    Choose File   ${Xpath_Job Specification}  ${Input_Job Specification}   
    Input Text    ${Xpath_Note}  ${Input_Note}     
    Click Button    ${Save} 

Load_message
    Sleep    5 seconds
Message
    # Xác minh hợp lệ 
    # Element Should Be Visible   //div[@class="oxd-toast-container oxd-toast-container--bottom"]
     # Xác minh không hợp lệ 
    # Element Should Be Visible   //span[@class="oxd-text oxd-text--span oxd-input-field-error-message oxd-input-group__message"]
    Element Should Be Visible    //div[@class="orangehrm-card-container"]

Clear_Text
    [Arguments]    ${selector}
    Scroll Element Into View    //label[text()="Job Title"]//ancestor::div[@class="oxd-input-group oxd-input-field-bottom-space"]//input 
    Sleep   3s
    click element   ${selector}
    press keys    ${selector}    CTRL+a+BACKSPACE
    sleep    0.3
Clear_Text_All_Field
    Scroll Element Into View    ${Xpath_Job Title}
    Sleep   3s 
    Clear_Text    ${Xpath_Job Title}
    Clear_Text    ${Xpath_Job Description} 
    Clear_Text     ${Xpath_Note}
Capture_page_all_field_with_data
    Capture Page Screenshot