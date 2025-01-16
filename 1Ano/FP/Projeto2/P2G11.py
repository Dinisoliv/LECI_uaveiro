import requests
from requests.structures import CaseInsensitiveDict

# Read categories from file and store in a list
file_path = r'C:\Users\dinis\Desktop\FP\Projeto2\Final\P2G11\categories.txt'
with open(file_path, 'r') as file:
    categories_list = [category.strip() for category in file.readlines()]

menu = ("\n-=-=-=-=-=-=-=-=-=-=-=-=-\nWelcome to Project P2G11:\nPress Enter to Start\nType 'e' to Exit")

conditions = [
'internet_access',
'internet_access.free',
'internet_access.for_customers',
'wheelchair',
'wheelchair.yes',
'wheelchair.limited','dogs',
'dogs.yes',
'dogs.leashed',
'no-dogs','access',
'access.yes',
'access.not_specified',
'access_limited',
'access_limited.private',
'access_limited.customers',
'access_limited.with_permit',
'access_limited.services',
'no_access',
'fee',
'no_fee',
'no_fee.not_specified',
'named',
'vegetarian',
'vegetarian.only',
'vegan',
'vegan.only',
'halal',
'halal.only',
'kosher',
'kosher.only',
'organic',
'organic.only',
'gluten_free',
'sugar_free',
'egg_free',
'soy_free']
	
worldmap = {'''
                                                   ::;::;:                       .                                                                          
                                   ::::;:;:;:;;:;:::::::::                  :;:::;:                                                                         
                                :;::.:::::;;:::::::::::::;;::                .;.                    ..              :;:.                                    
                            :;:;::;;;:::;:   ;;;:::::::::::;;.                                  :;:..         :;;:;:::::::                                  
                    .;::..:  .:.::::;::;:       :;:::::::::::;:                               .;:     ::.  ;;:::::::::::;;;::::;:    .:.                    
                   .::.:::::. .. .::::::        .::::::::::::;:                  .:::         .::    :::;::;::::::::::::::::::::;:;:::::;:::;:.             
                   ;:::;;::;.:;;::.;::;:::       ;:::::::::::                 ::::::;::;: .: .;:;:;;::::;:;:::::::::::::::::::::::::::::::::::;:;:::::;:    
  ::::;:;:::    :.:.. :::;:;:;..:;..:::::;:;:.   :::::::;:::.;:::.          .:::;::::::::::;;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::;:    
.:;::::::::::;::;::::::;:::::::::;:;::: ::::;::  .:::::::.   :::.         .::;;::;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;::     
:;:::::::::::::::::::::::::::::::;::::. .:;;;:;.  .::::;:                ::::::::;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;.:::::;.       
 ::::::::::::::::::::::::::::::::;:..:.....:;:.     :::;.           .:.  .;:::;..::;::::::::::::::::::::::::::::::::::::::::::::::::::.    . :::.           
 :::;:;:;::::::::::::::::::::::::.      :::;..:                    ::;:    ;:::::;::::::::::::::::::::::::::::::::::::::::::::::::::.       :;;:            
   .:;:.      ::;::::::::::::::::;:.    ::::::::                  .:::;;.:;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;;.    :;              
 ..            ..:::::::::::::::::::;;:.;:::::::;:                   :::;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::                    
                 .::::::::::::::::::::;:::::::::;::                   :::;:;::;:::::;:::;::::::::::::::::::::::::::::::::::::::::::;: :.                    
                   ::::::::::::::::::::::::;:;. .;;.               ;;;;;:..:;:::::;:..:..::::.:;::::::::::::::::::::::::::::::::;::  :::                    
                   :;:::::::::::::::::::::::;:;:.                  ::::.   . .:.::.;;:;:::::;: :::::::::::::::::::::::::::::::.;:    ::                     
                   :;:::::::::::::::::::::::                       .:::;::::.    ..  .:::::::;:::::::::::::::::::::::::::::::  ;;.::;;                      
                    ::::::::::::::::::::::                        .;::::::::;;:.:;::::::::::::::::::::::::::::::::::::::::::;:   ;                          
                     ::::::::::::::::::::                        :;::::::::::::::::::::;::::;::;::::;:::::::::::::::::::::::;.                              
                       ;:;::::::;;::;;:.                        ;:::::::::::::::::::::;::;:::;::;:   ::;::::::::::;::::::;;:.:                              
                        ;:;:::::      ::                       .;:::::::::::::::::::::::.:::::::;:    .::::::;  :::::::.:                                   
                         . :::::     :::                       ::::::::::::::::::::::::;;.;::::.       .;:;:.    ::;:;;:    ::                              
     .                      :;:;:::;.   ..;;:.                  :::::::::::::::::::::::::::..:.         .:;.       ::;:;     :..                            
                               ..:::;:                           :;:::::;:::::::::::::::::::::           ..;       ;. .    . .;:                            
                                    :;.                            .. .   .::::::::::::::::;:                       ;:   :;.                                
                                      .:;::::.                             ::::::::::::::::                            .                                    
                                      ;::::::::.                            :::::::::::::.                             :::    .:;                           
                                     ::::::::::::;:                          ;::::::::::;.                               ;;: ;;;::;. . ;:::.                
                                    .;:::::::::::::::.                      .:::::::::::::  .:                            :::..  ..     .:;;;:.:            
                                    :::::::::::::::::::;:.                  ::::::::::::: .;;:                                 .....:     .:..;.            
                                     :;:::::::::::::::::;.                  .::::::::::.  :;;                                       ::;:;. :;.              
                                      :;::::::::::::::::                     :;::::::;:.  .;:                                     :;::::::::::.             
                                        ::::::::::::::::                      ::::::::                                         ::;::::::::::::;:            
                                         ::::::::::::;:                        ;::;;.                                         :::::::::::::::::::           
                                         ;::::::::;:                                                                           ;::::::::::::::::;.          
                                        .::::::::::                                                                            .;;:;.   ::::::;::           
                                        ::::::::;:                                                                                        :;::;:          ;.
                                        ::::::;:                                                                                             :.          :;:
                                       .;::;;.                                                                                               :.        :;:  
                                       .;:::.                                                                                                          .    
                                       :::;:                                                                                                                
                                       :;::                                                                                                                 
                                        :::                                                                                                                 
'''}

# The 'CategoryDict' function creates a nested dictionary structure based on the categories read from the files
def CategoryDict(file_path, categories_list):
	category_dict = {}
	for item in categories_list:
		parts = item.split('.')
		current_dict = category_dict
		for part in parts:
			current_dict = current_dict.setdefault(part, {})     
	return category_dict

# The 'PrintInvalidCategory' and 'PrintInvalidCondition' functions print messages for invalid category and condition inputs respectively
def PrintInvalidCategory():
	print("\n______________________")
	print("Select a valid category")


def PrintInvalidCondition():
	print("\n______________________")
	print("Select a valid condition")

# The 'GetCategory' function prompts the user to select a category and subcategory for the search
def GetCategory(category_dict):
	keys = category_dict.keys()
	dic_1 = {}
	count1 = 0
	count2 = 0
	list_subcategory = []
	for key in keys:
		count1 += 1
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
		print("______________________________________________________________________")
		print("Select a subcategory (only the number corresponding to the subcategory)")
		category_input2 = input("To select the category as a whole, type '0'\n")
        
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
	if category_input2 == '0':
		category_final_input = key
	else:
		key2 = list_subcategory[int(category_input2)-1]
		category_final_input = key+'.'+key2
	return category_final_input
        
# The 'OpenMenu' function displays the main menu and handles user input to start or exit the program
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
			print("Try a valid option")
			continue

# The 'ConditionDict' function creates a dictionary structure for conditions
def ConditionDict(conditions):
	condition_dic = {}
	for condition in conditions:
		if '.' in condition:
			condition_list = condition.split('.')
			condition_dic[condition_list[0]]=condition_list[1]
		else:
			condition_dic[condition] = {}    
	return condition_dic
    
# The 'ConditionMenu' function displays a menu for selecting conditions to apply during the search
def ConditionMenu(conditions, condition_dic, condition_final):
	count3 = 0
	count4 = 0
	condition_list = []
	subcondition_list = []
	for condition in condition_dic:
		count3 += 1
		print(count3, ": ", condition, sep="")
		condition_list.append(condition)
	print(condition_list)
	while True:
		condition_input = int(input("Select a condition (number):\n"))
		if condition_input in range(0, len(condition_list)):
			return condition_list[int(condition_input) - 1]
			break
		else:
			print("Invalid condition input")
			continue
			
# The 'SearchMethod' function allows the user to choose a search method among Circle, Rectangle, or Proximity
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

# The 'PrintProperties' function prints the details of a location retrieved from the API    
def PrintProperties(name, country, city, adress, houseNumber, distance, LocalLat, LocalLon):
	print(f"\nName: {name}")
	print(f"Location: {country}, {city}, {adress} {houseNumber}")
	print(f"Coordinates: {LocalLat}, {LocalLon}")
	if distance != 'N/A':
		distance = int(distance)/1000
		print(f"Distance: {distance} km")
	print("------------------------")    

# The 'main' function orchestrates the flow of the program:		
def main():
	# It starts by displaying the main menu and getting the user's choice
	if OpenMenu():			
		category_dict2 = CategoryDict(file_path, categories_list)
		categories_input = GetCategory(category_dict2)
		while True:
			print("\nDo you want to add any more categories?")
			a = input("Type y/n?\n")
			if a == 'y':
				categories_input = categories_input +','+ GetCategory(category_dict2)
				continue
			elif a == 'n':
				break
			else:
				continue
		print("\nDo you wish to use conditions in your search?")
		conditions_url = ''
		condition_dic = ConditionDict(conditions)
		counter5=0
		while True:
			d = input("Type y/n?\n")
			if d == 'y':
				counter5+=1
				getcondition = ConditionMenu(conditions, condition_dic, conditions_url)
				getcondition = str(getcondition)
				if counter5 == 1:
					conditions_url = "&conditions=" + getcondition
				else:
					conditions_url = conditions_url+','+ getcondition 
				print("\nDo you want to add any more conditions")
				continue
			elif a == 'n':
				break
			else:
				continue
			
        # Based on user inputs, it retrieves categories, conditions, search method, coordinates, and other details for the search
		search = SearchMethod()
		
		if search == '1':
			coord_radius = input("Type the coordinates (separated by a coma) and the radius (separated by a space)\nExample: -8,40 50")
			coord_radius = coord_radius.split(" ")
			coordinates = coord_radius[0]
			radius = coord_radius[1]
			radius = int(radius) * 1000
		elif search == '2':
			coordinates = input("Please enter the 4 coordinates you would like to use for the search(separated by a coma, in this order lon1,lat1,lon2,lat2):")
		else:
			coordinates = input("Please enter the coordinates(separated by a coma): ")
		limit = int(input("Max amount of places you want to know? "))
		
		if search == '1':
			url = f"https://api.geoapify.com/v2/places?categories={categories_input}{conditions_url}&filter=circle:{coordinates},{radius}&limit={limit}&apiKey=dac9753ea77b449480d7c75540c7874a"
		elif search == '2':
			url = f"https://api.geoapify.com/v2/places?categories={categories_input}{conditions_url}&filter=rect:{coordinates}&limit={limit}&apiKey=dac9753ea77b449480d7c75540c7874a"
		else:
			url = f"https://api.geoapify.com/v2/places?categories={categories_input}{conditions_url}&bias=proximity:{coordinates}&limit={limit}&apiKey=dac9753ea77b449480d7c75540c7874a"
		headers = CaseInsensitiveDict()
		headers["Accept"] = "application/json"
		
		# It constructs a URL using the Geoapify API and sends a GET request to retrieve place information
		resp = requests.get(url, headers=headers)
		
		for line in worldmap:
			print(line)

		if resp.status_code == 200:
			data = resp.json()
			# Check if 'features' key exists in the response
			if 'features' in data:
				locations = data['features']

				# It processes the response and prints details for each location that meets the criteria	
				for location in locations:
					name = location['properties'].get('name', 'N/A')
					if name == 'N/A':
						continue
					country = location['properties'].get('country', 'N/A')
					city = location['properties'].get('city', 'N/A')
					adress = location['properties'].get('street','N/A')
					houseNumber = str(location['properties'].get('housenumber','None'))
					if houseNumber == 'None':
						houseNumber = ' '
					LocalLat = location["properties"].get("lat")
					LocalLon = location["properties"].get("lon")
					distance = location["properties"].get("distance",'N/A')
					
					# Output information					
					PrintProperties(name, country, city, adress, houseNumber, distance, LocalLat, LocalLon) 
				if len(locations)== 0:
					print("\nThere are no locations that fit your criteria, try again\n") # If no locations are found, it prompts the user to try again
					main()
			else:
				print("No 'features' found in the response.")
		else:
			print(f"Error: {resp.status_code}. Failed to fetch data.")
	else:
		quit()
        
# The main function is called when the script is run
if __name__ == "__main__":
	main()
