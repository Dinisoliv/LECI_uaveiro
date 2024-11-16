#file_path = r'C:\Users\dinis\Desktop\P2G11\categories.txt'
#with open(file_path, 'r') as file:
    #category_dic = {}
    #for line in file:
        #parts = line.split('.')
        
        
def create_category_dict_from_file(file_path):
    try:
        with open(file_path, 'r') as file:
            category_list = [line.strip() for line in file.readlines()]
            category_dict = {}

            for item in category_list:
                parts = item.split('.')
                current_dict = category_dict

                for part in parts:
                    current_dict = current_dict.setdefault(part, {})

            return category_dict
    except FileNotFoundError:
        print(f"The file '{file_path}' was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

# Replace 'your_file_path.txt' with the actual path to your text file
file_path = r'C:\Users\dinis\Desktop\P2G11\categories.txt'
category_dict = create_category_dict_from_file(file_path)

# Example: Print the resulting dictionary
#import json
#print(json.dumps(category_dict, indent=2))

keys = category_dict.keys()

count1 = 0
count2 = 2
for i in keys:
    count1 += 1
    print(count1, ": ", i, sep="")
    print(count1, ".1:", i, sep="")
    for values in category_dict[i]:
        print(count1, ".", count2, ":", values, sep="")
        count2 += 1
    count2 = 2y
    
category = input("select a category")
