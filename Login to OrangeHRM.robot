*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}       Chrome
${LOGIN_URL}     https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}    Admin 
${VALID_PASSWORD}    admin123 


*** Test Cases ***
Valid Login Test
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Wait Until Element Is Visible   //input[@name="username"]
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Wait Until Element Is Visible   //input[@name="password"] 
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"] 
    # Close Browser

Fill in all the fields in the Add User table with valid information
    Open Browser    ${LOGIN_URL}    ${BROWSER} 
    Wait Until Element Is Visible   //input[@name="username"]
    Input Text       //input[@name="username"]      ${VALID_USERNAME}
    Wait Until Element Is Visible   //input[@name="password"] 
    Input Text      //input[@name="password"]      ${VALID_PASSWORD}
    Click Button    //button[@type="submit"] 
    Wait Until Element Is Visible  //h6[text()="Dashboard"]   
    Click Element    (//a[@class="oxd-main-menu-item"])[1] 
    Wait Until Element Is Visible   //div[@class="oxd-topbar-header-title"]
    Click Button    //div[@class="orangehrm-header-container"]/button
    




*** Keywords ***
Wait For Page To Load And Find Elements
    [Arguments]  @{xpaths}
    Wait Until Page Contains Element  xpath=/html/body   # Đợi trang web load xong (ở đây sử dụng xpath /html/body là một ví dụ)
    FOR  ${xpath}  IN  @{xpaths}
        # Thực hiện các thao tác trên phần tử xpath
        # Ví dụ:
        Click Element  ${xpath}
        # Hoặc thực hiện bất kỳ thao tác nào bạn cần
    END

*** Test Cases ***
Example Test
    Open Browser  https://example.com  chrome
    # Đưa vào danh sách các xpath bạn muốn tìm sau khi trang web load xong
    ${xpaths} =  Create List  xpath=//button[@id='submit']  xpath=//input[@name='username']
    Wait For Page To Load And Find Elements  ${xpaths}
    # Tiếp tục với các bước khác sau khi tìm được các phần tử xpath







