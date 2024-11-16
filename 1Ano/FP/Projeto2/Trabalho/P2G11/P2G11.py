import requests
from requests.structures import CaseInsensitiveDict

# Read categories from file and store in a list
file_path = r'C:\Users\dinis\Desktop\P2G11\categories.txt'
with open(file_path, 'r') as file:
    categories_list = [category.strip() for category in file.readlines()]



def main():
    lon = input("Longitude: ")
    lat = input("Latitude: ")
    radius = input("Enter the radius in meters: ")
    categories_input = input("Enter the categories: ")
    while categories_input not in categories_list:
        categories_input = input("Invalid category! Enter a valid category: ")
    limit = int(input("How many different places you want to know? "))
    
    url = f"https://api.geoapify.com/v2/places?categories={categories_input}&filter=circle:{lon},{lat},{radius}&limit={limit}&apiKey=dac9753ea77b449480d7c75540c7874a"
    
    print(url)
    headers = CaseInsensitiveDict()
    headers["Accept"] = "application/json"

    resp = requests.get(url, headers=headers)
    print(resp.status_code)
    if resp.status_code == 200:
        data = resp.json()
        # Check if 'features' key exists in the response
        if 'features' in data:
            locations = data['features']

            # Access the information for each location
            for location in locations:
                name = location['properties'].get('name', 'N/A')
                country = location['properties'].get('country', 'N/A')
                state = location['properties'].get('state', 'N/A')
                adress = location['properties'].get('street')
                houseNumber = location['properties'].get('housenumber')
                LocalLat = location["properties"].get("lat")
                LocalLon = location["properties"].get("lon")
                distance = location["properties"].get("distance")
                
                # Output information
                print(f"Name: {name}")
                print(f"Location: {country}, {state}, {adress} {houseNumber}")
                print(f"Coordinates: {LocalLat}, {LocalLon}")
                print(f"Distance: {distance}")
                print("------------------------")
        else:
            print("No 'features' found in the response.")
    else:
        print(f"Error: {response.status_code}. Failed to fetch data.")

# Call the main function
if __name__ == "__main__":
    main()
