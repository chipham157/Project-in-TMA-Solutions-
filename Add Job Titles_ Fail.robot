*** Settings ***
Library    SeleniumLibrary
Resource    screensho/AddJobTitles.robot
Suite Setup    Open website OrangeHRM 
Suite Teardown    Close Browser
Test Template    AddJobTitles_operation


*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login

*** Test Cases ***   ${Input_Job Titles}  ${Input_Job Description}  ${Input_Job Specification}  ${Input_Note}     
TC_26 Check with Job Title field blank and fill in all remaining fields    ${EMPTY}    Financial planning, budget forecasting    D:\\Chi_Robot\\Add_jobtitles.xlsx    Not available
TC_28 Check the Job Specification field upload an invalid file    Developer    write code, create programs, software    D:\\Chi_Robot\\a.pptx    Not available
***Keyword***
AddJobTitles_operation
    [Arguments]    ${Input_Job Titles}  ${Input_Job Description}  ${Input_Job Specification}  ${Input_Note}
    Enter_input    ${Input_Job Titles}  ${Input_Job Description}  ${Input_Job Specification}  ${Input_Note}
    Load_message
    Message
    Clear_Text_All_Field