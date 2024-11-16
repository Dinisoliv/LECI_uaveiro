def CSVfile(locations):
    # Specify the file name
    csv_file_path = "C:\Users\dinis\Desktop\P2G11\output.csv"
    
    csv_file = str(input("Do you want to export a csv file?/nType 'yes' or 'no'\n"))
    
    if csv_file == 'yes'
        # Write data to the CSV file
        with open(csv_file_path, mode='w', newline='') as file:
            # Create a CSV writer object
            csv_writer = csv.writer(file)

            # Write header
            csv_writer.writerow(["Name", "Country", "City", "Address", "House Number", "Distance", "Latitude", "Longitude"])

            # Write data
            for location in locations:
                name = location['properties'].get('name', 'N/A')
                country = location['properties'].get('country', 'N/A')
                city = location['properties'].get('city', 'N/A')
                address = location['properties'].get('street', 'N/A')
                house_number = str(location['properties'].get('housenumber', ' '))
                if houseNumber == 'None':
                    houseNumber = ' '
                local_lat = location["properties"].get("lat")
                local_lon = location["properties"].get("lon")
                distance = location["properties"].get("distance", 'N/A')

                # Write row to CSV
                csv_writer.writerow([name, country, city, address, house_number, distance, local_lat, local_lon])

        print(f"Data has been exported to {csv_file_path}"
        return True
    else:
        return False

def main():
    csv = csv_file(locations)
    if csv == True:
        print(f"Data has been exported to {csv_file_path}"
    else:
        pass
