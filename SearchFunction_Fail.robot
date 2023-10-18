*** Settings ***
Library    SeleniumLibrary
Resource    screensho/Search.robot
Suite Setup    Open website OrangeHRM 
Suite Teardown    Close Browser
Test Template    SearchFunction_operation
*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
*** Test Cases ***    ${Input_Username}  ${Input_User Role}  ${Input_Employee Name}  ${Input_Status}
TC_02 Check all the fields, in which the Username field is incorrect     aaaaaaa  Admin   Peter Mac Anderson  Enabled
TC_03 Check all the fields, in which the User Role field is incorrect   Anthony.Nolan   Admin   Anthony Nolan   Enabled
TC_04 Check all the fields, in which the Employee Name field is incorrect  Anthony.Nolan   ESS   abcd     Enabled
TC_05 Check all the fields, in which the Status field is incorrect     Anthony.Nolan   ESS   Anthony Nolan   Disabled
TC_10 Check with invalid Username field data the remaining fields are blank   Nobita   ${EMPTY}  ${EMPTY}  ${EMPTY}
TC_11 Check with invalid Employee field data the remaining fields are blank  ${EMPTY}  ${EMPTY}    Alee   ${EMPTY}
*** Keywords ***
SearchFunction_operation
    [Arguments]    ${Input_Username}  ${Input_User Role}  ${Input_Employee Name}  ${Input_Status}
    Enter_input    ${Input_Username}  ${Input_User Role}  ${Input_Employee Name}  ${Input_Status}
    Load_message
    Clear_Text_All_Field
    