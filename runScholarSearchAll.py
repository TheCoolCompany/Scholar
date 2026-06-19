from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from time import sleep
import re
import os

# Each entry: (search string, From, to)
SEARCHES = [
    ("\"wind farm\" AND \"wake redirection control\" AND \"field test\"",       2010, 2026),
    ("\"wind farm control\" AND (\"wake redirection control\" OR WRC)",         2010, 2026),
    ("\"wind farm\" \"axial induction control\"",                               2010, 2026),
    ("\"wind farm control\" Koopman",                                           2010, 2026),
    ("\"wind turbine\" AND (\"load reduction\" AND (\"individual pitch control\" OR IPC))", 1995, 2026),
    ("\"wind turbine control\" AND \"load reduction\"",                         1995, 2026),
    ("\"wind turbine control\" (\"individual pitch control\" OR IPC)",          1995, 2026),
    ("\"wind turbine control\" \"individual pitch control\"",                   1995, 2026),
    ("\"wind turbine control\" AND ((\"model predictive control\" OR MPC))",    1995, 2026),
    ("\"wind turbine control\" AND \"model predictive control\"",               1995, 2026),
    ("\"wind turbine control\" AND lidar",                                      1995, 2026),
    ("\"wind turbine control\" AND ((\"quasi-linear parameter varying model predictive control\" OR qLMPC))", 1995, 2026),
    ("\"wind turbine control\" AND (\"quasi-linear parameter varying model predictive control\" OR qLMPC)",  1995, 2026),
]


def build_filename(myStr, From, to):
    clean = re.sub(r'[\"()\[\]]', '', myStr)
    clean = re.sub(r'\b(AND|OR)\b', '', clean)
    clean = re.sub(r'[^\w\s]', '', clean)
    terms = [t.strip() for t in clean.split() if t.strip()]
    terms_str = '_'.join(t.capitalize() for t in terms)
    filename = f"GglSch_{From}_{to}_{terms_str}.txt"
    folder = "output"
    os.makedirs(folder, exist_ok=True)  # creates the folder if it doesn't exist
    filename = os.path.join(folder, f"GglSch_{From}_{to}_{terms_str}.txt")
    return filename


def search_one(driver, myStr, From, to):
    filename = build_filename(myStr, From, to)

    print(f"\n***\n{myStr}\n***")
    print(f"Writing results to: {filename}")

    # Go to Google Scholar and enter search
    driver.get("https://scholar.google.com/schhp?hl=en&as_sdt=0,5")
    Search = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.NAME, "q"))
    )
    Search.clear()
    Search.send_keys(myStr)
    Search.send_keys(Keys.RETURN)

    sleep(3)

    # Click date filter button
    WebDriverWait(driver, 600).until(
        EC.presence_of_element_located((By.ID, "gs_res_sb_yyc"))
    ).click()

    with open(filename, 'w', encoding='utf-8') as f:
        f.write(f"***\n{myStr}\n***\n\n")

        for year in range(From, to):
            try:
                Form = WebDriverWait(driver, 10).until(
                    EC.presence_of_element_located((By.ID, "gs_res_sb_yyf"))
                )
                b1 = Form.find_element(By.NAME, "as_ylo")
                b2 = Form.find_element(By.NAME, "as_yhi")
                b1.clear()
                b2.clear()
                b1.send_keys(str(year))
                b2.send_keys(str(year))

                Searchbutton = Form.find_element(By.CLASS_NAME, "gs_wr")
                Searchbutton.click()

                WebDriverWait(driver, 10).until(
                    EC.presence_of_element_located((By.ID, "gs_ab_md"))
                )
                sleep(1)

                results_block = driver.find_element(By.ID, "gs_ab_md").text
                match = re.search(r'(?:About )?([\d,]+) results', results_block)
                if match:
                    count = int(match.group(1).replace(",", ""))
                    line = f"In {year}, there are {count} results."
                else:
                    line = f"In {year}, there are 0 results (text was: '{results_block}')"

            except Exception as e:
                line = f"In {year}, there are 0 results (error: {e})"

            print(line)
            f.write(line + '\n')


def search_all():
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
    try:
        for myStr, From, to in SEARCHES:
            search_one(driver, myStr, From, to)
            sleep(5)  # Pause between searches to avoid triggering CAPTCHA
    finally:
        driver.quit()


search_all()