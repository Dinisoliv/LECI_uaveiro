def ConditionDict():
    condition_dict = {}
    condition1 = subcondition = 0
    conditions = ['internet_access','internet_access.free','internet_access.for_customers','wheelchair','wheelchair.yes','wheelchair.limited','dogs','dogs.yes','dogs.leashed','no-dogs','access','access.yes','access.not_specified','access_limited','access_limited.private','access_limited.customers','access_limited.with_permit','access_limited.services','no_access','fee','no_fee','no_fee.no','no_fee.not_specified','named','vegetarian','vegetarian.only','vegan','vegan.only','halal','halal.only','kosher','kosher.only','organic','organic.only','gluten_free','sugar_free','egg_free','soy_free']
    for condition in conditions:    
        condition_list = condition.split('.')
        print(condition_list)
    for condition in condition_list:
        if len(condition)>1:
            for n in range (1,len(condition)):
                condition_dict[condition[0]] = condition[n]
        else:
            condition_dict[condition] = {}
    print(condition_dict)
    
def ConditionMenu():
    
    count3 = 0
    dic_2 = {}
    for condition in condition_dict2:
        count3+=1
        print(count3, ": ", condition, sep="")
        dic_2[count3] = condition

    print("Type the number of the conditions")
    inp = input("Separate the numbers with coma")
    askedconditions_numbers = inp.split(",")
    print(askedconditions_numbers)
   
ConditionDict()      
#ConditionMenu()