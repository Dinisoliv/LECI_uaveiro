def binSearch(lst, x):
	first = 0 
	last = len(lst)
	while first < last:
		mid = (first + last)//2
		elem = lst[mid]
		if x > elem:
			first = mid + 1
		elif x < elem:
			 last = mid
		else:
			return mid
	return first
    
#if x isnt found, returns where x sould be