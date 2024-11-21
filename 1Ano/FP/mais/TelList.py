telList = ['977777777','924652343']
nameList = ['TUA PRIMA','TUA MAE']

def telToName(tel, telList, nameList):
	for i in range(len(telList)):
		if tel == telList[i]:
			name = nameList[i]
	return name
		
def nameToTels(name, telList, nameList):
	for i in range(len(nameList)):
		if name == nameList[i]:
			tel = telList[i]
	return tel		
		
def main():
	choice = input('Name or Phone Number? ')
	if choice == 'name' or 'Name':
		name = input('Name?')
		print(nameToTels(name, telList, nameList))
	else:
		tel = input('Tel? ')
		print(telToName(tel, telList, nameList))
	
main()
