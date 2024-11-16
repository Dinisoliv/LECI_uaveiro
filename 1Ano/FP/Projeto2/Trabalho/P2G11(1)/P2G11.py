import requests
from requests.structures import CaseInsensitiveDict

# Read categories from file and store in a list
with open(categories.txt, 'r') as fileobj:
    categories_list = [category.strip() for category in file.readlines()]

url = "https://api.geoapify.com/v2/places?categories=commercial.supermarket&filter=rect%3A10.716463143326969%2C48.755151258420966%2C10.835314015356737%2C48.680903341613316&limit=20&apiKey=dac9753ea77b449480d7c75540c7874a"


def PrintResults():
    headers = CaseInsensitiveDict()
    headers["Accept"] = "application/json"
    resp = requests.get(url, headers=headers)

    if resp.status_code == 200:
        data = resp.json()

        # Check if 'features' key exists in the response
        if 'features' in data:
            locations = data['features']

            # Access the information for each location
            for location in locations:
                name = location['properties']['name']
                country = location['properties'].get('country', 'N/A')
                state = location['properties'].get('state', 'N/A')
                adress = location['properties'].get('adress_line1')
                
                
                # Output information
                print(f"Name: {name}")
                print(f"Country: {country}")
                print(f"State: {state}")
                print(f"Adress: {adress}")
                print("------------------------")
        else:
            print("No 'features' found in the response.")
    else:
        print(f"Error: {response.status_code}. Failed to fetch data.")

def main():
    coord = input("Enter the coordinates (separated by a coma): ")
    radius = input("Enter the radius in meters: ")
    categories_input = input("Enter the categories: ")
    while categories_input not in categories_list:
        categories_input = input("Invalid category! Enter a valid category: ")
    limit = int(input("How many different places you want to know? "))
    
    params = {
        "categories": categories_input,
        "filter": f"aroundCoord:{coord},radius:{radius}",
        "limit": limit,
        "apiKey": "dac9753ea77b449480d7c75540c7874a"
    }


# Call the main function
if __name__ == "__main__":
    main()
