
import requests
from requests.structures import CaseInsensitiveDict

# Read categories from file and store in a list
file_path = r'C:\Users\migue\Desktop\P2G11\categories.txt'
with open(file_path, 'r') as file:
    categories_list = [category.strip() for category in file.readlines()]

menu = ("\n-=-=-=-=-=-=-=-=-=-=-=-=-\nWelcome to Project P2G11:\nPress Enter to Start\nType 'e' to Exit")

def create_category_dict_from_file(file_path, categories_list):
    category_dict = {}
    for item in categories_list:
        parts = item.split('.')
        current_dict = category_dict
        for part in parts:
            current_dict = current_dict.setdefault(part, {})     
    return category_dict

def PrintInvalidCategory():
    print("\n_________________________")
    print("Select a valid category")
    print("_________________________\n")

def GetCategory(category_dict):
    keys = category_dict.keys()
    dic_1 = {}
    count1 = 0
    count1_l = []
    count2 = 0
    count2_l = []
    list_subcategory = []
    for key in keys:
        count1 += 1
        count1_l.append(count1)
        print(count1, ": ", key, sep="")
        dic_1[count1] = key
    while True:
        print("_________________")
        category_input = input("Select a category\n")
        if category_input.isdigit():
            category_input = int(category_input)
            if category_input <= count1:
                break
            else:
                PrintInvalidCategory()
                continue
        else:
            PrintInvalidCategory()
            continue
    key = dic_1[int(category_input)]
    for values in category_dict[key]:
        list_subcategory.append(values)
        count2 += 1
        print(category_input, ".", count2, ": ", key, ".", values, sep="")
    while True:
        print("_________________")
        category_input2 = input("Select a category\n")
        if category_input2.isdigit():
            category_input2 = int(category_input2)
            if category_input2<= count2:
                break
            else:
                PrintInvalidCategory()
                continue    
        else:
            PrintInvalidCategory()
            continue
    key2 = list_subcategory[int(category_input2)-1]
    category_final_input = key+'.'+key2
    return category_final_input
        
def OpenMenu():
    while True: 
        print(menu)
        i = input('\n').lower()
        if i == '':
            return True
            break
        elif i == 'e':
            return False
            break
        else:
            print("Try a valid caractér")
            continue
            
def SearchMethod():
    print("\n________________________")
    print("Choose the search method:")
    print("1: Circle")
    print("2: Rectangle")
    print("3: Proximity\n")
    while True:
        g = str(input())    
        if g == '1':
            print("\nYou chose Circle")
            break
        elif g == '2':
            print("\nYou chose Rectangle")
            break
        elif g == '3':
            print("\nYou chose Proximity")
            break
        else:
            print("\nChose a valid option")
            continue
    return g
    
def PrintProperties(name, country, city, adress, houseNumber, distance, LocalLat, LocalLon):
    distance = int(distance)/1000
    print(f"\nName: {name}")
    print(f"Location: {country}, {city}, {adress} {houseNumber}")
    print(f"Coordinates: {LocalLat}, {LocalLon}")
    print(f"Distance: {distance} km")
    print("------------------------")    
    
def main():

    if OpenMenu():
        category_dict2 = create_category_dict_from_file(file_path, categories_list)
        categories_input = GetCategory(category_dict2)
        while True:
            print("\nDo you want to add any more categories?")
            a = input("Type 'yes' or 'no'\n")
            if a == 'yes':
                categories_input = categories_input +','+ GetCategory(category_dict2)
                continue
            elif a == 'no':
                break
            else:
                continue
        
        search = SearchMethod()
        
        if search == '1':
            coordinates = input("Please enter the coordinates(separated by a coma): ")
            radius = input("Enter the radius in km: ")
            radius = int(radius) * 1000
        elif search == '2':
            coordinates = input("Please enter the 4 coordinates you would like to use for the search(separated by a coma, in this order lon1,lat1,lon2,lat2):")
        else:
            coordinates = input("Please enter the coordinates(separated by a coma): ")
        limit = int(input("How many different places you want to know? "))
        
        if search == '1':
            url = f"https://api.geoapify.com/v2/places?categories={categories_input}&filter=circle:{coordinates},{radius}&limit={limit}&apiKey=dac9753ea77b449480d7c75540c7874a"
        elif search == '2':
            url = f"https://api.geoapify.com/v2/places?categories={categories_input}&filter=rect:{coordinates}&limit={limit}&apiKey=dac9753ea77b449480d7c75540c7874a"
        else:
            url = f"https://api.geoapify.com/v2/places?categories={categories_input}&bias=proximity:{coordinates}&apiKey=dac9753ea77b449480d7c75540c7874a"
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
                    name = location['properties'].get('name', 'N/A')
                    country = location['properties'].get('country', 'N/A')
                    city = location['properties'].get('city', 'N/A')
                    adress = location['properties'].get('street')
                    houseNumber = str(location['properties'].get('housenumber'))
                    if houseNumber == 'None':
                        houseNumber = ' '
                    LocalLat = location["properties"].get("lat")
                    LocalLon = location["properties"].get("lon")
                    distance = location["properties"].get("distance")
                    
                    # Output information
                    PrintProperties(name, country, city, adress, houseNumber, distance, LocalLat, LocalLon)
                    
                if len(locations)== 0:
                    print("There are no locations that fit your criteria, try again")
                    main()
            else:
                print("No 'features' found in the response.")
        else:
            print(f"Error: {resp.status_code}. Failed to fetch data.")
    else:
        quit()
        
# Call the main function
if __name__ == "__main__":
    main()
