# SearchMoviesApiLWC
Movie Search LWC Component
This is a Lightning Web Component (LWC) that allows users to search for movies using the TMDB (The Movie Database) API. The component provides a user-friendly interface to enter search queries and displays the search results with relevant movie information.

Features
Search movies by entering keywords or movie titles.
Display search results with movie details including title, release date, overview, and poster image.
Click on a movie to view more detailed information.
Pagination support to navigate through multiple search result pages.
Error handling for API failures or invalid search queries.
Prerequisites
Before using this component, ensure that you have the following:

A valid TMDB API key: You need an API key from TMDB to interact with their API. If you don't have one, you can create a TMDB account and generate an API key from their developer portal.
Installation
To use the Movie Search LWC Component, follow these steps:

Clone or download the component code from the repository.
Open the Salesforce Developer Console or your preferred IDE.
Deploy the component by either:
Creating a new LWC component in your Salesforce org and copying the component files into the newly created component directory.
Overwriting the existing component files in your Salesforce org with the downloaded files.
Open the component in your Salesforce org's Lightning App Builder or Lightning Experience, and add it to a page or component.
Configuration
Before using the component, make sure to configure the following:

Set the TMDB API key: Open the movieSearch.js file in the component directory. Locate the API_KEY constant and replace the placeholder value with your TMDB API key.
javascript
Copy code
const API_KEY = 'YOUR_TMDB_API_KEY';
Customize the component (optional): You can modify the component's appearance or behavior by editing the HTML, CSS, or JavaScript files in the component directory.
Usage
Once the component is installed and configured, you can use it by adding it to a Lightning App Builder page or embedding it in your custom Lightning components. The component will display a search input field where users can enter their movie queries. As users type, the component will make API requests to TMDB and display the search results dynamically. Users can click on a movie to view more details.

Troubleshooting
If you encounter any issues while using the Movie Search LWC Component, consider the following troubleshooting steps:

Verify the TMDB API key: Double-check that the TMDB API key in the movieSearch.js file is correct and valid.
Check the console for errors: Use the browser's developer console to check for any JavaScript errors that may occur while using the component.
Ensure network connectivity: Confirm that your Salesforce org has internet connectivity to make API requests to TMDB.
If the issue persists, refer to the documentation or seek help from the Salesforce Trailblazer Community or relevant support channels.
