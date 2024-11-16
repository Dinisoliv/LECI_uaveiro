def select_category(txt_file):
    # Read the text file and store the categories and subcategories
    with open(txt_file, 'r') as file:
        lines = file.readlines()
        categories = []
        subcategories = []
        for line in lines:
            line = line.strip()
            if line.startswith('#'):
                categories.append(line[1:])  # Remove the '#' from the category
            elif line.startswith('-'):
                subcategories.append(line[1:])  # Remove the '-' from the subcategory

    # Print the categories with their respective numbers
    for i, category in enumerate(categories, start=1):
        print(f"{i}. {category}")

    # Prompt the user to select a category
    category_number = int(input("Enter the category number: "))

    # Print the subcategories of the selected category with their respective numbers
    selected_category = categories[category_number - 1]
    for i, subcategory in enumerate(subcategories, start=1):
        print(f"{category_number}.{i}. {subcategory}")

    # Prompt the user to select a subcategory
    subcategory_number = int(input("Enter the subcategory number: "))

    # Generate the desired output format
    selected_subcategory = subcategories[subcategory_number - 1]
    result = f"{category_number}.{subcategory_number}"

    return result

# Example usage
txt_file = r'C:\Users\dinis\Desktop\P2G11\categories.txt'  # Replace with the path to your .txt file
selected = select_category(txt_file)
print(f"Selected category and subcategory: {selected}")