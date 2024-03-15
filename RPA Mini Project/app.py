import streamlit as st
from collections import defaultdict
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
from datetime import datetime
import time, json, os
import subprocess

# Function to initialize the WebDriver
def initialize_driver():
    # Set the desired window size & other options
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--start-maximized")
    chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
    
    # Create a new Chrome window
    driver = webdriver.Chrome(options=chrome_options)
    return driver

# Function to navigate to a section
def navigate_to_section(driver, section_id):
    # Open the webpage
    driver.get("https://arxiv.org/")
    time.sleep(4)
    
    # Find the Computer Science section
    computer_science_heading = driver.find_element(By.XPATH, ".//h2[text()='Computer Science']")
    computer_science_list = computer_science_heading.find_element(By.XPATH, "./following-sibling::ul")
    section_tag = computer_science_list.find_element(By.ID, section_id)
    section_tag.click()
    time.sleep(4)

# Function to get the maximum number of entries
def get_max_entries(driver):
    try:
        max_entries_text = driver.find_element(By.XPATH, "//h3").text
        max_entries = int(max_entries_text.split()[-2])
        return max_entries
    except NoSuchElementException:
        print("Max entries not found.")
        return None

# Function to extract documents
def extract_documents(driver, max_entries, section_id):
    documents = {}
    current_page = 1

    # Click on the "Show All" button if it exists
    try:
        show_all_button = driver.find_element(By.XPATH, '//*[@id="dlpage"]/small[2]/a[3]')
        show_all_button.click()
        time.sleep(4)  # Adding a small delay to ensure all items are loaded
    except NoSuchElementException:
        print('not found')
        pass  # If "Show All" button is not found, continue with regular extraction
    
    # Find all elements matching the XPath expressions
    identifier_elements = driver.find_elements(By.XPATH, "//span[@class='list-identifier']/a[1]")
    title_elements = driver.find_elements(By.XPATH, "//div[@class='list-title mathjax']")
    authors_elements = driver.find_elements(By.XPATH, "//div[@class='list-authors']")
    subjects_elements = driver.find_elements(By.XPATH, "//div[@class='list-subjects']")
    pdflink_elements = driver.find_elements(By.XPATH, "//span[@class='list-identifier']/a[2]")
    
    # Extract the data from the elements
    identifiers = [element.text for element in identifier_elements]
    titles = [element.text for element in title_elements]
    authors = [element.text.replace("Authors:", "").strip().replace("\n", ", ") for element in authors_elements]
    subjects = [element.text.replace("Subjects:", "").strip().replace(";", ",") for element in subjects_elements]
    pdflinks = [element.get_attribute("href") for element in pdflink_elements]
    
    # Store the extracted data in a dictionary
    for identifier, title, author, subject, pdflink in zip(identifiers, titles, authors, subjects, pdflinks):
        documents[identifier] = {
            "Title": title,
            "Authors": author,
            "Subjects": subject,
            "Pdflink": pdflink
        }

        # Print the document details in the terminal
        print("Identifier:", identifier)
        print("Title:", title)
        print("Authors:", author)
        print("Subjects:", subject)
        print("PDF Link:", pdflink)
        print()
        
        # Decrement the counter for extracted entries
        max_entries -= 1
        if max_entries == 0:
            return documents
        
    return documents

# Get the current date and time
current_datetime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
# Generate the filename
filename = f"arxiv_data_{current_datetime}.json"

# Function to scrape ArXiv data
def scrape_arxiv_data():
    # Initialize the WebDriver
    driver = initialize_driver()

    # Data storage dictionary
    all_documents = {}

    # Sections to scrape
    sections = ["cs.AI", "cs.CV", "cs.LG"]

    for section_id in sections:
        # Navigate to the section
        navigate_to_section(driver, section_id)

        # Get the maximum number of entries
        max_entries = get_max_entries(driver)

        # Extract documents
        documents = extract_documents(driver, max_entries, section_id)

        # Update the all_documents dictionary
        all_documents.update(documents)

    # Close the WebDriver
    driver.quit()

    # Save the scraped data into a JSON file
    with open(filename, "w") as json_file:
        json.dump(all_documents, json_file)

    return all_documents

# Function to load ArXiv data from JSON file
def load_arxiv_data():
    if os.path.exists(filename):
        with open(filename, "r") as json_file:
            return json.load(json_file)
    else:
        return None

# Function to preprocess the query
def preprocess_query(query):
    # Remove stopwords and convert to lowercase
    stopwords = {"with", "and", "or", "the", "a", "an", "for", "in", "of", "on", "at", "to", "by"}
    query_words = query.lower().split()
    processed_query = [word for word in query_words if word not in stopwords]
    return processed_query

# Function to search documents based on query
def search_documents(query, documents):
    query_words = preprocess_query(query)
    document_scores = defaultdict(int)
    
    # Calculate document scores based on inverted index
    for word in query_words:
        for doc_id, doc_data in documents.items():
            if word in doc_data["Title"].lower():
                document_scores[doc_id] += 1
    
    # Sort the document scores by score (descending order)
    sorted_results = sorted(document_scores.items(), key=lambda x: x[1], reverse=True)

    # Filter out documents with zero score
    sorted_results = [(doc_id, score) for doc_id, score in sorted_results if score > 0]
    
    return sorted_results

def main():
    # Load ArXiv data from JSON file if available, otherwise scrape it
    all_documents = load_arxiv_data()
    if all_documents is None:
        all_documents = scrape_arxiv_data()

    st.title("ArXiv Paper Search")
    query = st.text_input("Enter your query:")

    if st.button("Search"):
        # Search documents based on query
        search_results = search_documents(query, all_documents)
    
        # Display search results
        if search_results:
            # Print only the top 3 search results
            for i in range(min(len(search_results), 3)):
                doc_id, score = search_results[i]
                st.subheader(f"Result {i + 1}")
                st.write(f"<b>Document ID:</b> {doc_id}", unsafe_allow_html=True)
                st.write(f"<b>Title:</b> {all_documents[doc_id]['Title']}", unsafe_allow_html=True)
                st.write(f"<b>Authors:</b> {all_documents[doc_id]['Authors']}", unsafe_allow_html=True)
                st.write(f"<b>Subjects:</b> {all_documents[doc_id]['Subjects']}", unsafe_allow_html=True)
                st.write(f"<b>PDF Link:</b> {all_documents[doc_id]['Pdflink']}", unsafe_allow_html=True)
                st.write("---")
        else:
            st.write("No search results found.")

if __name__ == "__main__":
    main()