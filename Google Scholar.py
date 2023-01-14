import selenium as s
from selenium import webdriver as w
from selenium.webdriver import Keys, ActionChains
from selenium.webdriver.common.by import By
from time import sleep
import re

def search():
    From = 2011
    to= 2020

    driver = w.Chrome('./chromedriver')

    driver.get("https://scholar.google.com/schhp?hl=en&as_sdt=0,5")
    Search = driver.find_element(By.NAME, "q")
    
    Search.send_keys("wind turbine mpc")
    Search.send_keys(Keys.RETURN)
    while True:
        try:
            Click = driver.find_element(By.ID, "gs_res_sb_yyc")
        except:
            sleep(1)
            continue
        break
    Click.click()
    for i in range(to-From):
        Form = driver.find_element(By.ID, "gs_res_sb_yyf")
        
        b1 = Form.find_element(By.NAME, "as_ylo")
        b2 = Form.find_element(By.NAME, "as_yhi")
        b1.clear()
        b2.clear()
        b1.send_keys(str(From))
        b2.send_keys(str(From))
        Searchbutton = Form.find_element(By.CLASS_NAME, "gs_wr")
        Searchbutton.click()
        Find = driver.find_element(By.ID, "gs_ab_md")
        Results = Find.find_element(By.CLASS_NAME, "gs_ab_mdw").text
        print("In",From, "there are", int(re.search(r'[\d .]+', Results).group().replace(".", "")))
        From += 1
        
        
    driver.quit()

    return Results
    
def toptenresults():
    pass

print(search())

