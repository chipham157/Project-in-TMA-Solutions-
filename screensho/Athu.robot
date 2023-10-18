*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}          Chrome
${LOGIN_URL}        https://demo.guru99.com/
${Input_email}      anhthu123@gmail.com

*** Test Cases ***
TC_01 Register successfully
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5  
    Input Text   //input[@name="emailid"]   ${Input_email}
    Click Button    //input[@name="btnLogin"]
    Element Should Be Visible    //table[@align="center"]//tbody
    Capture Page Screenshot
    Close Browser
TC_02 Login successfully 
    Open Browser    https://www.demo.guru99.com/V4/    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5 
    Input Text  //input[@name="uid"]   mngr519471
    Input Text  //input[@name="password"]  Anhthu294@
    Click Button    //input[@name="btnLogin"]
    Element Should Be Visible    //td[@style="color: green"]
    Capture Page Screenshot
    Close Browser
