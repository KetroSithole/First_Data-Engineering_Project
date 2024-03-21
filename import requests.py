import praw
import requests
from bs4 import BeautifulSoup

# Make a request to the website
r = requests.get('https://www.reddit.com')

reddit = praw.Reddit(
    client_id="my_client_id",     # your client id
    client_secret="my_client_secret",  # your client secret
    user_agent="my_user_agent",   # user agent name
    username="my_username",     # your reddit username
    password="my_password"      # your reddit password
)

# Get the top 5 hot posts from the Machine Learning subreddit
hot_posts = reddit.subreddit('MachineLearning').hot(limit=5)
for post in hot_posts:
    print(post.title)
# Parse the HTML content
soup = BeautifulSoup(r.text, 'html.parser')

# Find all post titles
titles = soup.find_all('p')

# Print each title
for title in titles:
    print(title.text)
