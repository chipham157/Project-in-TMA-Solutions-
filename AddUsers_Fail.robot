*** Settings ***
Library    SeleniumLibrary
Resource    screensho/Addusers.robot
Suite Setup    Open website OrangeHRM 
Suite Teardown    Close Browser
Test Template    Login_operation

*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login

*** Test Cases ***    ${INPUT_USERROLE}  ${INPUT_EMPLOYEENAME}  ${INPUT_STATUS}  ${INPUT_USERNAME}  ${INPUT_PASSWORD}  ${INPUT_CONFIRMPASSWORD}
TC_16 Field Employee Name is false, all other fields are correct    ESS  Alex   Enabled  Alice  Ptlc123  Ptlc123
TC_17 Field Username is false, all other fields are correct    ESS  Alice Duval   Enabled  Alic  Ptlc123  Ptlc123
TC_18 Field User Role is false, all other fields are correct    ${empty}  Alice Duval   Enabled  Alice  Ptlc123  Ptlc123
TC_19 Field Status is false, all other fields are correct    ESS  Alice Duval   ${empty}  Alice  Ptlc123  Ptlc123
TC_20 Numeric only password    ESS  Alice Duval   Enabled  Alice  1234567    1234567 
TC_21 Password less than 7 characters    ESS  Alice Duval   Enabled  Alice  a12345    a12345
TC_22 Confirm Password does not match the password  ESS  Alice Duval   Enabled  Alice  Ptlc123  Ptlc124


***Keyword***
Login_operation
    [Arguments]    ${INPUT_USERROLE}  ${INPUT_EMPLOYEENAME}  ${INPUT_STATUS}  ${INPUT_USERNAME}  ${INPUT_PASSWORD}  ${INPUT_CONFIRMPASSWORD}
    Enter_input    ${INPUT_USERROLE}  ${INPUT_EMPLOYEENAME}  ${INPUT_STATUS}  ${INPUT_USERNAME}  ${INPUT_PASSWORD}  ${INPUT_CONFIRMPASSWORD}
    Load_message
    Message
    Clear_Text_All_Field