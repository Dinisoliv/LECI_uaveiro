#import requests

#resp = requests.get("https://www.rfc-editor.org/rfc/rfc16.txt")
#print("resp.status_code:", resp.status_code)  # deve ser 200
#print("resp.text:\n", resp.text)
#print("resp.text:\n", resp.text[:300])


import requests

# Base URL for the API
base_url = "https://jsonplaceholder.typicode.com"

def get_posts():
    """Get all posts."""

    response = requests.get(f"{base_url}/posts")
    if response.status_code == 200:
        return response.json()


def get_posts_by_user(userId):
    """Gets all posts of the user userId."""

    # Create a dictionary with key:value pairs to pass in the URL query string
    params = {'userId': userId}
    response = requests.get(f"{base_url}/posts", params=params)
        # The params= argument is encoded in the URL query string.

    #print(response.request.url)  # Uncomment to see the constructed URL

    if response.status_code == 200:
        return response.json()  # decode JSON into a python object (list)


def add_post(title, body, user_id):
    """Add a new post."""

    # Create a dict with the data to send
    data = {
        "title": title,
        "body": body,
        "userId": user_id
    }

    response = requests.post(f"{base_url}/posts", json=data)
        # With json=... the request content is sent as JSON

    if response.status_code == 201:
        return response.json()


def main():
    # Uncomment to see all posts
    #print("\nTesting get_posts")
    #posts = get_posts()
    #print(posts, end="\n\n")

    print("\nTesting get_posts_by_user")
    some_posts = get_posts_by_user(1)
    print(some_posts)
    # Should return a list of dictionaries: 
    # [{'userId': 1, 'id': 1, 'title': 'sunt ...', 'body': 'quia ... '},
    #  {'userId': 1, 'id': 2, 'title': 'qui ...', 'body': 'est ...'}]

    print("\nTesting add_post")
    added = add_post("A title", "Some content\nMore interesting content", 5)
    print(repr(added))


if __name__ == "__main__":
    main()
